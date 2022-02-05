import 'package:flutter/cupertino.dart';
import './api_objects.dart';
import './minimized_tv_show.dart';

class TvShow extends MinimizedTvShow {
  late List<Person> creators;
  late List<int> episodeRunTimes;
  late String homepage;
  late bool isInProduction;
  late List<Language> languages;
  late String lastAirDate;
  late TvEpisode lastEpisodeToAir;
  TvEpisode? nextEpisodeToAir;
  late List<Network> networks;
  late int numberOfEpisodes;
  late int numberOfSeasons;
  late List<ProductionCompany> productionCompanies;
  late List<ProductionCountry> productionCountries;
  late List<TvShowSeason> seasons;
  late List<Language> spokenLanguages;
  late String status;
  late String type;
  late List<CrewMember> crew;
  late List<CastMember> cast;
  late List<MinimizedTvShow> recommendations;
  late List<Video> videos;
  late List<Review> reviews;
  late List<Widget> backdrops;
  late List<Widget> posters;

  TvShow.fromJson({
    required Map json,
  }) {
    backdropPath = json['backdrop_path'];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    firstAirDate = json['first_air_date'];
    name = json['name'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    homepage = json['homepage'];
    status = json['status'];
    lastEpisodeToAir = TvEpisode.fromJson(json: json['last_episode_to_air']);

    _parseNetworks(json: json['networks']);
    _parseCountries(json: json['production_companies']);
    _parseGenres(json: json['genres']);
    _parseCreators(json: json['created_by']);
    _parseLanguages(json: json['spoken_languages']);
    _parseCompanies(json: json['production_companies']);

    _parseCredits(json: json['credits']);
    _parseVideos(json: json['videos']);
    _parseReviews(json: json['reviews']);
    _parseRecommendations(json: json['recommendations']);
    _parseImages(json: json['images']);
  }

  void _parseNetworks({
    required List<dynamic> json,
  }) {
    networks = json.map((e) => Network.fromJson(json: e)).toList();
  }

  void _parseCreators({
    required List<dynamic> json,
  }) {
    creators = json
        .map((el) => Person.fromArguments(
            id: el['id'],
            creditId: el['credit_id'],
            name: el['name'],
            gender: el['gender'],
            profilePath: el['profile_path']))
        .toList();
  }

  void _parseLanguages({
    required List<dynamic> json,
  }) {
    spokenLanguages = json.map((e) => Language.fromJson(json: e)).toList();
  }

  void _parseCompanies({
    required List<dynamic> json,
  }) {
    productionCompanies =
        json.map((el) => ProductionCompany.fromJson(json: el)).toList();
  }

  void _parseCountries({
    required List<dynamic> json,
  }) {
    productionCountries =
        json.map((el) => ProductionCountry.fromJson(json: el)).toList();
  }

  void _parseGenres({
    required List<dynamic> json,
  }) {
    genres = json.map((el) => Genre.fromJson(json: el)).toList();
  }

  void _parseImages({
    required Map json,
  }) {
    if (json['backdrops'] != null) {
      final List<dynamic> backdrops = json['backdrops'];
      this.backdrops =
          backdrops.map((el) => Image.network(el['file_path'])).toList();
    }
    if (json['posters'] != null) {
      final List<dynamic> posters = json['posters'];
      this.posters =
          posters.map((el) => Image.network(el['file_path'])).toList();
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
          .map((element) => MinimizedTvShow.fromJson(json: json['results']))
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
    return "TV Show: $name id: $id";
  }
}
