import 'package:flutter/cupertino.dart';
import './api_objects.dart';
import './minimized_movie.dart';

///The "completed" Movie class. A Movie object
///is an object that represents a movie on the tmdb database.
class Movie extends MinimizedMovie {
  //minLength: 9, maxLength: 9,
  //pattern: ^tt[0-9]{7}
  ///IMDB movie id.
  late String imdbId;

  ///Status of the movie, one of [Rumored, Planned, In Production,
  ///Post Production, Released, Canceled].
  late String status;

  //Unused. Not even sure what it is.
  //dynamic belongsToCollection;
  late int budget;

  ///URL to the homepage of the movie.
  late String homepage;

  ///The revenue of the movie.
  late int revenue;

  ///The length of the movie in minutes.
  late int runtime;

  ///A one sentence overview of the movie.
  late String tagline;

  ///A list of language objects representing the languages
  ///that are spoken in the movie.
  late List<Language> spokenLanguages;

  ///A list of ProductionCompany objects representing the
  ///companies involved in the production of the movie.
  late List<ProductionCompany> productionCompanies;

  ///A list of country objects representing the countries
  ///where the movie was produced.
  late List<Country> productionCountries;

  ///A list of CastMember objects representing the cast
  ///of the movie.
  late List<CastMember> cast;

  ///A list of CrewMember objects representing the crew
  ///of the movie.
  late List<CrewMember> crew;

  ///A list of Review objects representing the reviews that
  ///have been left for the movie.
  late List<Review> reviews;

  ///A list of Widgets that are the backdrops for the movie.
  List<Widget> backdrops = [];

  ///An image widget for the poster of the movie
  late Widget poster;

  ///A list of Widgets that are the posters for the movie.
  //List<Widget> posters = [];

  ///A list of MinimizedMovie objects representing a list
  ///of recommendations based off of this movie.
  late List<MinimizedMovie> recommendations;

  ///List of Video objects representing the videos associated with this movie.
  late List<Video> videos;

  ///A list of Release objects representing the releases of this movie.
  ///This release objects hold the rating ('G', 'PG', 'R', etc).
  late List<Release> releases;

  Movie.fromJson({
    required Map json,
  }) {
    if (json['adult'] != null) {
      adult = json['adult'];
    } else {
      adult = true;
    }
    if (json['backdrop_path'] != null) {
      backdropPath = json['backdrop_path'];
    } else {
      backdropPath = "";
    }
    if (json['budget'] != null) {
      budget = json['budget'];
    } else {
      budget = 0;
    }
    if (json['homepage'] != null) {
      homepage = json['homepage'];
    } else {
      homepage = "";
    }
    if (json['id'] != null) {
      id = json['id'];
    } else {
      id = 0;
    }
    if (json['imdb_id'] != null) {
      imdbId = json['imdb_id'];
    } else {
      imdbId = "";
    }
    if (json['original_language'] != null) {
      originalLanguage = json['original_language'];
    } else {
      originalLanguage = "";
    }
    if (json['original_title'] != null) {
      originalTitle = json['original_title'];
    } else {
      originalTitle = "";
    }
    if (json['overview'] != null) {
      overview = json['overview'];
    } else {
      overview = "";
    }
    if (json['popularity'] != null) {
      popularity = json['popularity'];
    } else {
      popularity = 0;
    }
    if (json['poster_path'] != null) {
      posterPath = json['poster_path'];
    } else {
      posterPath = "";
    }
    if (json['release_date'] != null) {
      releaseDate = json['release_date'];
    } else {
      releaseDate = "";
    }
    if (json['revenue'] != null) {
      revenue = json['revenue'];
    } else {
      revenue = 0;
    }
    if (json['runtime'] != null) {
      runtime = json['runtime'];
    } else {
      runtime = 0;
    }
    if (json['status'] != null) {
      status = json['status'];
    } else {
      status = "";
    }
    if (json['tagline'] != null) {
      tagline = json['tagline'];
    } else {
      tagline = "";
    }
    if (json['title'] != null) {
      title = json['title'];
    } else {
      title = "";
    }
    if (json['video'] != null) {
      video = json['video'];
    } else {
      video = false;
    }
    if (json['vote_average'] != null) {
      voteAverage = json['vote_average'];
    } else {
      voteAverage = 0;
    }
    if (json['vote_count'] != null) {
      voteCount = json['vote_count'];
    } else {
      voteCount = 0;
    }
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
        String iso31661 = parsed[i]['iso_3166_1'];
        List<dynamic> jsonReleaseDate = parsed[i]['release_dates'];
        // Currently only returning releases from the US.
        if (iso31661 == 'US') {
          for (var j = 0; j < jsonReleaseDate.length; j++) {
            Release rel = Release.fromJson(json: jsonReleaseDate[j]);
            rel.country = iso31661;
            releases.add(rel);
          }
        }
      }
    }
    //Guarantee at least some
    //dummy element exists in releases
    if (releases.isEmpty) {
      Release rel = Release();
      rel.certification = "NA";
      rel.releaseDate = "0000-00-00";
      rel.type = 0;
      rel.note = "NA";
      releases.add(rel);
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
    // Only the first poster in the list is ever used, but
    // [poster] data member was never called.
    if (posterPath != "") {
      poster = getImage(imagePath: posterPath);
    } else if (json['posters'] != null && !json['posters'].isEmpty) {
      List<dynamic> posters = json['posters'];
      poster = getImage(imagePath: posters[0]['file_path']);
    } else {
      //this might cause a hang up if the flow ever gets here.
      poster = const SizedBox.shrink();
    }

    const int maxPicCapacity = 6;
    if (json['backdrops'] != null && !json['backdrops'].isEmpty) {
      List<dynamic> backdrops = json['backdrops'];
      this.backdrops = backdrops
          .sublist(
              0, (backdrops.length > maxPicCapacity ? 6 : backdrops.length))
          .map((e) => getImage(imagePath: e['file_path'], size: "w1280"))
          .toList();
    } else {
      backdrops = [poster];
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

  //can't use Movie.fromJson since these will me minimized movie objects
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
