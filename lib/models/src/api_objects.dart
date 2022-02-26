import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class Video {
  ///ISO 639-1 language code for the language of the video
  late String language;

  ///ISO 3166-1 country code for the country of production of the video
  late String country;

  ///Name of the video
  late String name;

  ///Key of video on the website [site]
  late String key;

  ///The website where the video exists
  late String site;

  ///Size of the video (possibly resolution?)
  late int size;

  ///Video type
  late String type;

  ///Whether the video is officially released by the studio
  late bool official;

  ///When the video was published
  late String publishedAt;

  ///TMDB video id
  late String id;

  Video.fromJson({
    required Map json,
  }) {
    if (json['iso_3166_1'] != null) {
      country = json['iso_3166_1'];
    } else {
      country = "";
    }
    if (json['id'] != null) {
      id = json['id'];
    } else {
      id = "";
    }
    if (json['key'] != null) {
      key = json['key'];
    } else {
      key = "";
    }
    if (json['iso_639_1'] != null) {
      language = json['iso_639_1'];
    } else {
      language = "";
    }
    if (json['name'] != null) {
      name = json['name'];
    } else {
      name = "";
    }
    if (json['official'] != null) {
      official = json['official'];
    } else {
      official = false;
    }
    if (json['published_at'] != null) {
      publishedAt = json['published_at'];
    } else {
      publishedAt = "";
    }
    if (json['site'] != null) {
      site = json['site'];
    } else {
      site = "";
    }
    if (json['size'] != null) {
      size = json['size'];
    } else {
      size = 0;
    }
    if (json['type'] != null) {
      type = json['type'];
    } else {
      type = "";
    }
  }

  @override
  String toString() {
    return "video: {id: $id, language: $language, country: $country, name: $name, key: $key, site: $site, size: $size, type: $type, official: $official, published_at: $publishedAt}";
  }
}

class Author {
  ///Name of the author
  late String name;

  ///TMDB user name of the author
  late String username;

  ///Path to an image for the author's avatar
  late String avatarPath;

  ///User rating of the author
  late num rating;

  Author.fromJson({
    required Map json,
  }) {
    if (json['name'] != null) {
      name = json['name'];
    } else {
      name = "";
    }
    if (json['username'] != null) {
      username = json['username'];
    } else {
      username = "";
    }
    if (json['avatar_path'] != null) {
      avatarPath = json['avatar_path'];
    } else {
      avatarPath = "";
    }
    if (json['rating'] != null) {
      rating = json['rating'];
    } else {
      rating = 0;
    }
  }

  @override
  String toString() {
    return "Author: {name: $name, username: $username, avatar_path: $avatarPath, rating: $rating}";
  }
}

class Review {
  ///Name of the person leaving the review
  late String authorName;

  ///Object containing more information about the author
  late Author author;

  ///Content of the review
  late String content;

  ///Date the review was created
  late String createdAt;

  ///TMDB review id
  late String id;

  ///Date of any update to the review
  late String updatedAt;

  ///url to the review itself
  late String url;

