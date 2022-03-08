import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';

import '../models/tmdb_api_wrapper.dart';
import '../pages/movie.dart';
import '../pages/tvshow.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({Key? key}) : super(key: key);

  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  // Future lists are lists which contain items which will receive data / information
  // later on in their lifespan and use (thus they are called "Future")
  // Each list is for a specific and unique movie or tv show category
  late Future<List<MinimizedMovie>> popularMovies;
  late Future<List<MinimizedMovie>> inTheaters;
  late Future<List<MinimizedMovie>> topRatedMovies;

  late Future<List<MinimizedTvShow>> popularShows;
  late Future<List<MinimizedTvShow>> nowAiringShows;
  late Future<List<MinimizedTvShow>> topRatedShows;

  // String List used for displaying the release dates of movies and tv shows (months displayed in words)
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

  // initState() for initializing elements
  @override
  void initState() {
    super.initState();

    // Instance of the TmdbApiWrapper to access its contents
    TmdbApiWrapper wrapper = TmdbApiWrapper();

    // The parameter inside each movie / tv show get method represents the "page"
    // which will be returned when getting the movies / tv shows
    // Each page represents a chunk of 20 items from that respective list returned
    // by the get functions
    popularMovies = wrapper.getPopularMovies(1);
    inTheaters = wrapper.getNowPlayingMovies(1);
    topRatedMovies = wrapper.getTopRatedMovies(1);

    popularShows = wrapper.getPopularTvShows(1);
    nowAiringShows = wrapper.getNowAiringTvShows(1);
    topRatedShows = wrapper.getTopRatedTvShows(1);
  }

  // Build function for creating all the elements displayed on the screen (titles and scrolling lists)
  // Calls other build functions to create the actual elements
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: 12,
      itemBuilder: (_, i) {
        // If statements for distinguishing which title has which title name depending on the
        // number of the item being built
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

        // If statements for distinguishing which get function (what type of content) to utilize
        // depending on the number of the scrolling list being built
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

  // Build method for the different scrolling lists for movies, which further calls the build method
  // for the individual movie items inside each list
  Widget _horizontalListViewMovies(Future<List<MinimizedMovie>> movies) {
    return SizedBox(
      height: 435,
      child: Scrollbar(
        thickness: 0,
        child: ListView.builder(
          itemCount: 20,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) =>
              _buildBoxMovies(movies, index),
        ),
      ),
    );
  }

  // Build method for the different scrolling lists for tv shows, which further calls the build method
  // for the individual tv show items inside each list
  Widget _horizontalListViewShows(Future<List<MinimizedTvShow>> shows) {
    return SizedBox(
      height: 435,
      child: Scrollbar(
        thickness: 0,
        child: ListView.builder(
          itemCount: 20,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) =>
              _buildBoxShows(shows, index),
        ),
      ),
    );
  }

  // Build method for each individual movie item in a scrolling list
  // Calls other methods such as _buildBox() and _buildPoster() to build elements inside each item
  Widget _buildBoxMovies(Future<List<MinimizedMovie>> movies, int index) =>
      Container(
        margin: const EdgeInsets.all(10),
        height: 435,
        width: 200,
        // Adds visual enhancement and improves aesthetics by adding shadows and other items
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: Theme.of(context).bottomAppBarColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(2, 4), // Shadow position
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
                dest: MoviePage(id: snapshot.data![index].id));
          },
        ),
      );

  // Build method for each individual tv show item in a scrolling list
  // Calls other methods such as _buildBox() and _buildPoster() to build elements inside each item
  Widget _buildBoxShows(Future<List<MinimizedTvShow>> shows, int index) =>
      Container(
        margin: const EdgeInsets.all(10),
        height: 435,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: Theme.of(context).bottomAppBarColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(2, 4), // Shadow position
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
                dest: TVShowPage(id: snapshot.data![index].id));
          },
        ),
      );

  // Build method which implements the information and functionality for each movie
  // or tv show item in the scrolling list
  // The method takes in information for each specific movie or tv show which it will
  // use in displaying that information
  // Calls _buildPoster() to create the poster elements for each item
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
              child: Text(
                name.contains(':') ? name.split(': ').join(':\n') : name + '\n',
                maxLines: 2,
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
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

  // Build method for creating the different scrolling list titles (found above each scrolling list)
  Widget _buildText(String category) => Container(
        margin: const EdgeInsets.all(12),
        width: 200,
        child: Text(category, style: Theme.of(context).textTheme.headline5),
      );

  // Build method for creating and implementing the poster for each item, as well as
  // the circular rating visual
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
              // Widget used for building the circular rating visual
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
