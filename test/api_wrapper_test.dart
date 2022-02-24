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

    expect(searchResults, isNotEmpty);
  } catch (e) {
    return false;
  }
  return true;
}

Future<void> _testImageCaching() async {
  List<MinimizedMovie> movie = await TmdbApiWrapper().getPopularMovies(1);
  Widget image =
      await TmdbApiWrapper().getImage(imagePath: movie[0].posterPath);

  expect(image, isNotEmpty);
}

void main() {
  test('Get popular movies', _testGetPopularMovies);
  test('Now playing movies', _testNowPlayingMovies);
  test('Top rated movies', _testGetTopRatedMovies);
}

Future<void> testApiWrapper() async {
  late Movie topRatedMovie;
  late TvShow topRatedShow;
  late List<MinimizedMovie> topRatedMovies;
  late List<MinimizedTvShow> topRatedShows;

  if (!(await _testGetTopRatedMovies())) {
    return;
  } else {
    topRatedMovies = await TmdbApiWrapper().getTopRatedMovies(1);
  }
  if (!(await _testGetLatestMovie())) {
    return;
  }
  if (!(await _testGetTopRatedTvShows())) {
    return;
  } else {
    topRatedShows = await TmdbApiWrapper().getTopRatedTvShows(1);
  }
  if (!(await _testGetNowAiringTvShows())) {
    return;
  }
  if (!(await _testGetOnTheAirTvShows())) {
    return;
  }
  if (!(await _testGetPopularTvShows())) {
    return;
  }
  if (!(await testGetImageTvAndMovie(topRatedMovies[0], topRatedShows[0]))) {
    return;
  }
  if (!(await _testGetDetailsMovie(topRatedMovies[0]))) {
    return;
  } else {
    topRatedMovie =
        await TmdbApiWrapper().getDetailsMovie(movieId: topRatedMovies[0].id);
  }
  if (!(await _testGetDetailsTvShow(topRatedShows[0]))) {
    return;
  } else {
    topRatedShow =
        await TmdbApiWrapper().getDetailsTvShow(tvId: topRatedShows[0].id);
  }
  if (!(await _testSearch("Charles"))) {
    return;
  }

  String dumpString;

  if (kDebugMode) {
    /// Movie test
    dumpString = 'Movie data members\n';
    dumpString = 'original language: ${topRatedMovie.originalLanguage}\n';
    print(dumpString);
    dumpString = 'id: ${topRatedMovie.id}\n';
    print(dumpString);
    dumpString = 'popularity: ${topRatedMovie.popularity}\n';
    print(dumpString);
    dumpString = 'posterPath: ${topRatedMovie.posterPath}\n';
    print(dumpString);
    dumpString = 'releaseDate: ${topRatedMovie.releaseDate}\n';
    print(dumpString);
    dumpString = 'overview: ${topRatedMovie.overview}\n';
    print(dumpString);
    dumpString = 'original title: ${topRatedMovie.originalTitle}\n';
    print(dumpString);
    dumpString = 'title: ${topRatedMovie.title}\n';
    print(dumpString);
    dumpString = 'video: ${topRatedMovie.video}\n';
    print(dumpString);
    dumpString = 'voteCount: ${topRatedMovie.voteCount}\n';
    print(dumpString);
    dumpString = 'genres: ${topRatedMovie.genres}\n';
    print(dumpString);
    dumpString = 'status: ${topRatedMovie.status}\n';
    print(dumpString);
    //removed
    //dumpString = 'belongsToCollection: ${topRatedMovie.belongsToCollection}\n';
    //print(dumpString);
    dumpString = 'budget: ${topRatedMovie.budget}\n';
    print(dumpString);
    dumpString = 'homepage: ${topRatedMovie.homepage}\n';
    print(dumpString);
    dumpString = 'revenue: ${topRatedMovie.revenue}\n';
    print(dumpString);
    dumpString = 'runtime  ${topRatedMovie.runtime}\n';
    print(dumpString);
    dumpString = 'tagline  ${topRatedMovie.tagline}\n';
    print(dumpString);
    dumpString = 'spokenLanguages: ${topRatedMovie.spokenLanguages}\n';
    print(dumpString);
    dumpString = 'productionCompanies: ${topRatedMovie.productionCompanies}\n';
    print(dumpString);
    dumpString = 'productionCountries: ${topRatedMovie.productionCountries}\n';
    print(dumpString);
    dumpString = 'cast: ${topRatedMovie.cast}\n';
    print(dumpString);
    dumpString = 'crew : ${topRatedMovie.crew}\n';
    print(dumpString);
    dumpString = 'posters  ${topRatedMovie.posters}\n';
    print(dumpString);
    dumpString = 'reviews  ${topRatedMovie.reviews}\n';
    print(dumpString);
    dumpString = 'backdrops: ${topRatedMovie.backdrops}\n';
    print(dumpString);
    dumpString = 'recommendations  ${topRatedMovie.recommendations}\n';
    print(dumpString);
    dumpString = 'videos  ${topRatedMovie.videos}\n';
    print(dumpString);
    dumpString = 'releases: ${topRatedMovie.releases}\n';
    print(dumpString);

    /// TvShow test
    dumpString = '\nTvShow data members\n';
    print(dumpString);
    dumpString = 'originalLanguage: ${topRatedShow.originalLanguage}\n';
    print(dumpString);
    dumpString = 'originalName: ${topRatedShow.originalName}\n';
    print(dumpString);
    dumpString = 'originCountries: ${topRatedShow.originCountries}\n';
    print(dumpString);
    dumpString = 'backdropPath: ${topRatedShow.backdropPath}\n';
    print(dumpString);
    dumpString = 'id: ${topRatedShow.id}\n';
    print(dumpString);
    dumpString = 'overview: ${topRatedShow.overview}\n';
    print(dumpString);
    dumpString = 'popularity: ${topRatedShow.popularity}\n';
    print(dumpString);
    dumpString = 'posterPath: ${topRatedShow.posterPath}\n';
    print(dumpString);
    dumpString = 'firstAirDate: ${topRatedShow.firstAirDate}\n';
    print(dumpString);
    dumpString = 'name: ${topRatedShow.name}\n';
    print(dumpString);
    dumpString = 'voteAverage: ${topRatedShow.voteAverage}\n';
    print(dumpString);
    dumpString = 'voteCount: ${topRatedShow.voteCount}\n';
    print(dumpString);
    dumpString = 'genres: ${topRatedShow.genres}\n';
    print(dumpString);
    dumpString = 'creators: ${topRatedShow.creators}\n';
    print(dumpString);
    dumpString = 'homepage: ${topRatedShow.homepage}\n';
    print(dumpString);
    dumpString = 'episodeRunTimes: ${topRatedShow.episodeRunTimes}\n';
    print(dumpString);
    dumpString = 'languages: ${topRatedShow.languages}\n';
    print(dumpString);
    dumpString = 'isInProduction: ${topRatedShow.isInProduction}\n';
    print(dumpString);
    dumpString = 'lastAirDate: ${topRatedShow.lastAirDate}\n';
    print(dumpString);
    dumpString = 'lastEpisodeToAir: ${topRatedShow.lastEpisodeToAir}\n';
    print(dumpString);
    dumpString = 'nextEpisodeToAir: ${topRatedShow.nextEpisodeToAir}\n';
    print(dumpString);
    dumpString = 'networks: ${topRatedShow.networks}\n';
    print(dumpString);
    dumpString = 'numberOfEpisodes: ${topRatedShow.numberOfEpisodes}\n';
    print(dumpString);
    dumpString = 'numberOfSeasons: ${topRatedShow.numberOfSeasons}\n';
    print(dumpString);
    dumpString = 'productionCountries: ${topRatedShow.productionCountries}\n';
    print(dumpString);
    dumpString = 'productionCompanies: ${topRatedShow.productionCompanies}\n';
    print(dumpString);
    dumpString = 'seasons: ${topRatedShow.seasons}\n';
    print(dumpString);
    dumpString = 'spokenLanguages: ${topRatedShow.spokenLanguages}\n';
    print(dumpString);
    dumpString = 'status: ${topRatedShow.status}\n';
    print(dumpString);
    dumpString = 'type: ${topRatedShow.type}\n';
    print(dumpString);
    dumpString = 'crew: ${topRatedShow.crew}\n';
    print(dumpString);
    dumpString = 'cast: ${topRatedShow.cast}\n';
    print(dumpString);
    dumpString = 'recommendations: ${topRatedShow.recommendations}\n';
    print(dumpString);
    dumpString = 'videos: ${topRatedShow.videos}\n';
    print(dumpString);
    dumpString = 'reviews: ${topRatedShow.reviews}\n';
    print(dumpString);
    dumpString = 'backdrops: ${topRatedShow.backdrops}\n';
    print(dumpString);
    dumpString = 'posters: ${topRatedShow.posters}\n';
    print(dumpString);
  }
  /*
  for (var i = 0; i < something.length; i++) {}
  for (var i = 0; i < 20; i++) {}
  */
}
