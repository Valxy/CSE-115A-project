import 'package:flutter_test/flutter_test.dart';

import 'package:tmdb/models/src/errors.dart';
import 'package:tmdb/models/tmdb_api_wrapper.dart';

void _testGetPopularMovies() async {
  List<MinimizedMovie> popularMovies =
      await TmdbApiWrapper().getPopularMovies(1);
  expect(popularMovies, isNotEmpty);
}

void _testNowPlayingMovies() async {
  List<MinimizedMovie> nowPlayingMovies =
      await TmdbApiWrapper().getNowPlayingMovies(1);
  expect(nowPlayingMovies, isNotEmpty);
}

void _testGetTopRatedMovies() async {
  List<MinimizedMovie> topRatedMovies =
      await TmdbApiWrapper().getTopRatedMovies(1);
  expect(topRatedMovies, isNotEmpty);
}

void _testGetLatestMovie() async {
  MinimizedMovie latestMovies = await TmdbApiWrapper().getLatestMovie();
  expect(latestMovies, isNotNull);
}

void _testGetTopRatedTvShows() async {
  List<MinimizedTvShow> topRatedTvShows =
      await TmdbApiWrapper().getTopRatedTvShows(1);
  expect(topRatedTvShows, isNotEmpty);
}

void _testGetNowAiringTvShows() async {
  List<MinimizedTvShow> nowAiringTvShows =
      await TmdbApiWrapper().getNowAiringTvShows(1);

  expect(nowAiringTvShows, isNotEmpty);
}

void _testGetOnTheAirTvShows() async {
  List<MinimizedTvShow> onTheAirTvShows =
      await TmdbApiWrapper().getOnTheAirTvShows(1);
  expect(onTheAirTvShows, isNotEmpty);
}

void _testGetPopularTvShows() async {
  List<MinimizedTvShow> popularTvShows =
      await TmdbApiWrapper().getPopularTvShows(1);
  expect(popularTvShows, isNotEmpty);
}

void _testGetDetailsMovie(MinimizedMovie movie) async {
  Movie movieDetails =
      await TmdbApiWrapper().getDetailsMovie(movieId: movie.id);

  expect(movieDetails, isNotNull);
}

void _testGetDetailsTvShow(MinimizedTvShow show) async {
  TvShow tvShowDetails = await TmdbApiWrapper().getDetailsTvShow(tvId: show.id);
  expect(tvShowDetails, isNotNull);
}

void _testSearch(String query) async {
  List<dynamic> searchResults = await TmdbApiWrapper().search(query: query);
  expect(searchResults, isNotEmpty);
}

void _testGenreGetters() async {
  for (var k in TmdbApiWrapper.genreDictionary.keys) {
    try {
      TmdbApiWrapper().getMovieListFromGenreId(
          genreId: TmdbApiWrapper.genreDictionary[k], pageNumber: 1);
    } on PageNotFoundException {
      // expect a page not found exception for genres
      // that are specific to tv or movie. Simply continue
      continue;
    }

    try {
      TmdbApiWrapper().getTvListFromGenreId(
          genreId: TmdbApiWrapper.genreDictionary[k], pageNumber: 1);
    } on PageNotFoundException {
      // expect a page not found exception for genres
      // that are specific to tv or movie. Simply continue
      continue;
    }
  }
}

