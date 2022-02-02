library tmdb_api_wrapper;

import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

///TmdbApiWrapper provides functionality to make api calls to
///The Movie Database without having to worry about endpoints,
///verification, or handling the making and recieving of requests.
///
//////"Minimized" Movie objects are Movie objects
///missing the following data members:
///
///[belongsToCollection, budget, genres, homepage,
///imdbId, productionCompanies, productionCountries,
///revenue, spokenLanguages, status, tagline]
///
///Use the getDetailsMovies method to get a completed Movie
///object
///
///Methods:
///
/// Future<Movie> getDetailsMovies({required movieId}) async
///   Returns a completed movie object
///
/// Widget getImage({required posterPath})
///   Returns the Image at [posterPath] as an Image Widget
///
/// Future<List<Movie>> getPopularMovies() async
///   Returns a list of minimized Movie objects representing the most
///   popular movies
///
/// Future<Movie> getLatestMovie() async
///   Returns a single Movie object representing
///   the movie most recently added to TMDB
///
/// Future<List<Movie>> getNowPlayingMovies() async
///   Returns a list of minimized Movie objects representing movies
///   that are now playing in theaters
///
/// Future<List<Movie>> getTopRatedMovies() async
///   Returns a list of minimized Movie objects representing the top
///   rated movies on TMDB
///

class TmdbApiWrapper {
  String apiKey;
  final ApiBaseHelper _helper = ApiBaseHelper();
  TmdbApiWrapper({this.apiKey = "b74073680e08dd4625e94ded81f2cb40"});

  ///Returns a completed movie object. [movieId] can be found
  ///as a data member of a minimized Movie object.
  Future<Movie> getDetailsMovie({required movieId}) async {
    final String endpoint =
        "movie/$movieId?api_key=$apiKey&append_to_response=credits,images,recommendations,reviews,videos";
    final responseJson = await _helper.get(endpoint);
    return Movie.fromJson(json: responseJson);
  }

  ///Returns the top 20 most popular movies
  ///as a list of minimized Movie objects.
  Future<List<Movie>> getPopularMovies() async {
    final responseJson = await _helper.get("movie/popular?api_key=$apiKey");
    final List<dynamic> parsed = responseJson['results'];
    return _getMovieListFromJson(parsed);
  }

  ///Returns a single Movie object representing
  ///the movie most recently added to TMDB
  Future<Movie> getLatestMovie() async {
    final responseJson = await _helper.get("movie/latest?api_key=$apiKey");
    return Movie(
      title: responseJson['title'],
      id: responseJson['id'],
      adult: responseJson['adult'],
      backdropPath: responseJson['backdrop_path'],
      originalLanguage: responseJson['original_language'],
      originalTitle: responseJson['original_title'],
      overview: responseJson['overview'],
      popularity: responseJson['popularity'],
      posterPath: responseJson['poster_path'],
      releaseDate: responseJson['release_date'],
      video: responseJson['video'],
      voteAverage: responseJson['vote_average'],
      voteCount: responseJson['vote_count'],
      genres: responseJson['genre_ids'],
    );
  }

  ///Returns a list of minimized Movie objects representing
  ///movies currently playing in theaters
  Future<List<Movie>> getNowPlayingMovies() async {
    final responseJson = await _helper.get("movie/now_playing?api_key=$apiKey");
    final List<dynamic> parsed = responseJson['results'];
    return _getMovieListFromJson(parsed);
  }

  ///Returns the 20 top rated movies
  ///as a list of minimized Movie objects.
  Future<List<Movie>> getTopRatedMovies() async {
    final responseJson = await _helper.get("movie/top_rated?api_key=$apiKey");
    final List<dynamic> parsed = responseJson['results'];
    return _getMovieListFromJson(parsed);
  }

  ///Returns the Image at [posterPath] as Image Widget
  Widget getImage({required posterPath}) {
    return Image.network("http://api.themoviedb.org/3" + posterPath);
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
    //print(response.body);
  }

