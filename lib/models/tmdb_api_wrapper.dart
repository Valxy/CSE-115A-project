///TmdbApiWrapper provides functionality to make api calls to
///The Movie Database without having to worry about endpoints,
///verification, or handling the making and recieving of requests.
///
///Methods
///-------
///
/// Future<Movie> getDetailsMovies({required movieId}) async
///   Returns a completed movie object
///
/// Future<TvShow> getDetailsTvShow({required tvId}) async
///   Returns a completed tv show object
///
/// Future<List<MinimizedMovie>> getPopularMovies() async
///   Returns the top 20 most popular movies as a list of
///   minimized movie objects.
///
/// Future<List<MinimizedMovie>> getNowPlayingMovies() async
///   Returns a list of minimized movie objects representing
///   movies that are currently playing in theaters.
///
/// Future<List<MinimizedMovie>> getTopRatedMovies() async
///   Returns a list of minimized movie objects representing
///   the top 20 highest rated movies on TMDB.
///
/// Future<Movie> getLatestMovie() async
///   Returns a single complete movie object representing
///   the movie that was most recently added to TMDB.
///
///  Widget getImage({required posterPath, String size = "w500"})
///   Returns the Image at [posterPath] as an Image Widget with size [size].
///   Default size is set to w500.
///
///  Future<List<MinimizedTvShow>> getNowAiringTvShows() async
///   Returns a list of MinimizedTvShow objects representing shows
///   that are airing today.
///
/// Future<List<MinimizedTvShow>> getOnTheAirTvShow() async
///   Returns a list of MinimizedTvShow objects representing
///   tv shows that will air within the next 7 days
///
/// Future<List<MinimizedTvShow>> getPopularTvShows() async
///   Returns a list of MinimizedTvShow objects representing
///   popular tv shows
///
/// Future<List<MinimizedTvShow>> getTopRatedTvShows() async
///   Returns a list of MinimizedTvShow objects representing
///   the top rated tv shows.
///
///"Minimized" Movie objects
///-------------------------
/// are Movie objects
/// that have only the following data members:
///
///bool [adult], String? [backdropPath], int [id], String [originalTitle],
///double [popularity], String? [posterPath], String [releaseDate],
///String? [overview], String [title], bool [video], double [voteAverage],
///int [voteCount], List<Genre> [genres]
///
///Use the getDetailsMovie method to get a completed Movie
///object. Check the documentation for the Movie class for information
///on the completed movie object.
///
///
///"Minimized" TV Show Objects
///---------------------------
/// are TvShow objects that have only
/// the following data members:
///
///String [originalLanguage], String [originalName],
///List<ProductionCountry> [originCountries], String? [backdropPath],
///int [id], String [overview], double [popularity], String? [posterPath],
///String [firstAirDate], String [name], double [voteAverage],
///int [voteCount], List<Genre> [genres]
///
///Use the getDetailsTvShow method to get a completed TvShow object.
///Check the documentation for the TvShow class for information on
///the completed tv show object.
///
///

library tmdb_api_wrapper;

// import 'package:fk_user_agent/fk_user_agent.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:tmdb/models/src/errors.dart';
import 'package:tmdb/models/src/minimized_movie.dart';
import 'package:tmdb/models/src/minimized_tv_show.dart';
import 'package:tmdb/models/src/movie.dart';
import 'package:tmdb/models/src/tv_show.dart';
import 'package:tmdb/models/src/api_objects.dart';
import 'package:flutter/cupertino.dart';

export 'src/api_objects.dart'
    show
        ProductionCompany,
        Country,
        Genre,
        Video,
        Review,
        CastMember,
        CrewMember,
        Language;
export 'src/movie.dart' show Movie;
export 'src/minimized_movie.dart' show MinimizedMovie;
export 'src/tv_show.dart' show TvShow;
export 'src/minimized_tv_show.dart' show MinimizedTvShow;

class TmdbApiWrapper {
  static const String _apiKey = "b74073680e08dd4625e94ded81f2cb40";

  /// Keys are genre names, capitalized, spaces allowed
  /// values are the TMDB genre ids
  static Map genreDictionary = {
    "Action": 28, //movie only
    "Action & Adventure": 10759, //tv only
    "Adventure": 12, //movie only
    "Animation": 16,
    "Comedy": 35,
    "Crime": 80,
    "Documentary": 99,
    "Drama": 18,
    "Family": 10751,
    "Kids": 10762, //tv only
    "Fantasy": 14, //movie only
    "History": 36, //movie only
    "Horror": 27, //movie only
    "Music": 10402, //movie only
    "Mystery": 9648,
    "News": 10763, //tv only
    "Romance": 10749, //movie only
    "Science Fiction": 878, //movie only
    "Sci-Fi & Fantasy": 10765, //tv only
    "Talk": 10767, //tv only
    "TV Movie": 10770, //movie only
    "Thriller": 53, //movie only
    "War": 10752, //movie only
    "War & Politics": 10768, //tv only
    "Western": 37,
  };

