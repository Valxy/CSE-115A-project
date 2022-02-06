class Video {
  late String language;
  late String country;
  late String name;
  late String key;
  late String site;
  late String size;
  late String type;
  late String official;
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
    return "video id: $id";
  }
}

class Author {
  late String name;
  late String username;
  String? avatarPath;
  late int rating;

  Author.fromJson({
    required Map json,
  }) {
    name = json['name'];
    username = json['username'];
    avatarPath = json['avatar_path'];
    rating = json['rating'];
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
    return "review id: $id";
  }
}

///For representing a person
///that would not otherwise fit
///into cast/crew member classes
class Person {
  late int id;
  String? creditId;
  late String name;
  int? gender;
  String? profilePath;
  double? popularity;
  bool? adult;

  Person();

  Person.fromArguments({
    this.creditId,
    this.gender,
    required this.id,
    required this.name,
    this.profilePath,
    this.popularity,
    this.adult,
  });

  @override
  String toString() {
    return "name: $name, id: $id";
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
    return "name: $name, popularity: $popularity";
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
    return "Company name: $name";
  }
}

class ProductionCountry {
  late String name;

  ///per iso 1366-1
  String? isoId;

  ProductionCountry({
    this.isoId,
    required this.name,
  });
  ProductionCountry.fromJson({
    required Map json,
  }) {
    name = json['name'];
    isoId = json['iso_3166_1'];
  }

  @override
  String toString() {
    return "Country name: $name";
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
    return "Language: $name";
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
    return "genre id: $id";
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
    return "episode name: $name, number: $episodeNumber";
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
    return "network name: $name";
  }
}

class TvShowSeason {
  late String airDate;
  late int episodeCount;
  late int id;
  late String name;
  late String overview;
  late String posterPath;
  late int seasonNumber;

  TvShowSeason({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
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
    return "season number: $seasonNumber";
  }
}

///This class is needed because it contains
///the Rating ('G', 'PG', 'R', etc)
class ReleaseDate {
  late String certification;

  ///the iso 639-1 country name
  late String language;
  late String releaseDate;
  late int type;
  late String note;

  ReleaseDate.fromJson({
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
    return "release date: $releaseDate, rating: $certification";
  }
}