  List<Movie> _getMovieListFromJson(List<dynamic> parsedList) {
    List<Movie> list = parsedList
        .map((element) => Movie(
              title: element['title'],
              id: element['id'],
              adult: element['adult'],
              backdropPath: element['backdrop_path'],
              originalLanguage: element['original_language'],
              originalTitle: element['original_title'],
              overview: element['overview'],
              popularity: element['popularity'],
              posterPath: element['poster_path'],
              releaseDate: element['release_date'],
              video: element['video'],
              voteAverage: element['vote_average'],
              voteCount: element['vote_count'],
              genres: element['genre_ids'],
            ))
        .toList();
    return list;
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
    if (releaseDateLower != null && !_isValidDate(releaseDateLower)) {
      throw InvalidDateException();
    }
    if (releaseDateUpper != null && !_isValidDate(releaseDateUpper)) {
      throw InvalidDateException();
    }

    final responseJson = await _helper.get("discover/movie?=$apiKey");
    final List parsed = responseJson['results'];
    return _getMovieListFromJson(parsed);
  }

  bool _isValidDate(String toCheck) {
    try {
      DateTime.parse(toCheck);
    } catch (e) {
      return false;
    }
    return true;
  }

  bool _isValidLanguageCode(String toCheck) {
    return true;
  }

  bool _isValidCountryCode(String toCheck) {
    return true;
  }
}

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

class Video {
  String? language;
  String? country;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? publishedAt;
  String? id;
  String? youtubeUrl;
  Video(
      {this.country,
      this.id,
      this.key,
      this.language,
      this.name,
      this.official,
      this.publishedAt,
      this.site,
      this.size,
      this.type,
      this.youtubeUrl});
  Video.fromJson({required Map json, String? url}) {
    country = json['country'];
    id = json['id'];
    key = json['key'];
    language = json['language'];
    name = json['name'];
    official = json['official'];
    publishedAt = json['published_at'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
    youtubeUrl = url;
  }

  @override
  String toString() {
    return "site: $site key: $key url: $youtubeUrl";
  }
}

class Review {
  String? author;
  dynamic authorDetails;
  String? content;
  String? createdAt;
  String? id;
  String? updatedAt;
  String? url;
  Review(
      {this.author,
      this.authorDetails,
      this.content,
      this.createdAt,
      this.id,
      this.updatedAt,
      this.url});
  Review.fromJson({required Map json}) {
    author = json['author'];
    authorDetails = json['author_details'];
    content = json['content'];
    createdAt = json['created_at'];
    id = json['id'];
    updatedAt = json['updated_at'];
    url = json['url'];
  }
}

class MovieImage {
  double? aspectRatio;
  String? filePath;
  int? height;
  String? language;
  double? voteAverage; //api docs say integer, but it's a 'number' (double)
  int? voteCount;
  int? width;
  MovieImage(
      {this.aspectRatio,
      this.filePath,
      this.height,
      this.language,
      this.voteAverage,
      this.voteCount,
      this.width});
  MovieImage.fromJson({required Map json}) {
    aspectRatio = json['aspect_ratio'];
    filePath = json['file_path'];
    height = json['height'];
    language = json['iso_639_1'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }
}

class CastMember {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;
  CastMember(
      {this.adult,
      this.gender,
      this.id,
      this.knownForDepartment,
      this.name,
      this.order,
      this.castId,
      this.character,
      this.creditId,
      this.originalName,
      this.popularity,
      this.profilePath});

  CastMember.fromJson({required Map json}) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    order = json['order'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }
}

class CrewMember {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? creditId;
  String? department;
  String? job;
  CrewMember(
      {this.adult,
      this.gender,
      this.id,
      this.knownForDepartment,
      this.name,
      this.department,
      this.job,
      this.creditId,
      this.originalName,
      this.popularity,
      this.profilePath});

  CrewMember.fromJson({required Map json}) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    department = json['department'];
    job = json['job'];
    creditId = json['credit_id'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }
}

class Movie {
  bool? adult;
  String? backdropPath;
  dynamic belongsToCollection;
  int? budget;

  //genres = [{int id:, String name:},]
  List<dynamic>? genres;

  String? homepage;
  int? id;

  //minLength: 9, maxLength: 9
  //pattern: ^tt[0-9]{7}
  String? imdbId;

