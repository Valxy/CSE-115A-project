import 'package:flutter/cupertino.dart';
import './api_objects.dart';
import './minimized_movie.dart';

///The "completed" Movie class. A Movie object
///is an object that represents a movie on the tmdb database.
class Movie extends MinimizedMovie {
  ///minLength: 9, maxLength: 9,
  ///pattern: ^tt[0-9]{7}
  String? imdbId;

  ///Allowed values = [Rumored, Planned, In Production,
  ///Post Production, Released, Canceled]
  late String status;
  dynamic belongsToCollection;
  late int budget;
  String? homepage;
  late int revenue;
  int? runtime;
  String? tagline;
  late List<Language> spokenLanguages;
  late List<ProductionCompany> productionCompanies;
  late List<Country> productionCountries;
  late List<CastMember> cast;
  late List<CrewMember> crew;
  late List<Review> reviews;
  late List<Widget> backdrops;
  late List<Widget> posters;
  late List<MinimizedMovie> recommendations;
  late List<Video> videos;
  late List<Release> releases;

  Movie.fromJson({
    required Map json,
  }) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    belongsToCollection = json['belongs_to_collection'];
    budget = json['budget'];
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    revenue = json['revenue'];
    runtime = json['runtime'];
    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];

    _parseLanguages(json: json['spoken_languages']);
    _parseCompanies(json: json['production_companies']);
    _parseCountries(json: json['production_countries']);

    _parseGenres(json: json['genres']);
    _parseCredits(json: json['credits']);

    _parseVideos(json: json['videos']);
    _parseReviews(json: json['reviews']);
    _parseRecommendations(json: json['recommendations']);

    _parseImages(json: json['images']);

    _parseReleaseDates(json: json['release_dates']);
  }

  void _parseReleaseDates({
    required Map json,
  }) {
    releases = [];
    final List<dynamic> parsed = json['results'];
    if (parsed.isNotEmpty) {
      for (var i = 0; i < parsed.length; i++) {
        List<dynamic> jsonReleaseDate = parsed[i]['release_dates'];
        for (var j = 0; j < jsonReleaseDate.length; j++) {
          releases.add(Release.fromJson(json: jsonReleaseDate[j]));
        }
      }
    }
  }

  void _parseLanguages({
    required List<dynamic> json,
  }) {
    if (json.isNotEmpty) {
      spokenLanguages = json.map((e) => Language.fromJson(json: e)).toList();
    } else {
      spokenLanguages = [];
    }
  }

  void _parseCompanies({
    required List<dynamic> json,
  }) {
    if (json.isNotEmpty) {
      productionCompanies =
          json.map((el) => ProductionCompany.fromJson(json: el)).toList();
    } else {
      productionCompanies = [];
    }
  }

  void _parseCountries({
    required List<dynamic> json,
  }) {
    if (json.isNotEmpty) {
      productionCountries =
          json.map((el) => Country.fromJson(json: el)).toList();
    } else {
      productionCountries = [];
    }
  }

  void _parseGenres({
    required List<dynamic> json,
  }) {
    if (json.isNotEmpty) {
      genres = json.map((el) => Genre.fromJson(json: el)).toList();
    } else {
      genres = [];
    }
  }

  void _parseImages({
    required Map json,
  }) {
    if (json['backdrops'] != null && json['backdrops']!.isNotEmpty) {
      final List<dynamic> backdrops = json['backdrops'];
      this.backdrops =
          backdrops.map((el) => getImage(imagePath: el['file_path'])).toList();
    } else {
      backdrops = [];
    }
    if (json['posters'] != null && json['posters']!.isNotEmpty) {
      final List<dynamic> posters = json['posters'];
      this.posters =
          posters.map((el) => getImage(imagePath: el['file_path'])).toList();
    } else {
      posters = [];
    }
  }

  void _parseCredits({
    required Map json,
  }) {
    if (json['cast'] != null) {
      final List<dynamic> castList = json['cast'];
      cast = castList.map((el) => CastMember.fromJson(json: el)).toList();
    }

    if (json['crew'] != null) {
      final List<dynamic> crewList = json['crew'];
      crew = crewList.map((el) => CrewMember.fromJson(json: el)).toList();
    }
  }

  ///can't use Movie.fromJson since these will me minimized movie objects
  void _parseRecommendations({
    required Map json,
  }) {
    if (json['results'] != null) {
      final List<dynamic> parsedList = json['results'];
      recommendations = parsedList
          .map((element) => MinimizedMovie.fromJson(json: element))
          .toList();
    }
  }

  void _parseVideos({
    required Map json,
  }) {
    if (json['results'] != null) {
      final List<dynamic> parsedList = json['results'];
      videos = parsedList.map((el) {
        return Video.fromJson(json: el);
      }).toList();
    }
  }

  void _parseReviews({
    required Map json,
  }) {
    if (json['results'] != null) {
      final List<dynamic> parsedList = json['results'];
      reviews = parsedList.map((el) => Review.fromJson(json: el)).toList();
    }
  }

  @override
  String toString() {
    return "Movie: $title id: $id";
  }
}
