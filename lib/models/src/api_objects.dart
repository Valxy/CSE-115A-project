import 'package:flutter/cupertino.dart';

class Video {
  late String language;
  late String country;
  late String name;
  late String key;
  late String site;
  late int size;
  late String type;
  late bool official;
  late String publishedAt;
  late String id;

  Video.fromJson({
    required Map json,
  }) {
    country = json['iso_3166_1'];
    id = json['id'];
    key = json['key'];
    language = json['iso_639_1'];
    name = json['name'];
    official = json['official'];
    publishedAt = json['published_at'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
  }

  @override
  String toString() {
    return "video: {id: $id, language: $language, country: $country, name: $name, key: $key, site: $site, size: $size, type: $type, official: $official, published_at: $publishedAt}";
  }
}

class Author {
  late String name;
  late String username;
  String? avatarPath;
  late double? rating; // change from late int to late double?

  Author.fromJson({
    required Map json,
  }) {
    name = json['name'];
    username = json['username'];
    avatarPath = json['avatar_path'];
    rating = json['rating']; // causing null is not type double error
  }

  String toString() {
    return "Author: {name: $name, username: $username, avatar_path: $avatarPath, rating: $rating}";
  }

  String toString() {
    return "Author: {name: $name, username: $username, avatar_path: $avatarPath, rating: $rating}";
  }
}

class Review {
  late String author;
  late Author authorDetails;
  late String content;
  late String createdAt;
  late String id;
  late String updatedAt;
  late String url;

  Review.fromJson({
    required Map json,
  }) {
    author = json['author'];
    authorDetails = Author.fromJson(json: json['author_details']);
    content = json['content'];
    createdAt = json['created_at'];
    id = json['id'];
    updatedAt = json['updated_at'];
    url = json['url'];
  }

  @override
  String toString() {
    return "Review: {review id: $id, author_details: $author, content: $content, created_at: $createdAt, updated_at: $updatedAt, url: $url}";
  }
}

///For representing a person
///that would not otherwise fit
///into cast/crew member classes
class Person {
  late int id;
  late String name;
  int? gender;
  String? profilePath;
  double? popularity;
  bool? adult;
  late String creditId;

  Person();

  Person.fromArguments({
    required this.creditId,
    this.gender,
    required this.id,
    required this.name,
    this.profilePath,
    this.popularity,
    this.adult,
  });

  @override
  String toString() {
    return "Person: {name: $name, id: $id, creditId: $creditId,  gender: $gender, profile_path: $profilePath, popularity: $popularity, adult: $adult}";
  }
}

class CastMember extends Person {
  late String knownForDepartment;
  late String originalName;
  late int castId;
  late String character;
  late int order;

  CastMember.fromJson({
    required Map json,
  }) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    order = json['order'];
    character = json['character'];
    creditId = json['credit_id'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }

  @override
  String toString() {
    return "Cast Member: {known_for_department: $knownForDepartment, original_name: $originalName, character: $character, order: $order, name: $name, id: $id, credit_id: $creditId, gender: $gender, profile_path: $profilePath, popularity: $popularity, adult: $adult}";
  }
}

class CrewMember extends Person {
  late String knownForDepartment;
  late String originalName;
  late String department;
  late String job;

  CrewMember.fromJson({
    required Map json,
  }) {
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
  @override
  String toString() {
    return "Crew Member: {known_for_department: $knownForDepartment, original_name: $originalName, department: $department, job: $job, name: $name, id: $id, credit_id: $creditId, gender: $gender, profile_path: $profilePath, popularity: $popularity, adult: $adult}";
  }
}

class ProductionCompany {
  late String name;
  int? id;
  String? logoPath;
  String? originCountry;

  ProductionCompany({
    this.id,
    required this.name,
    this.logoPath,
    this.originCountry,
  });
  ProductionCompany.fromJson({
    required Map json,
  }) {
    name = json['name'];
    id = json['id'];
    logoPath = json['logo_path'];
    originCountry = json['origin_country'];
  }

  @override
  String toString() {
    return "Company: {Company name: $name, id: $id, logo_path: $logoPath, origin_country: $originCountry}";
  }
}

class Country {
  late String name;

  ///per iso 1366-1
  String? isoId;

  Country({
    this.isoId,
    required this.name,
  });
  Country.fromJson({
    required Map json,
  }) {
    name = json['name'];
    isoId = json['iso_3166_1'];
  }

  @override
  String toString() {
    return "Country: {Country name: $name, iso id: $isoId}";
  }
}

class Language {
  late String name;

  ///per iso 639-1
  String? isoId;
  Language.fromJson({
    required Map json,
  }) {
    name = json['name'];
    isoId = json['iso_639_1'];
  }

  @override
  String toString() {
    return "Language: {Language: $name, iso id: $isoId}";
  }
}

class Genre {
  String? name;
  late int id;

  Genre({
    required this.id,
    this.name,
  });
  Genre.fromJson({
    required Map json,
  }) {
    name = json['name'];
    id = json['id'];
  }

  @override
  String toString() {
    return "Genre: {genre id: $id, name: $name}";
  }
}

class TvEpisode {
  late String airDate;
  late int episodeNumber;
  late int id;
  late String name;
  late String overview;
  late String productionCode;
  late int seasonNumber;
  String? stillPath;
  late num voteAverage;
  late int voteCount;

  TvEpisode({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  TvEpisode.fromJson({
    required Map json,
  }) {
    airDate = json['air_date'];
    episodeNumber = json['episode_number'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    productionCode = json['production_code'];
    seasonNumber = json['season_number'];
    stillPath = json['still_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  @override
  String toString() {
    return "TvEpisode: {episode name: $name, episode_number: $episodeNumber, air_date: $airDate, id: $id, overview: $overview, production_code: $productionCode, season_number: $seasonNumber, still_path: $stillPath, vote_average: $voteAverage, vote_count: $voteCount}";
  }
}

class Network {
  late String name;
  late int id;
  String? logoPath;
  late String originCountry;

  Network({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  Network.fromJson({
    required Map json,
  }) {
    name = json['name'];
    id = json['id'];
    logoPath = json['logo_path'];
    originCountry = json['origin_country'];
  }

  @override
  String toString() {
    return "Network: {name: $name, id: $id, logo_path: $logoPath, origin_country: $originCountry}";
  }
}

class TvShowSeason {
  late String airDate;
  late int episodeCount;
  late int id;
  late String name;
  late String overview;

  // sometimes gives null
  String? posterPath;
  late int seasonNumber;

  TvShowSeason({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    required this.seasonNumber,
  });

  TvShowSeason.fromJson({
    required Map json,
  }) {
    airDate = json['air_date'];
    episodeCount = json['episode_count'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    seasonNumber = json['season_number'];
  }

  @override
  String toString() {
    return "TvShowSeason: {number: $seasonNumber, episode_count: $episodeCount, id: $id, name: $name, overview: $overview}";
  }
}

///This class is needed because it contains
///the Rating ('G', 'PG', 'R', etc)
class Release {
  late String certification;

  ///the iso 639-1 country name
  // TMDB API returned null even though not marked as such
  String? language;
  late String releaseDate;
  late int type;
  String? note;

  Release.fromJson({
    required Map json,
  }) {
    certification = json['certification'];
    language = json['iso_639_1'];
    releaseDate = json['release_date'];
    type = json['type'];
    note = json['note'];
  }

  @override
  String toString() {
    return "Release: {release_date: $releaseDate, rating: $certification, language: $language, type: $type, note: $note}";
  }
}
