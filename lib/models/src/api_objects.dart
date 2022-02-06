class Video {
  String? language;
  String? country;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? publishedAt;
  String? id;
  String? youtubeUrl;

  Video.fromJson({
    required Map json,
  }) {
    country = json['country'];
    id = json['id'];
    key = json['key'];
    language = json['language'];
    name = json['name'];
    official = json['official'];
    publishedAt = json['published_at'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
  }
}

class Review {
  String? author;
  dynamic authorDetails;
  String? content;
  String? createdAt;
  String? id;
  String? updatedAt;
  String? url;
  Review.fromJson({
    required Map json,
  }) {
    author = json['author'];
    authorDetails = json['author_details'];
    content = json['content'];
    createdAt = json['created_at'];
    id = json['id'];
    updatedAt = json['updated_at'];
    url = json['url'];
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
    castId = json['cast_id'];
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
  late double voteAverage;
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
  });
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
  });
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
  });
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
}
