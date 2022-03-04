import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
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

  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

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
      height: 435,
      child: Scrollbar(
        child: ListView.builder(
          itemCount: 100,
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
      height: 435,
      child: Scrollbar(
        child: ListView.builder(
          itemCount: 100,
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
        margin: const EdgeInsets.all(10),
        height: 435,
        width: 200,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
        ),
        child: FutureBuilder<List<MinimizedMovie>>(
          future: movies,
          builder:
              (BuildContext ctx, AsyncSnapshot<List<MinimizedMovie>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return _buildBox(
                poster: snapshot.data![index].getPoster(),
                voteAverage: snapshot.data![index].voteAverage,
                name: snapshot.data![index].title,
                date: snapshot.data![index].releaseDate,
                dest: ShowDetails(showId: "${snapshot.data![index].id}"));
          },
        ),
      );

  // build method for each individual movie
  Widget _buildBoxShows(Future<List<MinimizedTvShow>> shows, int index) =>
      Container(
        margin: const EdgeInsets.all(10),
        height: 435,
        width: 200,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
        ),
        child: FutureBuilder<List<MinimizedTvShow>>(
          future: shows,
          builder: (BuildContext ctx,
              AsyncSnapshot<List<MinimizedTvShow>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return _buildBox(
                poster: snapshot.data![index].getPoster(),
                voteAverage: snapshot.data![index].voteAverage,
                name: snapshot.data![index].name,
                date: snapshot.data![index].firstAirDate,
                dest: ShowDetails(showId: "${snapshot.data![index].id}"));
          },
        ),
      );

  Widget _buildBox(
          {required Widget poster,
          required num voteAverage,
          required String name,
          required String date,
          required Widget dest}) =>
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => dest,
              fullscreenDialog: true,
            ),
          );
        },
        child: Column(
          children: <Widget>[
            _buildPoster(poster, voteAverage),
            Container(
              width: 200,
              margin: const EdgeInsets.only(
                  left: 10.0, top: 15.0, bottom: 5.0, right: 10.0),
              child: Text(name, style: Theme.of(context).textTheme.titleMedium),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(
                  left: 10.0, top: 0.0, bottom: 10.0, right: 10.0),
              child: Text(
                  '${months[DateTime.parse(date).month - 1]} '
                  '${DateTime.parse(date).day}, '
                  '${DateTime.parse(date).year}',
                  style: Theme.of(context).textTheme.caption),
            ),
          ],
        ),
      );

  // build method for creating the different scrolling list titles
  Widget _buildText(String category) => Container(
        margin: const EdgeInsets.all(12),
        width: 200,
        child: Text(category, style: Theme.of(context).textTheme.headline5),
      );

  Widget _buildPoster(Widget poster, num voteAverage) => Stack(
        children: <Widget>[
          Container(
            width: 200,
            height: 300,
            margin: const EdgeInsets.only(
                left: 0.0, top: 0.0, bottom: 10.0, right: 0.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8.0),
              ),
              child: poster,
            ),
          ),
          Container(
            height: 300,
            alignment: const Alignment(-0.85, 1.13),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff081c22),
              ),
              child: CircularPercentIndicator(
                radius: 20,
                percent: voteAverage * (0.1),
                lineWidth: 4,
                backgroundColor: const Color(0xff1b3c27),
                center: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: " " +
                            (voteAverage * (0.1) * 100).round().toString(),
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.white,
                          fontFeatures: [const FontFeature.superscripts()],
                        ),
                      ),
                      WidgetSpan(
                        child: Transform.translate(
                          offset: const Offset(0, -6),
                          child: Text(
                            '%',
                            textScaleFactor: 0.5,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                              color: Colors.white,
                              fontFeatures: [const FontFeature.superscripts()],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                progressColor: const Color(0xff21d07a),
              ),
            ),
          ),
        ],
      );
}