  Review.fromJson({
    required Map json,
  }) {
    if (json['author'] != null) {
      authorName = json['author'];
    } else {
      authorName = "";
    }
    if (json['author_details'] != null) {
      author = Author.fromJson(json: json['author_details']);
    } else {
      author = Author.fromJson(json: {});
    }
    if (json['content'] != null) {
      content = json['content'];
    } else {
      content = "";
    }
    if (json['created_at'] != null) {
      createdAt = json['created_at'];
    } else {
      createdAt = "";
    }
    if (json['id'] != null) {
      id = json['id'];
    } else {
      id = "";
    }
    if (json['updated_at'] != null) {
      updatedAt = json['updated_at'];
    } else {
      updatedAt = "";
    }
    if (json['url'] != null) {
      url = json['url'];
    } else {
      url = "";
    }
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
  ///TMDB person id
  late int id;

  ///The person's name
  late String name;

  ///Person's gender
  late int gender;

  ///Path to a profile picture for the person
  late String profilePath;

  ///Popularity of the person
  late num popularity;

  ///Boolean regarding adult media
  late bool adult;

  ///TMDB credit id
  late String creditId;

  ///Widget object containing the person's
  ///picture, if [profilePath] was valid. Use [getImage]
  ///method if [profilePath] is valid, but [profilePicture] is empty.
  late Widget profilePicture;

  ///The person's Birthday
  late String birthday;

  ///Date of the person's passing
  late String deathday;

  ///The person's biography
  late String biography;

  ///Where the person was born
  late String birthPlace;

  ///A list of image paths for pictures
  ///of the person
  late List<Widget> profiles;

  Person();

  Person.fromArguments({
    required this.creditId,
    required this.gender,
    required this.id,
    required this.name,
    required this.profilePath,
    required this.popularity,
    required this.adult,
  });

  Person.fromJson({
    required Map json,
  }) {
    if (json['credit_id'] != null) {
      creditId = json['credit_id'];
    } else {
      creditId = "";
    }
    if (json['profile_path'] != null) {
      profilePath = json['profile_path'];
    } else {
      profilePath = "";
    }
    if (json['name'] != null) {
      name = json['name'];
    } else {
      name = "";
    }
    if (json['id'] != null) {
      id = json['id'];
    } else {
      id = 0;
    }
    if (json['adult'] != null) {
      adult = json['adult'];
    } else {
      adult = true;
    }
    if (json['gender'] != null) {
      gender = json['gender'];
    } else {
      gender = 0;
    }
    if (json['popularity'] != null) {
      popularity = json['popularity'];
    } else {
      popularity = 0;
    }
    if (json['birthday'] != null) {
      birthday = json['birthday'];
    } else {
      birthday = "";
    }
    if (json['deathday'] != null) {
      deathday = json['deathday'];
    } else {
      deathday = "";
    }
    if (json['biography'] != null) {
      biography = json['biography'];
    } else {
      biography = "";
    }
    if (json['place_of_birth'] != null) {
      birthPlace = json['place_of_birth'];
    } else {
      birthPlace = "";
    }
    profilePicture = getImage(imagePath: profilePath, size: "w500");
    _parseImages(json: json['images']['profiles']);
  }

  ///A method to get an image from TMDB. Pass the person's
  ///[profilePath] to get their profile picture. [size] is optional,
  ///default value is w100.
  Widget getImage({
    required imagePath,
    String size = "w100",
  }) {
    if (imagePath != null && imagePath.isNotEmpty) {
      return Image.network("https://image.tmdb.org/t/p/$size" + imagePath);
    }
    return const SizedBox.shrink();
  }

  void _parseImages({
    required List<dynamic>? json,
  }) {
    if (json == null) {
      profiles = [];
      return;
    }
    // maybe the user will notice it's random :3
    json.shuffle();
    profiles = json
        .sublist(0, (json.length > 6 ? 6 : json.length))
        .map((e) => getImage(imagePath: e['file_path'], size: "w300"))
        .toList();
  }

  @override
  String toString() {
    return "Person: {name: $name, id: $id, creditId: $creditId,  gender: $gender, profile_path: $profilePath, popularity: $popularity, adult: $adult, birthday: $birthday, deathday: $deathday, place_of_birth: $birthPlace, biography: $biography, posters: $profiles, profile_picture: $profilePicture}";
  }
}

class CastMember extends Person {
  ///Department that the crew member is knows for
  late String knownForDepartment;

  ///Original name of the crew member
  late String originalName;

  ///TMDB cast id
  late int castId;

  ///Character played in this project
  late String character;

  ///Index of where the cast member appears in
  ///the returned list of actors.
  late int order;

  CastMember.fromJson({
    required Map json,
  }) {
    if (json['adult'] != null) {
      adult = json['adult'];
    } else {
      adult = true;
    }
    if (json['gender'] != null) {
      gender = json['gender'];
    } else {
      gender = 0;
    }
    if (json['id'] != null) {
      id = json['id'];
    } else {
      id = 0;
    }
    if (json['known_for_department'] != null) {
      knownForDepartment = json['known_for_department'];
    } else {
      knownForDepartment = "";
    }
    if (json['name'] != null) {
      name = json['name'];
    } else {
      name = "";
    }
    if (json['order'] != null) {
      order = json['order'];
    } else {
      order = 0;
    }
    if (json['character'] != null) {
      character = json['character'];
    } else {
      character = "";
    }
    if (json['credit_id'] != null) {
      creditId = json['credit_id'];
    } else {
      creditId = "";
    }
    if (json['original_name'] != null) {
      originalName = json['original_name'];
    } else {
      originalName = "";
    }
    if (json['popularity'] != null) {
      popularity = json['popularity'];
    } else {
      popularity = 0;
    }
    if (json['profile_path'] != null) {
      profilePath = json['profile_path'];
      profilePicture = getImage(imagePath: profilePath);
    } else {
      profilePath = "";
      profilePicture = getImage(imagePath: null);
    }
  }

  @override
  String toString() {
    return "Cast Member: {known_for_department: $knownForDepartment, original_name: $originalName, character: $character, order: $order, name: $name, id: $id, credit_id: $creditId, gender: $gender, profile_path: $profilePath, popularity: $popularity, adult: $adult}";
  }
}

class CrewMember extends Person {
  ///Department that the crew member is knows for
  late String knownForDepartment;

