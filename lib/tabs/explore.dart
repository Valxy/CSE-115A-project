import 'package:flutter/material.dart';
import 'dart:async';
import '../models/tmdb_api_wrapper.dart';
import '../pages/details.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({Key? key}) : super(key: key);

  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  late Future<List<MinimizedMovie>> popularMovies;
  late Future<List<MinimizedMovie>> inTheaters;
  late Future<List<MinimizedMovie>> topRatedMovies;

  late Future<List<MinimizedTvShow>> popularShows;
  late Future<List<MinimizedTvShow>> nowAiringShows;
  late Future<List<MinimizedTvShow>> topRatedShows;

  @override
  void initState() {
    super.initState();

    TmdbApiWrapper wrapper = TmdbApiWrapper();

    popularMovies = wrapper.getPopularMovies(1);
    inTheaters = wrapper.getNowPlayingMovies(1);
    topRatedMovies = wrapper.getTopRatedMovies(1);

    popularShows = wrapper.getPopularTvShows(1);
    nowAiringShows = wrapper.getNowAiringTvShows(1);
    topRatedShows = wrapper.getTopRatedTvShows(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: 12,
      itemBuilder: (_, i) {
        if (i % 2 != 1) {
          if (i == 0) {
            return _buildText("Popular Movies");
          }

          if (i == 2) {
            return _buildText("Popular TV Shows");
          }

          if (i == 4) {
            return _buildText("In Theaters");
          }

          if (i == 6) {
            return _buildText("Now Airing TV Shows");
          }

          if (i == 8) {
            return _buildText("Top Rated Movies");
          }

          if (i == 10) {
            return _buildText("Top Rated TV Shows");
          }
        }

        if (i == 1) {
          return _horizontalListViewMovies(popularMovies);
        } else if (i == 3) {
          return _horizontalListViewShows(popularShows);
        } else if (i == 5) {
          return _horizontalListViewMovies(inTheaters);
        } else if (i == 7) {
          return _horizontalListViewShows(nowAiringShows);
        } else if (i == 9) {
          return _horizontalListViewMovies(topRatedMovies);
        } else if (i == 11) {
          return _horizontalListViewShows(topRatedShows);
        }

        throw ("Error: One or more elements were not able to be built successfully!");
      },
    ));
  }

  // build method for the different scrolling lists
  Widget _horizontalListViewMovies(Future<List<MinimizedMovie>> movies) {
    return SizedBox(
      height: 380,
      child: Scrollbar(
        child: ListView.builder(
          itemCount: 20,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) =>
              _buildBoxMovies(movies, index),
        ),
      ),
    );
  }

  // build method for the different scrolling lists
  Widget _horizontalListViewShows(Future<List<MinimizedTvShow>> shows) {
    return SizedBox(
      height: 380,
      child: Scrollbar(
        child: ListView.builder(
          itemCount: 20,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) =>
              _buildBoxShows(shows, index),
        ),
      ),
    );
  }

  // build method for each individual movie
  Widget _buildBoxMovies(Future<List<MinimizedMovie>> movies, int index) =>
      Container(
        margin: const EdgeInsets.all(8),
        height: 380,
        width: 200,
        child: FutureBuilder<List<MinimizedMovie>>(
          future: movies,
          builder:
              (BuildContext ctx, AsyncSnapshot<List<MinimizedMovie>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        ShowDetails(showId: "${snapshot.data![index].id}"),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Column(
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 250,
                    margin: const EdgeInsets.only(
                        left: 0.0, top: 0.0, bottom: 10.0, right: 0.0),
                    child: snapshot.data![index].getPoster(),
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                        left: 0.0, top: 0.0, bottom: 5.0, right: 0.0),
                    child: Text(snapshot.data![index].title,
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                        left: 0.0, top: 0.0, bottom: 0.0, right: 0.0),
                    child: Text(
                        'Rating: ${snapshot.data![index].voteAverage.toInt()}%',
                        style: Theme.of(context).textTheme.caption),
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                        left: 0.0, top: 0.0, bottom: 10.0, right: 0.0),
                    child: Text(
                        'Released: ${snapshot.data![index].releaseDate}',
                        style: Theme.of(context).textTheme.caption),
                  ),
                ],
              ),
            );
          },
        ),
      );

  // build method for each individual movie
  Widget _buildBoxShows(Future<List<MinimizedTvShow>> shows, int index) =>
      Container(
        margin: const EdgeInsets.all(8),
        height: 380,
        width: 200,
        child: FutureBuilder<List<MinimizedTvShow>>(
          future: shows,
          builder: (BuildContext ctx,
              AsyncSnapshot<List<MinimizedTvShow>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        ShowDetails(showId: "${snapshot.data![index].id}"),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Column(
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 250,
                    margin: const EdgeInsets.only(
                        left: 0.0, top: 0.0, bottom: 10.0, right: 0.0),
                    child: snapshot.data![index].getBackdrop(),
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                        left: 0.0, top: 0.0, bottom: 5.0, right: 0.0),
                    child: Text(snapshot.data![index].name,
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                        left: 0.0, top: 0.0, bottom: 0.0, right: 0.0),
                    child: Text(
                        'Rating: ${snapshot.data![index].voteAverage.toInt()}%',
                        style: Theme.of(context).textTheme.caption),
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                        left: 0.0, top: 0.0, bottom: 10.0, right: 0.0),
                    child: Text(
                        'Date First Aired: ${snapshot.data![index].firstAirDate}',
                        style: Theme.of(context).textTheme.caption),
                  ),
                ],
              ),
            );
          },
        ),
      );

  // build method for creating the different scrolling list titles
  Widget _buildText(String category) => Container(
        margin: const EdgeInsets.all(12),
        width: 200,
        child: Text(category, style: Theme.of(context).textTheme.headline5),
      );
}
