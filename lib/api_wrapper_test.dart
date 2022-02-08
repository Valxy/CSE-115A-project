import 'package:tmdb/models/tmdb_api_wrapper.dart';
import 'package:flutter/cupertino.dart';

Future<bool> _testGetPopularMovies() async {
  try {
    List<MinimizedMovie> popularMovies =
        await TmdbApiWrapper().getPopularMovies();
  } catch (e) {
    print('could not get popularMovies');
    print(e.toString());
    return false;
  }
  return true;
}

Future<bool> _testNowPlayingMovies() async {
  try {
    List<MinimizedMovie> nowPlayingMovies =
        await TmdbApiWrapper().getNowPlayingMovies();
  } catch (e) {
    print('could not get nowPlayingMovies');
    print(e.toString());
    return false;
  }
  return true;
}

Future<bool> _testGetTopRatedMovies() async {
  try {
    List<MinimizedMovie> nowPlayingMovies =
        await TmdbApiWrapper().getTopRatedMovies();
  } catch (e) {
    print('could not get getTopRatedMovies');
    print(e.toString());
    return false;
  }
  return true;
}

Future<bool> _testGetLatestMovie() async {
  try {
    MinimizedMovie nowPlayingMovies = await TmdbApiWrapper().getLatestMovie();
  } catch (e) {
    print('could not get latest movie');
    print(e.toString());
    return false;
  }
  return true;
}

Future<bool> _testGetTopRatedTvShows() async {
  try {
    List<MinimizedTvShow> nowPlayingMovies =
        await TmdbApiWrapper().getTopRatedTvShows();
  } catch (e) {
    print('could not get topratedtvshows');
    print(e.toString());
    return false;
  }
  return true;
}

Future<bool> _testGetNowAiringTvShows() async {
  try {
    List<MinimizedTvShow> nowPlayingMovies =
        await TmdbApiWrapper().getNowAiringTvShows();
  } catch (e) {
    print('could not get nowairingtvshows');
    print(e.toString());
    return false;
  }
  return true;
}

Future<bool> _testGetOnTheAirTvShows() async {
  try {
    List<MinimizedTvShow> nowPlayingMovies =
        await TmdbApiWrapper().getOnTheAirTvShows();
  } catch (e) {
    print('could not get getOnTheAirTvShows');
    print(e.toString());
    return false;
  }
  return true;
}

Future<bool> _testGetPopularTvShows() async {
  try {
    List<MinimizedTvShow> nowPlayingMovies =
        await TmdbApiWrapper().getPopularTvShows();
  } catch (e) {
    print('could not get getPopularTvShows');
    print(e.toString());
    return false;
  }
  return true;
}

Future<bool> testGetImageTvAndMovie(
    MinimizedMovie movie, MinimizedTvShow show) async {
  try {
    Widget image = await TmdbApiWrapper().getImage(imagePath: movie.posterPath);
    image = await TmdbApiWrapper().getImage(imagePath: show.posterPath);
  } catch (e) {
    print('could not get image');
    print(e.toString());
    return false;
  }
  return true;
}

Future<bool> _testGetDetailsMovie(MinimizedMovie movie) async {
  try {
    Movie nowPlayingMovies =
        await TmdbApiWrapper().getDetailsMovie(movieId: movie.id);
  } catch (e) {
    print('could not get details movie');
    print(e.toString());
    return false;
  }
  return true;
}

Future<bool> _testGetDetailsTvShow(MinimizedTvShow show) async {
  try {
    TvShow nowPlayingMovies =
        await TmdbApiWrapper().getDetailsTvShow(tvId: show.id);
  } catch (e) {
    print('could not get details show');
    print(e.toString());
    return false;
  }
  return true;
}

Future<bool> _testSearch(String query) async {
  try {
    List<dynamic> nowPlayingMovies =
        await TmdbApiWrapper().search(query: query);
  } catch (e) {
    print('could not get getPopularTvShows');
    print(e.toString());
    return false;
  }
  return true;
}

Future<void> testApiWrapper() async {
  late Movie topRatedMovie;
  late TvShow topRatedShow;
  late List<MinimizedMovie> topRatedMovies;
  late List<MinimizedTvShow> topRatedShows;

  if (!(await _testGetPopularMovies())) {
    return;
  }
  if (!(await _testNowPlayingMovies())) {
    return;
  }
  if (!(await _testGetTopRatedMovies())) {
    return;
  } else {
    topRatedMovies = await TmdbApiWrapper().getTopRatedMovies();
  }
  if (!(await _testGetLatestMovie())) {
    return;
  }
  if (!(await _testGetTopRatedTvShows())) {
    return;
  } else {
    topRatedShows = await TmdbApiWrapper().getTopRatedTvShows();
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

  /// Movie test
  dumpString = 'Movie data members\n';
  print(dumpString);
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
  dumpString = 'belongsToCollection: ${topRatedMovie.belongsToCollection}\n';
  print(dumpString);
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

  /*
  for (var i = 0; i < something.length; i++) {}
  for (var i = 0; i < 20; i++) {}
  */
}

Future<void> testImageCaching() async {
  List<MinimizedMovie> movie = await TmdbApiWrapper().getPopularMovies();
  Widget image =
      await TmdbApiWrapper().getImage(imagePath: movie[0].posterPath);
  print('successfully got image: ');
  print(image);
}