  ///Original name of the crew member
  late String originalName;

  ///Where the crew member worked on the project
  late String department;

  ///The crew member's job on the project
  late String job;

  CrewMember.fromJson({
    required Map json,
  }) {
    if (json['adult'] != null) {
      adult = json['adult'];
    } else {
      adult = true;
    }
    if (json['gender'] != null) {
      gender = json['gender'];
    } else {
      gender = 0;
    }
    if (json['id'] != null) {
      id = json['id'];
    } else {
      id = 0;
    }
    if (json['known_for_department'] != null) {
      knownForDepartment = json['known_for_department'];
    } else {
      knownForDepartment = "";
    }
    if (json['name'] != null) {
      name = json['name'];
    } else {
      name = "";
    }
    if (json['credit_id'] != null) {
      creditId = json['credit_id'];
    } else {
      creditId = "";
    }
    if (json['original_name'] != null) {
      originalName = json['original_name'];
    } else {
      originalName = "";
    }
    if (json['popularity'] != null) {
      popularity = json['popularity'];
    } else {
      popularity = 0;
    }
    if (json['profile_path'] != null) {
      profilePath = json['profile_path'];
      profilePicture = getImage(imagePath: profilePath);
    } else {
      profilePath = "";
      profilePicture = getImage(imagePath: null);
    }
    if (json['department'] != null) {
      department = json['department'];
    } else {
      department = "";
    }
    if (json['popularity'] != null) {
      popularity = json['popularity'];
    } else {
      popularity = 0;
    }
    if (json['job'] != null) {
      job = json['job'];
    } else {
      job = "";
    }
  }

  @override
  String toString() {
    return "Crew Member: {known_for_department: $knownForDepartment, original_name: $originalName, department: $department, job: $job, name: $name, id: $id, credit_id: $creditId, gender: $gender, profile_path: $profilePath, popularity: $popularity, adult: $adult}";
  }
}

class ProductionCompany {
  ///Name of the company
  late String name;

  ///TMDB company id
  late int id;

  ///Path to an image for the company's logo
  late String logoPath;

  ///Origin country for the company
  late String originCountry;

  ProductionCompany({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });

  ProductionCompany.fromJson({
    required Map json,
  }) {
    if (json['name'] != null) {
      name = json['name'];
    } else {
      name = "";
    }
    if (json['id'] != null) {
      id = json['id'];
    } else {
      id = 0;
    }
    if (json['logo_path'] != null) {
      logoPath = json['logo_path'];
    } else {
      logoPath = "";
    }
    if (json['origin_country'] != null) {
      originCountry = json['origin_country'];
    } else {
      originCountry = "";
    }
  }

  @override
  String toString() {
    return "Company: {Company name: $name, id: $id, logo_path: $logoPath, origin_country: $originCountry}";
  }
}

class Country {
  ///Name of the country
  late String name;

  ///Country id per iso 1366-1
  late String isoId;

  Country({
    required this.isoId,
    required this.name,
  });

  Country.fromJson({
    required Map json,
  }) {
    if (json['name'] != null) {
      name = json['name'];
    } else {
      name = "";
    }
    if (json['iso_3166_1'] != null) {
      isoId = json['iso_3166_1'];
    } else {
      isoId = "";
    }
  }

  @override
  String toString() {
    return "Country: {Country name: $name, iso id: $isoId}";
  }
}

class Language {
  ///Name of the language
  late String name;

  ///Language id per iso 639-1
  late String isoId;

  Language({
    required this.isoId,
    required this.name,
  });

  Language.fromJson({
    required Map json,
  }) {
    if (json['name'] != null) {
      name = json['name'];
    } else {
      name = "";
    }
    if (json['iso_639_1'] != null) {
      isoId = json['iso_639_1'];
    } else {
      isoId = "";
    }
  }

  @override
  String toString() {
    return "Language: {Language: $name, iso id: $isoId}";
  }
}

class Genre {
  ///Name of the genre (Action, Comedy, etc)
  late String name;

  ///TMDB genre id
  late int id;

  Genre({
    required this.id,
    required this.name,
  });

  Genre.fromJson({
    required Map json,
  }) {
    if (json['name'] != null) {
      name = json['name'];
    } else {
      name = "";
    }
    if (json['id'] != null) {
      id = json['id'];
    } else {
      id = 0;
    }
  }

  @override
  String toString() {
    return "Genre: {genre id: $id, name: $name}";
  }
}

class TvEpisode {
  ///Date the episode aired
  late String airDate;

  ///Which episode in the season
  late int episodeNumber;

  ///TMDB episode id
  late int id;

  ///Name of the episode
  late String name;

  ///Synopsis of the episode
  late String overview;

  ///Production code
  late String productionCode;

