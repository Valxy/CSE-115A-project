import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tmdb/models/tmdb_api_wrapper.dart';

Future<bool> _testGetPopularMovies() async {
  try {
    List<MinimizedMovie> popularMovies =
        await TmdbApiWrapper().getPopularMovies(1);

    expect(popularMovies, isNotEmpty);
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> _testNowPlayingMovies() async {
  try {
    List<MinimizedMovie> nowPlayingMovies =
        await TmdbApiWrapper().getNowPlayingMovies(1);

    expect(nowPlayingMovies, isNotEmpty);
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> _testGetTopRatedMovies() async {
  try {
    List<MinimizedMovie> topRatedMovies =
        await TmdbApiWrapper().getTopRatedMovies(1);

    expect(topRatedMovies, isNotEmpty);
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> _testGetLatestMovie() async {
  try {
    MinimizedMovie latestMovies = await TmdbApiWrapper().getLatestMovie();

    expect(latestMovies, isNotEmpty);
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> _testGetTopRatedTvShows() async {
  try {
    List<MinimizedTvShow> topRatedTvShows =
        await TmdbApiWrapper().getTopRatedTvShows(1);

    expect(topRatedTvShows, isNotEmpty);
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> _testGetNowAiringTvShows() async {
  try {
    List<MinimizedTvShow> nowAiringTvShows =
        await TmdbApiWrapper().getNowAiringTvShows(1);

    expect(nowAiringTvShows, isNotEmpty);
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> _testGetOnTheAirTvShows() async {
  try {
    List<MinimizedTvShow> onTheAirTvShows =
        await TmdbApiWrapper().getOnTheAirTvShows(1);

    expect(onTheAirTvShows, isNotEmpty);
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> _testGetPopularTvShows() async {
  try {
    List<MinimizedTvShow> popularTvShows =
        await TmdbApiWrapper().getPopularTvShows(1);

    expect(popularTvShows, isNotEmpty);
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> testGetImageTvAndMovie(
    MinimizedMovie movie, MinimizedTvShow show) async {
  try {
    Widget image = await TmdbApiWrapper().getImage(imagePath: movie.posterPath);
    image = await TmdbApiWrapper().getImage(imagePath: show.posterPath);

    expect(image, isNotEmpty);
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> _testGetDetailsMovie(MinimizedMovie movie) async {
  try {
    Movie movieDetails =
        await TmdbApiWrapper().getDetailsMovie(movieId: movie.id);

    expect(movieDetails, isNotEmpty);
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> _testGetDetailsTvShow(MinimizedTvShow show) async {
  try {
    TvShow tvShowDetails =
        await TmdbApiWrapper().getDetailsTvShow(tvId: show.id);

    expect(tvShowDetails, isNotEmpty);
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> _testSearch(String query) async {
  try {
    List<dynamic> searchResults = await TmdbApiWrapper().search(query: query);

    // expect(searchResults, isNotEmpty);
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> _testGenreGetters() async {
  for (var k in TmdbApiWrapper().genreDictionary.keys) {
    try {
      TmdbApiWrapper().getMovieListFromGenreId(genreId: TmdbApiWrapper().genreDictionary[k]);
    } on PageNotFoundException {
      // expect a page not found exception for genres
      // that are specific to tv or movie. Simply continue
      continue;
    } catch (e) {
      return false;
    }
    try {
      TmdbApiWrapper().getTvListFromGenreId(genreId: TmdbApiWrapper().genreDictionary[k]);
    } on PageNotFoundException {
      // expect a page not found exception for genres
      // that are specific to tv or movie. Simply continue
      continue;
    } catch (e) {
      return false;
    }
  }
  return true;
}

void main() {
  test('Get popular movies', () => expect(_testGetPopularMovies(), true));
  test('Now playing movies', () => expect(_testNowPlayingMovies(), true);
  test('Top rated movies', () => expect(_testGetTopRatedMovies(), true));
  test('Latest movie', () => expect(_testGetLatestMovie(), true));
  MinimizedMovie testMovie = await TmdbApiWrapper().getLatestMovie();
  List<MinimizedTvShow> shows = await TmdbApiWrapper().getAnimatedTvShows();
  MinimizedTvShow testShow = shows[0];
  test('Top rated TV', () => expect(_testGetTopRatedTvShows(), true));
  test('Now airing TV Shows', () => expect(_testGetNowAiringTvShows(), true));
  test('On the air TV Shows', () => expect(_testGetOnTheAirTvShows(), true));
  test('Popular TV Shows', () => expect(_testGetPopularTvShows(), true));
  test('Testing getImage', () => expect(testGetImageTvAndMovie(testMovie, testShow), true));
  test('Get details movie', () => expect(_testGetDetailsMovie(testMovie), true));
  test('Get detail TV Show', () => expect(_testGetDetailsTvShow(testShow), true));
  test('Test search', () => expect(_testSearch("Charles"), true));
  test('Test genre getters', () => expect(_testGenreGetters(), true));
  test('Movie original language data member', () => expect(testMovie.originalLanguage != null, true));
  test('Movie id data member', () => expect(testMovie.id != null, true));
  test('Movie popularity data member', () => expect(testMovie.popularity != null, true));
  test('Movie posterPath data member', () => expect(testMovie.posterPath != null, true));
  test('Movie releaseDate data member', () => expect(testMovie.releaseDate != null, true));
  test('Movie overview data member', () => expect(testMovie.overview != null, true));
  test('Movie original title data member', () => expect(testMovie.originalTitle != null, true));
  test('Movie title data member', () => expect(testMovie.title != null, true));
  test('Movie video data member', () => expect(testMovie.video != null, true));
  test('Movie voteCount data member', () => expect(testMovie.voteCount != null, true));
  test('Movie genres data member', () => expect(testMovie.genres != null, true));
  test('Movie status data member', () => expect(testMovie.status != null, true));
  test('Movie budget data member', () => expect(testMovie.budget != null, true));
  test('Movie homepage data member', () => expect(testMovie.homepage != null, true));
  test('Movie revenue data member', () => expect(testMovie.revenue != null, true));
  test('Movie runtime data member', () => expect(testMovie.runtime != null, true));
  test('Movie tagline data member', () => expect(testMovie.tagline != null, true));
  test('Movie spokenLanguages data member', () => expect(testMovie.spokenLanguages != null, true));
  test('Movie productionCompanies data member', () => expect(testMovie.productionCompanies != null, true));
  test('Movie productionCountries data member', () => expect(testMovie.productionCountries != null, true));
  test('Movie cast data member', () => expect(testMovie.cast != null, true));
  test('Movie crew data member', () => expect(testMovie.crew != null, true));
  test('Movie poster data member', () => expect(testMovie.poster != null, true));
  test('Movie reviews data member', () => expect(testMovie.reviews != null, true));
  test('Movie backdrops data member', () => expect(testMovie.backdrops != null, true));
  test('Movie recommendations data member', () => expect(testMovie.recommendations != null, true));
  test('Movie videos data member', () => expect(testMovie.videos != null, true));
  test('Movie releases data member', () => expect(testMovie.releases != null, true));
  test('Movie reviews data member', () => expect(testMovie.reviews != null, true));
  test('TV Show posterPath data member', () => expect(testShow.posterPath != null, true));
  test('TV Show originalLanguage data member', () => expect(testShow.originalLanguage != null, true));
  test('TV Show originalName data member', () => expect(testShow.originalName != null, true));
  test('TV Show originCountries data member', () => expect(testShow.originCountries != null, true));
  test('TV Show backdropPath data member', () => expect(testShow.backdropPath != null, true));
  test('TV Show id data member', () => expect(testShow.id != null, true));
  test('TV Show overview data member', () => expect(testShow.overview != null, true));
  test('TV Show popularity data member', () => expect(testShow.popularity != null, true));
  test('TV Show firstAirDate data member', () => expect(testShow.firstAirDate != null, true));
  test('TV Show name data member', () => expect(testShow.name != null, true));
  test('TV Show voteAverage data member', () => expect(testShow.voteAverage != null, true));
  test('TV Show voteCount data member', () => expect(testShow.voteCount != null, true));
  test('TV Show genres data member', () => expect(testShow.genres != null, true));
  test('TV Show creators data member', () => expect(testShow.creators != null, true));
  test('TV Show homepage data member', () => expect(testShow.homepage != null, true));
  test('TV Show episodeRunTimes data member', () => expect(testShow.episodeRunTimes != null, true));
  test('TV Show languages data member', () => expect(testShow.languages != null, true));
  test('TV Show isInProduction data member', () => expect(testShow.isInProduction != null, true));
  test('TV Show lastAirDate data member', () => expect(testShow.lastAirDate != null, true));
  test('TV Show lastEpisodeToAir data member', () => expect(testShow.lastEpisodeToAir != null, true));
  test('TV Show nextEpisodeToAir data member', () => expect(testShow.nextEpisodeToAir != null, true));
  test('TV Show networks data member', () => expect(testShow.networks != null, true));
  test('TV Show numberOfEpisodes data member', () => expect(testShow.numberOfEpisodes != null, true));
  test('TV Show numberOfSeasons data member', () => expect(testShow.numberOfSeasons != null, true));
  test('TV Show productionCountries data member', () => expect(testShow.productionCountries != null, true));
  test('TV Show productionCompanies data member', () => expect(testShow.productionCompanies != null, true));
  test('TV Show seasons data member', () => expect(testShow.seasons != null, true));
  test('TV Show spokenLanguages data member', () => expect(testShow.spokenLanguages != null, true));
  test('TV Show status data member', () => expect(testShow.status != null, true));
  test('TV Show crew data member', () => expect(testShow.crew != null, true));
  test('TV Show cast data member', () => expect(testShow.cast != null, true));
  test('TV Show type data member', () => expect(testShow.type != null, true));
  test('TV Show recommendations data member', () => expect(testShow.recommendations != null, true));
  test('TV Show videos data member', () => expect(testShow.videos != null, true));
  test('TV Show reviews data member', () => expect(testShow.reviews != null, true));
  test('TV Show backdrops data member', () => expect(testShow.backdrops != null, true));
  test('TV Show poster data member', () => expect(testShow.poster != null, true));
}

  Future<Person> getDetailsPerson({
    required personId,
  }) async {
    final String endpoint =
        "/person/$personId?api_key=$_apiKey&append_to_response=combined_credits,images";
    final responseJson = await _helper.get(endpoint);
    Person person = Person.fromJson(json: responseJson);
    return person;
  }