void main() async {
  test('Get popular movies', _testGetPopularMovies);
  test('Now playing movies', _testNowPlayingMovies);
  test('Top rated movies', _testGetTopRatedMovies);
  test('Latest movie', _testGetLatestMovie);

  test('Top rated TV', _testGetTopRatedTvShows);
  test('Now airing TV Shows', _testGetNowAiringTvShows);
  test('On the air TV Shows', _testGetOnTheAirTvShows);
  test('Popular TV Shows', _testGetPopularTvShows);

  test('Test search', () async => _testSearch("Charles"));
  test('Test genre getters', _testGenreGetters);

  Future<MinimizedMovie> tMovie = TmdbApiWrapper().getLatestMovie();
  Future<Movie> testMovie = (() async =>
      TmdbApiWrapper().getDetailsMovie(movieId: (await tMovie).id))();

  Future<List<MinimizedTvShow>> shows = TmdbApiWrapper().getAnimatedTvShows();
  Future<TvShow> testShow = (() async =>
      TmdbApiWrapper().getDetailsTvShow(tvId: (await shows)[0].id))();
  test('Get details movie', () async => _testGetDetailsMovie(await testMovie));
  test('Get detail TV Show', () async => _testGetDetailsTvShow(await testShow));
  test('Movie original language data member',
      () async => expect((await testMovie).originalLanguage, isNotNull));
  test('Movie id data member',
      () async => expect((await testMovie).id, isNotNull));
  test('Movie popularity data member',
      () async => expect((await testMovie).popularity, isNotNull));
  test('Movie posterPath data member',
      () async => expect((await testMovie).posterPath, isNotNull));
  test('Movie releaseDate data member',
      () async => expect((await testMovie).releaseDate, isNotNull));
  test('Movie overview data member',
      () async => expect((await testMovie).overview, isNotNull));
  test('Movie original title data member',
      () async => expect((await testMovie).originalTitle, isNotNull));
  test('Movie title data member',
      () async => expect((await testMovie).title, isNotNull));
  test('Movie video data member',
      () async => expect((await testMovie).video, isNotNull));
  test('Movie voteCount data member',
      () async => expect((await testMovie).voteCount, isNotNull));
  test('Movie genres data member',
      () async => expect((await testMovie).genres, isNotNull));
  test('Movie status data member',
      () async => expect((await testMovie).status, isNotNull));
  test('Movie budget data member',
      () async => expect((await testMovie).budget, isNotNull));
  test('Movie homepage data member',
      () async => expect((await testMovie).homepage, isNotNull));
  test('Movie revenue data member',
      () async => expect((await testMovie).revenue, isNotNull));
  test('Movie runtime data member',
      () async => expect((await testMovie).runtime, isNotNull));
  test('Movie tagline data member',
      () async => expect((await testMovie).tagline, isNotNull));
  test('Movie spokenLanguages data member',
      () async => expect((await testMovie).spokenLanguages, isNotNull));
  test('Movie productionCompanies data member',
      () async => expect((await testMovie).productionCompanies, isNotNull));
  test('Movie productionCountries data member',
      () async => expect((await testMovie).productionCountries, isNotNull));
  test('Movie cast data member',
      () async => expect((await testMovie).cast, isNotNull));
  test('Movie crew data member',
      () async => expect((await testMovie).crew, isNotNull));
  test('Movie poster data member',
      () async => expect((await testMovie).poster, isNotNull));
  test('Movie reviews data member',
      () async => expect((await testMovie).reviews, isNotNull));
  test('Movie backdrops data member',
      () async => expect((await testMovie).backdrops, isNotNull));
  test('Movie recommendations data member',
      () async => expect((await testMovie).recommendations, isNotNull));
  test('Movie videos data member',
      () async => expect((await testMovie).videos, isNotNull));
  test('Movie releases data member',
      () async => expect((await testMovie).releases, isNotNull));
  test('Movie reviews data member',
      () async => expect((await testMovie).reviews, isNotNull));
  test('TV Show posterPath data member',
      () async => expect((await testShow).posterPath, isNotNull));
  test('TV Show originalLanguage data member',
      () async => expect((await testShow).originalLanguage, isNotNull));
  test('TV Show originalName data member',
      () async => expect((await testShow).originalName, isNotNull));
  test('TV Show originCountries data member',
      () async => expect((await testShow).originCountries, isNotNull));
  test('TV Show backdropPath data member',
      () async => expect((await testShow).backdropPath, isNotNull));
  test('TV Show id data member',
      () async => expect((await testShow).id, isNotNull));
  test('TV Show overview data member',
      () async => expect((await testShow).overview, isNotNull));
  test('TV Show popularity data member',
      () async => expect((await testShow).popularity, isNotNull));
  test('TV Show firstAirDate data member',
      () async => expect((await testShow).firstAirDate, isNotNull));
  test('TV Show name data member',
      () async => expect((await testShow).name, isNotNull));
  test('TV Show voteAverage data member',
      () async => expect((await testShow).voteAverage, isNotNull));
  test('TV Show voteCount data member',
      () async => expect((await testShow).voteCount, isNotNull));
  test('TV Show genres data member',
      () async => expect((await testShow).genres, isNotNull));
  test('TV Show creators data member',
      () async => expect((await testShow).creators, isNotNull));
  test('TV Show homepage data member',
      () async => expect((await testShow).homepage, isNotNull));
  test('TV Show episodeRunTimes data member',
      () async => expect((await testShow).episodeRunTimes, isNotNull));
  test('TV Show languages data member',
      () async => expect((await testShow).languages, isNotNull));
  test('TV Show isInProduction data member',
      () async => expect((await testShow).isInProduction, isNotNull));
  test('TV Show lastAirDate data member',
      () async => expect((await testShow).lastAirDate, isNotNull));
  test('TV Show lastEpisodeToAir data member',
      () async => expect((await testShow).lastEpisodeToAir, isNotNull));
  test('TV Show networks data member',
      () async => expect((await testShow).networks, isNotNull));
  test('TV Show numberOfEpisodes data member',
      () async => expect((await testShow).numberOfEpisodes, isNotNull));
  test('TV Show numberOfSeasons data member',
      () async => expect((await testShow).numberOfSeasons, isNotNull));
  test('TV Show productionCountries data member',
      () async => expect((await testShow).productionCountries, isNotNull));
  test('TV Show productionCompanies data member',
      () async => expect((await testShow).productionCompanies, isNotNull));
  test('TV Show seasons data member',
      () async => expect((await testShow).seasons, isNotNull));
  test('TV Show spokenLanguages data member',
      () async => expect((await testShow).spokenLanguages, isNotNull));
  test('TV Show status data member',
      () async => expect((await testShow).status, isNotNull));
  test('TV Show crew data member',
      () async => expect((await testShow).crew, isNotNull));
  test('TV Show cast data member',
      () async => expect((await testShow).cast, isNotNull));
  test('TV Show type data member',
      () async => expect((await testShow).type, isNotNull));
  test('TV Show recommendations data member',
      () async => expect((await testShow).recommendations, isNotNull));
  test('TV Show videos data member',
      () async => expect((await testShow).videos, isNotNull));
  test('TV Show reviews data member',
      () async => expect((await testShow).reviews, isNotNull));
  test('TV Show backdrops data member',
      () async => expect((await testShow).backdrops, isNotNull));
  test('TV Show poster data member',
      () async => expect((await testShow).poster, isNotNull));
}
