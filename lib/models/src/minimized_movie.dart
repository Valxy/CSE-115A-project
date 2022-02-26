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
  ///User rating of the movie
  late num voteAverage;

  ///Whether the film is an adult film
  late bool adult;

  ///Path to the backdrop of the movie
  late String backdropPath;

  ///The TMDB movie id
  late int id;

  ///Original title of the movie
  late String originalTitle;

  ///Popularity of the movie
  late num popularity;

  ///Path to the poster for the movie
  late String posterPath;

  ///Date the movie was released
  late String releaseDate;

  ///Synopsis of the movie
  late String overview;

  ///Title of the movie
  late String title;

  ///Whether the movie has videos or not (possibly deprecated?)
  late bool video;

  ///Number of users who rated the movie
  late int voteCount;

  ///List of genre objects representing the genres the movie belongs to
  late List<Genre> genres;

  MinimizedMovie();

  MinimizedMovie.fromJson({
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
      return Image.network("https://image.tmdb.org/t/p/$size" + imagePath);
    }
    return const SizedBox.shrink();
  }

  //added for polymorphism
  String getTitle() {
    return title;
  }

  String getReleaseDate() {
    return releaseDate;
  }

  @override
  String toString() {
    return "Movie: $title id: $id";
  }

  void _parseGenres({
    required List<dynamic> json,
  }) {
    genres = json.map((el) => Genre(id: el, name: "")).toList();
  }
}
