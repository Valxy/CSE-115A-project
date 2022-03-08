import 'package:flutter/cupertino.dart';
import './api_objects.dart';
import './minimized_tv_show.dart';

class TvShow extends MinimizedTvShow {
  ///A list of Person objects representing the creators of the TV Show
  late List<Person> creators;

  ///A List of integers representing the episode run times in minutes.
  ///A list with only one element means all episodes have that run time.
  late List<int> episodeRunTimes;

  ///A url to the homepage of the TV Show
  late String homepage;

  ///A boolean data member for whether the show is in production or not.
  late bool isInProduction;

  ///A list of language objects representing the languages in which
  ///the TV Show is available.
  late List<Language> languages;

  ///The date that the Show last aired
  late String lastAirDate;

  ///A TvEpsiode object representing the last episode
  ///of the Show that aired.
  late TvEpisode lastEpisodeToAir;

  ///A TvEpisode object representing the next episode
  ///that will air, if available.
  late TvEpisode nextEpisodeToAir;

  ///A list of Network objects representing the networks
  ///that air the show.
  late List<Network> networks;

  ///The number of episodes the Show has.
  late int numberOfEpisodes;

  ///The number of seasons the Show has.
  late int numberOfSeasons;

  ///A list of ProductionCompany objects representing the
  ///companies that were involved in the production of the Show.
  late List<ProductionCompany> productionCompanies;

  ///A list of Country objects representing the countries in which
  ///the show was produced.
  late List<Country> productionCountries;

  ///A list of TvShowSeason objects representing the seasons of the
  ///Show.
  late List<TvShowSeason> seasons;

  ///A list of Language objects representing the languages that
  ///are spoken in the Show.
  late List<Language> spokenLanguages;

  ///Status of the Show, one of [In Production, Ended, ...].
  late String status;

  ///The type of show [Reality, Scripted, ...]
  late String type;

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
  late List<Widget> backdrops;

  ///A list of Widgets that are the posters for the movie.
  // late List<Widget> posters;

  ///Image widget holding the poster for the TV Show
  late Widget poster;

  ///A list of MinimizedMovie objects representing a list
  ///of recommendations based off of this movie.
  late List<MinimizedTvShow> recommendations;

  ///List of Video objects representing the videos associated with this movie.
  late List<Video> videos;

  TvShow.fromJson({
    required Map json,
  }) {
    if (json['backdrop_path'] != null) {
      backdropPath = json['backdrop_path'];
    } else {
      backdropPath = "";
    }
    if (json['id'] != null) {
      id = json['id'];
    } else {
      id = 0;
    }
    if (json['original_language'] != null) {
      originalLanguage = json['original_language'];
    } else {
      originalLanguage = "";
    }
    if (json['original_name'] != null) {
      originalName = json['original_name'];
    } else {
      originalName = "";
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
    if (json['first_air_date'] != null) {
      firstAirDate = json['first_air_date'];
    } else {
      firstAirDate = "";
    }
    if (json['name'] != null) {
      name = json['name'];
    } else {
      name = "";
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
    if (json['homepage'] != null) {
      homepage = json['homepage'];
    } else {
      homepage = "";
    }
    if (json['status'] != null) {
      status = json['status'];
    } else {
      status = "";
    }

    if (json['episode_run_time'] != null) {
      episodeRunTimes = List<int>.from(json['episode_run_time']);
    } else {
      episodeRunTimes = [0];
    }
    if (json['in_production'] != null) {
      isInProduction = json['in_production'];
    } else {
      isInProduction = false;
    }
    if (json['last_air_date'] != null) {
      lastAirDate = json['last_air_date'];
    } else {
      lastAirDate = "";
    }
    if (json['number_of_episodes'] != null) {
      numberOfEpisodes = json['number_of_episodes'];
    } else {
      numberOfEpisodes = 0;
    }
    if (json['number_of_seasons'] != null) {
      numberOfSeasons = json['number_of_seasons'];
    } else {
      numberOfSeasons = 0;
    }
    if (json['type'] != null) {
      type = json['type'];
    } else {
      type = "";
    }
    if (json['in_production'] != null) {
      isInProduction = json['in_production'];
    } else {
      isInProduction = false;
    }
    if (json['genre_ids'] != null) {
      _parseGenres(json: json['genre_ids']);
    } else {
      if (json['genres'] != null) {
        _parseGenres(json: json['genres']);
      } else {
        genres = [];
      }
    }

    //TvEpisode object handles null values
    lastEpisodeToAir = TvEpisode.fromJson(json: json['last_episode_to_air']);

    // the return object is an array of strings instead of
    // an array of objects. Doesn't make sense to rewrite the
    // parsing functions to accomodate this.
    List<dynamic> c = json['origin_country'];
    originCountries = c.map((el) => Country(isoId: "", name: el)).toList();
    List<dynamic> l = json['languages'];
    languages = l.map((e) => Language(isoId: "", name: e)).toList();

    _parseLanguages(json: json['spoken_languages']);
    _parseCountries(json: json['production_companies']);
    _parseSeasons(json: json['seasons']);
    _parseNetworks(json: json['networks']);
    _parseGenres(json: json['genres']);
    _parseCreators(json: json['created_by']);
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

  void _parseSeasons({
    required List<dynamic> json,
  }) {
    seasons = json.map((e) => TvShowSeason.fromJson(json: e)).toList();
  }

  void _parseCreators({
    required List<dynamic> json,
  }) {
    creators = json
        .map((el) => Person.fromArguments(
            creditId: el['credit_id'],
            id: el['id'],
            name: el['name'],
            gender: el['gender'],
            popularity: 0,
            adult: true,
            profilePath: el['profile_path'] ?? ""))
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
    productionCountries = json.map((el) => Country.fromJson(json: el)).toList();
  }

  void _parseGenres({
    required List<dynamic> json,
  }) {
    genres = json.map((el) => Genre.fromJson(json: el)).toList();
  }

  void _parseImages({
    required Map json,
  }) {
    const int maxPicCapacity = 6;
    print(json['backdrops'] != null);
    if (json['backdrops'] != null && !json['backdrops'].isEmpty) {
      print(json);
      List<dynamic> backdrops = json['backdrops'];
      print(backdrops);
      this.backdrops = backdrops
          .sublist(
              0, (backdrops.length > maxPicCapacity ? 6 : backdrops.length))
          .map((e) => getImage(imagePath: e['file_path'], size: "w1280"))
          .toList();
    } else {
      backdrops.add(const SizedBox.shrink());
    }

    // Only the first poster in the list is ever used, but
    // [poster] data member was never called.
    if (posterPath != "") {
      poster = getImage(imagePath: posterPath);
    } else if (json['posters'] != null && json['posters']!.isNotEmpty) {
      List<dynamic> posters = json['posters'];
      poster = getImage(imagePath: posters[0]['file_path']);
    } else {
      poster = const SizedBox.shrink();
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
          .map((element) => MinimizedTvShow.fromJson(json: element))
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
