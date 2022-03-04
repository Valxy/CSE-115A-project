import 'package:flutter/cupertino.dart';
import './api_objects.dart';

class MinimizedTvShow {
  ///iso 639-1 language code of the original language of the TV Show
  late String originalLanguage;

  ///Original name of the TV show
  late String originalName;

  ///List of countries from which the TV Show originated.
  ///Possibly misdocumented by TMDB?
  late List<Country> originCountries;

  ///Path to the backdrop image of the TV Show
  late String backdropPath;

  ///TMDB TV Show id
  late int id;

  ///Synopsis of the TV Show
  late String overview;

  ///Relative popularity of the TV Show
  late num popularity;

  ///Path to the poster image for the TV Show
  late String posterPath;

  ///Date the Show first aired
  late String firstAirDate;

  ///Name of the TV Show
  late String name;

  ///User rating of the TV Show
  late num voteAverage;

  ///Number of users who rated the TV Show
  late int voteCount;

  ///List of genre objects representing the genres that the Show belongs to
  late List<Genre> genres;

  MinimizedTvShow();

  MinimizedTvShow.fromJson({
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
    _parseCountries(json: json['origin_country']);
    if (json['genre_ids'] != null) {
      _parseGenres(json: json['genre_ids']);
    } else {
      if (json['genres'] != null) {
        _parseGenres(json: json['genres']);
      } else {
        genres = [];
      }
    }
  }

  ///Returns an image widget for the image at [imagePath] with
  ///size [size]. Default size is w500.
  Widget getImage({required imagePath, size = "w500"}) {
    if (imagePath != null && imagePath.isNotEmpty) {
      return Image.network("https://image.tmdb.org/t/p/$size" + imagePath);
    }
    return const SizedBox.shrink();
  }

  ///Returns the backdrop for this movie as an Image widget
  ///with size [size]. Default size is w500.
  Widget getBackdrop({
    size = "w500",
  }) {
    return getImage(imagePath: backdropPath);
  }

  Widget getPoster({
    size = "w500",
  }) {
    return getImage(imagePath: posterPath);
  }

  void _parseCountries({
    required List<dynamic> json,
  }) {
    originCountries = json.map((el) => Country(name: el, isoId: "")).toList();
  }

  void _parseGenres({
    required List<dynamic> json,
  }) {
    genres = json.map((el) => Genre(id: el, name: "")).toList();
  }

  @override
  String toString() {
    return "TV Show: $name id: $id";
  }
}
