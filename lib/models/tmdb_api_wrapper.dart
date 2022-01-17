library tmdb_api_wrapper;

import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class AppException implements Exception {
  final String message;
  final String prefix;
  AppException({required this.message, required this.prefix});

  @override
  String toString() {
    return "$prefix$message";
  }
}

class InvalidDateException extends AppException {
  InvalidDateException({message})
      : super(
          message: message,
          prefix: "Invalid Date",
        );
}

class FetchDataException extends AppException {
  FetchDataException({message})
      : super(
          message: message,
          prefix: "Error During Communication: ",
        );
}

class BadRequestException extends AppException {
  BadRequestException({message})
      : super(
          message: message,
          prefix: "Invalid Request: ",
        );
}

class UnauthorisedException extends AppException {
  UnauthorisedException({message})
      : super(
          message: message,
          prefix: "Unauthorized: ",
        );
}

class InvalidInputException extends AppException {
  InvalidInputException({message})
      : super(
          message: message,
          prefix: "Invalid Input: ",
        );
}

class ApiBaseHelper {
  final String _baseUrl = "http://api.themoviedb.org/3/";

  Future<dynamic> get(String endPoint) async {
    dynamic responseJson;
    try {
      final url = Uri.parse(_baseUrl + endPoint);
      final response = await http.get(url);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: 'No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(message: response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(message: response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            message:
                'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

class Movie {
  String title;
  int id;
  double voteAverage;
  bool adult;
  List genreIds;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  String synopsis;
  double popularity;
  String posterPath;
  String releaseDate;
  bool video;
  int voteCount;
  List videoUrls = [];
  Movie({
    required this.title,
    required this.id,
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalTitle,
    required this.synopsis,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
  Movie.fromJson({
    required this.title,
    required this.id,
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalTitle,
    required this.synopsis,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  ///Returns the poster for this movie as an Image widget
  Widget getPoster({scale = 1}) {
    if (posterPath.isEmpty) {
      return const SizedBox.shrink();
    }
    final url = "http://api.themoviedb.org/3" + posterPath;
    return Image.network(url);
  }

  @override
  String toString() {
    return "Movie: $title id: $id release date: $releaseDate";
  }
}

class TmdbApiWrapper {
  String apiKey;
  final ApiBaseHelper _helper = ApiBaseHelper();

  TmdbApiWrapper({this.apiKey = "b74073680e08dd4625e94ded81f2cb40"});

  ///returns the top 20 most popular movies
  Future<List<Movie>> getPopularMovies() async {
    final responseJson = await _helper.get(
        "discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc");
    final List parsed = responseJson['results'];
    return _getMovieListFromJson(parsed);
  }

  ///recieves access denied error
  ///possibly to do with authentication
  ///(the 'header' argument to http.get)
  ///
  ///Attempted to use fk_user_agent package to get
  ///device userAgent, but recieved an 'Unexpected Null Value'
  ///error on FkUserAgent.init(). Only tested on Chrome, should
  ///check if FkUserAgent works on phone emulator
  Future<void> getDailyExports() async {
    const String url =
        "http://files.tmdb.org/p/exports/movie_ids_01_01_2022.json.gz/";
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {'User-Agent': 'Chrome/97.0.4692.71'},
    );
    print(response.body);
  }

  List<Movie> _getMovieListFromJson(List<dynamic> parsedList) {
    List<Movie> list = parsedList
        .map((element) => Movie.fromJson(
              title: element['title'],
              id: element['id'],
              adult: element['adult'],
              backdropPath: element['backdrop_path'],
              genreIds: element['genre_ids'],
              originalLanguage: element['original_language'],
              originalTitle: element['original_title'],
              synopsis: element['overview'],
              popularity: element['popularity'],
              posterPath: element['poster_path'],
              releaseDate: element['release_date'],
              video: element['video'],
              voteAverage: element['vote_average'],
              voteCount: element['vote_count'],
            ))
        .toList();
    return list;
  }

  ///intended to return a list of free movies,
  ///but 'movie/free' endpoint likely does not exist.
  Future<List<Movie>> getFreeMovies() async {
    final responseJson = await _helper.get("movie/free?api_key=$apiKey");
    final List parsed = responseJson['results'];
    return _getMovieListFromJson(parsed);
  }

  ///Planned to be replaced by this.getMovies()
  ///
  ///returns a list of movies ordered by rating
  ///
  ///if [lessThan] is used, only movies with rating less than [lessThan] are displayed
  ///if [greaterThan] is used, only movies with rating greater than [greaterThan] are displayed
  ///both parameters may be used to restrict the search to a particular range of ratings
  Future<List<Movie>> getMoviesByRating(
      {lessThan = 10, greaterThan = 0}) async {
    dynamic responseJson;
    if (lessThan == null && greaterThan == null) {
      responseJson = await _helper.get(
          "discover/movie?api_key=$apiKey&language=en-US&sort_by=vote_average.desc");
    } else {
      responseJson = await _helper.get(
          "discover/movie?api_key=$apiKey&language=en-US&sort_by=vote_average.desc&vote_average.gte=$greaterThan&vote_average.lte=$lessThan");
    }
    final List parsed = responseJson['results'];
    return _getMovieListFromJson(parsed);
  }

  Future<List<Movie>> getMovies({
    sortBy = "vote_average.desc",
    includeAdult = "false",
    includeVideo = "false",
    releaseYear,
    releaseDateLower,
    releaseDateUpper,
    minimumVoteAverage,
    maximumVoteAverage,
    withActors,
    withGenres,
    withKeywords,
    minimumRuntime,
    maximumRuntime,
    language = "en-US",
    originalLanguage = "en-US",
  }) async {
    try {
      if (releaseDateLower != null) {
        final lowerReleaseDate = DateTime.parse(releaseDateLower);
      }
      if (releaseDateUpper != null) {
        final upperReleaseDate = DateTime.parse(releaseDateUpper);
      }
    } catch (e) {
      throw InvalidDateException();
    }

    final responseJson = await _helper.get("discover/movie?=$apiKey");
    final List parsed = responseJson['results'];
    return _getMovieListFromJson(parsed);
  }
}