  /// A helper object that holds the base url, and returns the
  /// response or handles the error appropriately
  final _ApiBaseHelper _helper = _ApiBaseHelper();

  // singleton class setup
  static final _tmdbApiWrapper = TmdbApiWrapper._internal();
  factory TmdbApiWrapper() {
    return _tmdbApiWrapper;
  }
  TmdbApiWrapper._internal();

  ///Returns a completed movie object. [movieId] can be found
  ///as a data member of a minimized Movie object.
  Future<Movie> getDetailsMovie({
    required movieId,
  }) async {
    final String endpoint =
        "movie/$movieId?api_key=$_apiKey&append_to_response=credits,images,recommendations,reviews,videos,release_dates";
    final responseJson = await _helper.get(endpoint);
    return Movie.fromJson(json: responseJson);
  }

  Future<List<MinimizedMovie>> getHorrorMovies() async {
    return getMovieListFromGenreId(genreId: genreDictionary['Horror']);
  }

  Future<List<MinimizedMovie>> getActionMovies() async {
    return getMovieListFromGenreId(genreId: genreDictionary['Action']);
  }

  Future<List<MinimizedMovie>> getRomanceMovies() async {
    return getMovieListFromGenreId(genreId: genreDictionary['Romance']);
  }

  Future<List<MinimizedMovie>> getAdventureMovies() async {
    return getMovieListFromGenreId(genreId: genreDictionary['Adventure']);
  }

  Future<List<MinimizedMovie>> getComedyMovies() async {
    return getMovieListFromGenreId(genreId: genreDictionary['Comedy']);
  }

  Future<List<MinimizedMovie>> getDramaMovies() async {
    return getMovieListFromGenreId(genreId: genreDictionary['Drama']);
  }

  Future<List<MinimizedMovie>> getMovieListFromGenreId(
      {required genreId}) async {
    final String endPoint =
        "discover/movie?api_key=$_apiKey&with_genres=$genreId";
    final responseJson = await _helper.get(endPoint);
    final List<dynamic> parsed = responseJson['results'];
    return _getMovieListFromJson(parsedList: parsed);
  }

  ///returns a completed tv show object. [tvId] can be found as
  ///a data member of a minimized tv show object.
  Future<TvShow> getDetailsTvShow({
    required tvId,
  }) async {
    final String endpoint =
        "tv/$tvId?api_key=$_apiKey&append_to_response=credits,images,recommendations,reviews,videos";
    final responseJson = await _helper.get(endpoint);
    return TvShow.fromJson(json: responseJson);
  }

  ///Returns the top 20 most popular movies
  ///as a list of minimized Movie objects.
  Future<List<MinimizedMovie>> getPopularMovies() async {
    final responseJson = await _helper.get("movie/popular?api_key=$_apiKey");
    final List<dynamic> parsed = responseJson['results'];
    return _getMovieListFromJson(parsedList: parsed);
  }

  ///Returns a list of minimized Movie objects representing
  ///movies currently playing in theaters
  Future<List<MinimizedMovie>> getNowPlayingMovies() async {
    final responseJson =
        await _helper.get("movie/now_playing?api_key=$_apiKey");
    final List<dynamic> parsed = responseJson['results'];
    return _getMovieListFromJson(parsedList: parsed);
  }

  ///Returns the 20 top rated movies
  ///as a list of minimized Movie objects.
  Future<List<MinimizedMovie>> getTopRatedMovies() async {
    final responseJson = await _helper.get("movie/top_rated?api_key=$_apiKey");
    final List<dynamic> parsed = responseJson['results'];
    return _getMovieListFromJson(parsedList: parsed);
  }

  ///Returns a single MinimizedMovie object representing
  ///the movie most recently added to TMDB
  Future<MinimizedMovie> getLatestMovie() async {
    final responseJson = await _helper.get("movie/latest?api_key=$_apiKey");
    return MinimizedMovie.fromJson(json: responseJson);
  }

  ///Returns the Image at [imagePath] as Widget
  Future<Widget> getImage({required imagePath, String size = "w500"}) async {
    if (imagePath != null && imagePath.isNotEmpty) {
      return await _helper.getImage(endPoint: imagePath, size: size);
    }
    return const SizedBox.shrink();
  }

  ///Allows searching TMDB for movies,
  ///tv shows and people in a single request.
  Future<List<dynamic>> search({
    required String query,
  }) async {
    final responseJson =
        await _helper.get("search/multi?api_key=$_apiKey&query=$query&page=1");
    final List<dynamic> parsed = responseJson['results'];
    List<dynamic> someThing =
        parsed.map((e) => _parseSearchResult(searchResult: e)).toList();
    return someThing;
  }

  ///Returns a list of MinimizedTvShow objects representing shows
  ///that are airing today.
  Future<List<MinimizedTvShow>> getNowAiringTvShows() async {
    final response = await _helper.get("tv/airing_today?api_key=$_apiKey");
    final List<dynamic> parsed = response['results'];
    return _getTvShowListFromJson(parsedList: parsed);
  }

