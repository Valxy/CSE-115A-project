import 'package:flutter/cupertino.dart';
import './api_objects.dart';

///A class to represent a Movie with limited
///information. Consult the TmdbApiWrapper library
///doc for more information.
class MinimizedMovie {
  ///iso 639-1 language code
  late String originalLanguage;

  // Used Num since the api returns
  // both integers and floats
  late num voteAverage;
  late bool adult;
  String? backdropPath;

  ///The TMDB ID
  late int id;
  late String originalTitle;
  late num popularity;
  String? posterPath;
  String? releaseDate;
  String? overview;
  late String title;
  late bool video;
  late int voteCount;
  late List<Genre> genres;

  MinimizedMovie();

  MinimizedMovie.fromJson({
    required Map json,
  }) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];

    // TMDB api inconsistent with naming conventions
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

  ///Returns the poster for this movie as an Image widget
  ///with size [size]. Default size is w500.
  Widget getPoster({
    String size = "w500",
  }) {
    return getImage(imagePath: posterPath);
  }

  ///Returns the image at [posterPath] as an Image widget
  ///with size [size]. Default size is w500.
  Widget getImage({
    required imagePath,
    String size = "w500",
  }) {
    if (imagePath != null && imagePath.isNotEmpty) {
      return Image.network("https://image.tmdb.org/t/p/$size" + posterPath!);
    }
    return const SizedBox.shrink();
  }

  @override
  String toString() {
    return "Movie: $title id: $id";
  }

  void _parseGenres({
    required List<dynamic> json,
  }) {
    genres = json.map((el) => Genre(id: el)).toList();
  }
}
