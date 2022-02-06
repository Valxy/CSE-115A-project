import 'package:flutter/cupertino.dart';
import './api_objects.dart';

class MinimizedTvShow {
  ///iso 639-1 language code
  late String originalLanguage;
  late String originalName;
  late List<ProductionCountry> originCountries;
  String? backdropPath;
  late int id;
  late String overview;
  late num popularity;
  String? posterPath;
  late String firstAirDate;
  late String name;
  late num voteAverage;
  late int voteCount;
  late List<Genre> genres;

/*
  MinimizedTvShow(
      {required this.backdropPath,
      required this.firstAirDate,
      required this.genres,
      required this.id,
      required this.name,
      required this.originCountry,
      required this.originalLanguage,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount}) {
    genres = genres.map((el) => Genre(id: el)).toList();
  }
  */

  MinimizedTvShow();

  MinimizedTvShow.fromJson({
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
    _parseCountries(json: json['origin_country']);
    _parseGenres(json: json['genre_ids']);
  }

  /// Returns an image widget for the image at [imagePath] with
  /// size [size]. Default size is w500.
  Widget getImage({required imagePath, size = "w500"}) {
    if (imagePath != null && imagePath.isNotEmpty) {
      return Image.network("https://image.tmdb.org/t/p/$size" + posterPath!);
    }
    return const SizedBox.shrink();
  }

  void _parseCountries({
    required List<dynamic> json,
  }) {
    originCountries = json.map((el) => ProductionCountry(name: el)).toList();
  }

  void _parseGenres({
    required List<dynamic> json,
  }) {
    genres = json.map((el) => Genre(id: el)).toList();
  }

  ///Returns the backdrop for this movie as an Image widget
  ///with size [size]. Default size is w500.
  Widget getBackdrop({
    size = "w500",
  }) {
    return getImage(imagePath: backdropPath);
  }

  @override
  String toString() {
    return "TV Show: $name id: $id";
  }
}