  ///Returns a list of MinimizedTvShow objects representing
  ///tv shows that will air within the next 7 days
  Future<List<MinimizedTvShow>> getOnTheAirTvShows() async {
    final response = await _helper.get("tv/on_the_air?api_key=$_apiKey");
    final List<dynamic> parsed = response['results'];
    return _getTvShowListFromJson(parsedList: parsed);
  }

  ///Returns a list of MinimizedTvShow objects representing
  ///popular tv shows
  Future<List<MinimizedTvShow>> getPopularTvShows() async {
    final response = await _helper.get("tv/popular?api_key=$_apiKey");
    final List<dynamic> parsed = response['results'];
    return _getTvShowListFromJson(parsedList: parsed);
  }

  ///Returns a list of MinimizedTvShow objects representing
  ///the top rated tv shows.
  Future<List<MinimizedTvShow>> getTopRatedTvShows() async {
    final response = await _helper.get("tv/top_rated?api_key=$_apiKey");
    final List<dynamic> parsed = response['results'];
    return _getTvShowListFromJson(parsedList: parsed);
  }

  List<MinimizedTvShow> _getTvShowListFromJson({
    required List<dynamic> parsedList,
  }) {
    List<MinimizedTvShow> list =
        parsedList.map((element) => _getTvShowFromJson(json: element)).toList();
    return list;
  }

  dynamic _parseSearchResult({
    required searchResult,
  }) {
    switch (searchResult['media_type']) {
      case "person":
        {
          return Person.fromArguments(
              creditId: "",
              profilePath: searchResult['profile_path'],
              name: searchResult['name'],
              id: searchResult['id'],
              adult: searchResult['adult'],
              gender: 0,
              popularity: searchResult['popularity']);
        }
      case "tv":
        {
          return _getTvShowFromJson(json: searchResult);
        }
      case "movie":
        {
          return _getMovieFromJson(json: searchResult);
        }
    }
  }

  MinimizedTvShow _getTvShowFromJson({
    required Map json,
  }) {
    return MinimizedTvShow.fromJson(json: json);
  }

  ///Helper function to parse a json result into a movie object
  MinimizedMovie _getMovieFromJson({
    required Map json,
  }) {
    return MinimizedMovie.fromJson(json: json);
  }

  List<MinimizedMovie> _getMovieListFromJson({
    required List<dynamic> parsedList,
  }) {
    List<MinimizedMovie> list =
        parsedList.map((element) => _getMovieFromJson(json: element)).toList();
    return list;
  }

  ///recieves access denied error
  ///possibly to do with authentication
  ///(the 'header' argument to http.get)
  ///
  ///Attempted to use fk_user_agent package to get
  ///device userAgent, but recieved an 'Unexpected Null Value'
  ///error on FkUserAgent.init(). Only tested on Chrome, should
  ///check if FkUserAgent works on phone emulator.
  Future<void> getDailyExports() async {
    const String url =
        "http://files.tmdb.org/p/exports/movie_ids_01_01_2022.json.gz/";
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {'User-Agent': 'Chrome/97.0.4692.71'},
    );
    //print(response.body);
  }
}

class _ApiBaseHelper {
  final String _baseUrl = "http://api.themoviedb.org/3/";
  final String _baseImageUrl = "https://image.tmdb.org/t/p/";
  final _cacheManager = _DataCacheManager();
  final _cache = DefaultCacheManager();

  //final _DataCacheManager _dataCacheManager = _DataCacheManager();
  //final _ImageCacheManager _imageCacheManager = _ImageCacheManager();
  Future<dynamic> get(String endPoint) async {
    dynamic responseJson;
    try {
      responseJson = await _cacheManager.getSingleFile(_baseUrl + endPoint);
    } on SocketException {
      throw FetchDataException(message: 'No Internet connection');
    } on HttpExceptionWithStatus catch (e) {
      _handleHttpExceptionWithStatus(exception: e);
      rethrow;
    }
    return json.decode(responseJson);
  }

  Future<Widget> getImage({
    required String endPoint,
    String size = "w500",
  }) async {
    dynamic response =
        await _cache.getSingleFile("$_baseImageUrl$size$endPoint");
    return Image.file(response);
  }

  void _handleHttpExceptionWithStatus({
    required HttpExceptionWithStatus exception,
  }) {
    switch (exception.statusCode) {
      case 200:
      // do nothing. shouldnt get here, this is a valid response.
      case 400:
        throw BadRequestException(message: exception.message);
      case 401:
      case 403:
        throw UnauthorisedException(message: exception.message);
      case 404:
        throw PageNotFoundException(message: exception.message);
      case 500:
      default:
        throw FetchDataException(
            message:
                'Error occured while Communication with Server with StatusCode : ${exception.statusCode}');
    }
  }
}

class _DataCacheManager {
  static const key = 'tmdbCache';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 14),
      maxNrOfCacheObjects: 300,
    ),
  );
  Future<String> getSingleFile(url) async {
    final File file = await instance.getSingleFile(url);
    return await file.readAsString(encoding: utf8);
  }
  // Image getImage
}