  //iso 639-1 language code
  String? originalLanguage;

  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;

  //prdCo = [{String name:, int id:,
  //String? logo_path:, String origin_country:},]
  List<dynamic>? productionCompanies;

  //prdCou = [{String iso_3166_1:, String name:},]
  //iso_3166_1 refers to ISO 3166-1 country naming standard
  List<dynamic>? productionCountries;

  String? releaseDate;
  int? revenue;
  int? runtime;

  //lang = [{String iso_639_1:, String name: },]
  //iso_639_1 refers to ISO 639-1 langauge naming standard
  List<dynamic>? spokenLanguages;

  //Allowed values = [Rumored, Planned, In Production,
  //Post Production, Released, Canceled]
  String? status;

  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  List<CastMember>? cast;
  List<CrewMember>? crew;
  List<Review>? reviews;
  List<Widget>? backdrops;
  List<Widget>? posters;
  List<Movie>? recommendations;
  List<Video>? videos;

  Movie({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });
  Movie.fromJson({required Map json}) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    belongsToCollection = json['belongs_to_collection'];
    budget = json['budget'];
    genres = json['genres'];
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    productionCompanies = json['production_companies'];
    productionCountries = json['production_countries'];
    releaseDate = json['release_date'];
    revenue = json['revenue'];
    runtime = json['runtime'];
    spokenLanguages = json['spoken_languages'];
    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    _parseCredits(json: json['credits']);
    _parseVideos(json: json['videos']);
    _parseReviews(json: json['reviews']);
    _parseRecommendations(json: json['recommendations']);
    _parseImages(json: json['images']);
  }

  void _parseImages({required Map json}) {
    if (json['backdrops'] != null) {
      final List<dynamic> backdrops = json['backdrops'];
      this.backdrops =
          backdrops.map((el) => Image.network(el['file_path'])).toList();
    }
    if (json['posters'] != null) {
      final List<dynamic> posters = json['posters'];
      this.posters = posters
          .map((el) => Image.network(
              "https://image.tmdb.org/t/p/w500" + el['file_path']))
          .toList();
    }
  }

  ///Returns the poster for this movie as an Image widget
  ///[scale] currently does nothing
  Widget getPoster({scale = 1}) {
    if (posterPath != null && posterPath!.isNotEmpty) {
      final url = "http://api.themoviedb.org/3" + posterPath!;
      return Image.network(url);
    }
    return const SizedBox.shrink();
  }

  void _parseCredits({required Map json}) {
    if (json['cast'] != null) {
      final List<dynamic> castList = json['cast'];
      cast = castList.map((el) => CastMember.fromJson(json: el)).toList();
    }

    if (json['crew'] != null) {
      final List<dynamic> crewList = json['crew'];
      crew = crewList.map((el) => CrewMember.fromJson(json: el)).toList();
    }
  }

  void _parseRecommendations({required Map json}) {
    if (json['results'] != null) {
      final List<dynamic> parsedList = json['results'];
      recommendations = parsedList
          .map((element) => Movie(
                title: element['title'],
                id: element['id'],
                adult: element['adult'],
                backdropPath: element['backdrop_path'],
                originalLanguage: element['original_language'],
                originalTitle: element['original_title'],
                overview: element['overview'],
                popularity: element['popularity'],
                posterPath: element['poster_path'],
                releaseDate: element['release_date'],
                video: element['video'],
                voteAverage: element['vote_average'],
                voteCount: element['vote_count'],
                genres: element['genre_ids'],
              ))
          .toList();
    }
  }

  void _parseVideos({required Map json}) {
    if (json['results'] != null) {
      final List<dynamic> parsedList = json['results'];
      videos = parsedList.map((el) {
        final url = "https://www.youtube.com/watch?v=${el['key']}";
        return Video.fromJson(json: el, url: url);
      }).toList();
    }
  }

  void _parseReviews({required Map json}) {
    if (json['results'] != null) {
      final List<dynamic> parsedList = json['results'];
      reviews = parsedList.map((el) => Review.fromJson(json: el)).toList();
    }
  }

  @override
  String toString() {
    return "Movie: $title id: $id video: $video";
  }
}