  ///Which season the episode is in
  late int seasonNumber;

  ///A path to an image for the episode
  late String stillPath;

  ///User rating of the episode
  late num voteAverage;

  ///The number of users that have rated the episode
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
    if (json['name'] != null) {
      name = json['name'];
    } else {
      name = "";
    }
    if (json['air_date'] != null) {
      airDate = json['air_date'];
    } else {
      airDate = "";
    }
    if (json['episode_number'] != null) {
      episodeNumber = json['episode_number'];
    } else {
      episodeNumber = 0;
    }
    if (json['id'] != null) {
      id = json['id'];
    } else {
      id = 0;
    }
    if (json['overview'] != null) {
      overview = json['overview'];
    } else {
      overview = "";
    }
    if (json['production_code'] != null) {
      productionCode = json['production_code'];
    } else {
      productionCode = "";
    }
    if (json['season_number'] != null) {
      seasonNumber = json['season_number'];
    } else {
      seasonNumber = 0;
    }
    if (json['still_path'] != null) {
      stillPath = json['still_path'];
    } else {
      stillPath = "";
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
  }

  @override
  String toString() {
    return "TvEpisode: {episode name: $name, episode_number: $episodeNumber, air_date: $airDate, id: $id, overview: $overview, production_code: $productionCode, season_number: $seasonNumber, still_path: $stillPath, vote_average: $voteAverage, vote_count: $voteCount}";
  }
}

class Network {
  ///The name of the network where the show airs
  late String name;

  ///TMDB network id
  late int id;

  ///Path to an image for the company's logo
  late String logoPath;

  ///Origin of the network
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
    if (json['name'] != null) {
      name = json['name'];
    } else {
      name = "";
    }
    if (json['id'] != null) {
      id = json['id'];
    } else {
      id = 0;
    }
    if (json['logo_path'] != null) {
      logoPath = json['logo_path'];
    } else {
      logoPath = "";
    }
    if (json['origin_country'] != null) {
      originCountry = json['origin_country'];
    } else {
      originCountry = "";
    }
  }

  @override
  String toString() {
    return "Network: {name: $name, id: $id, logo_path: $logoPath, origin_country: $originCountry}";
  }
}

class TvShowSeason {
  ///Date that the season aired
  late String airDate;

  ///Number of episodes in this season
  late int episodeCount;

  ///TMDB season identifier
  late int id;

  ///Name of the season, if applicable
  late String name;

  ///General synopsis of the season
  late String overview;

  ///Path to an image for the season
  late String posterPath;

  ///Season number
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
    if (json['air_date'] != null) {
      airDate = json['air_date'];
    } else {
      airDate = "";
    }
    if (json['episode_count'] != null) {
      episodeCount = json['episode_count'];
    } else {
      episodeCount = 0;
    }
    if (json['id'] != null) {
      id = json['id'];
    } else {
      id = 0;
    }
    if (json['name'] != null) {
      name = json['name'];
    } else {
      name = "";
    }
    if (json['overview'] != null) {
      overview = json['overview'];
    } else {
      overview = "";
    }
    if (json['poster_path'] != null) {
      posterPath = json['poster_path'];
    } else {
      posterPath = "";
    }
    if (json['season_number'] != null) {
      seasonNumber = json['season_number'];
    } else {
      seasonNumber = 0;
    }
  }

  @override
  String toString() {
    return "TvShowSeason: {number: $seasonNumber, episode_count: $episodeCount, id: $id, name: $name, overview: $overview}";
  }
}

///This class contains the Rating ('G', 'PG', 'R', etc).
///Rating is held in the [certification] data member.
class Release {
  ///The Rating ('G', 'PG', 'R', etc).
  late String certification;

  ///The iso 639-1 country name of where the certification took place.
  ///Must be set in the caller function.
  late String country;

  ///The date of the release
  late String releaseDate;

  ///Integer representing the following:
  ///{1: Premiere, 2: Theatrical (limited), 3: Theatrical, 4: Digital,
  ///5: Physical, 6: TV}
  late int type;

  ///TMDB note on the release
  late String note;

  Release.fromJson({
    required Map json,
  }) {
    if (json['certification'] != null) {
      certification = json['certification'];
    } else {
      certification = "";
    }
    if (json['release_date'] != null) {
      releaseDate = json['release_date'];
    } else {
      releaseDate = "";
    }
    if (json['type'] != null) {
      type = json['type'];
    } else {
      type = 0;
    }
    if (json['note'] != null) {
      note = json['note'];
    } else {
      note = "";
    }
  }

  @override
  String toString() {
    return "Release: {release_date: $releaseDate, rating: $certification, country: $country, type: $type, note: $note}";
  }
}
