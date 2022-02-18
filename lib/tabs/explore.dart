import 'package:flutter/material.dart';

import '../pages/details.dart';
import '../models/tmdb_api_wrapper.dart';
import 'dart:async';
//import 'package:cached_network_image/cached_network_image.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({Key? key}) : super(key: key);

  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  //final ScrollController _scrollController = ScrollController();

  String category = "";

  static String? title;
  static String? releaseDate;
  static num voteAverage = 0;
  static String movieID = "634649";
  static List<MinimizedMovie> movieList = [];
  static TmdbApiWrapper wrapper = TmdbApiWrapper();

  static Future<String?> getTitle(int i, String category) async {
    if (category == "Popular Movies") {
      movieList = await wrapper.getPopularMovies(1);
    }
    if (category == "In Theaters") {
      movieList = await wrapper.getNowPlayingMovies();
    }
    if (category == "Top Rated Movies") {
      movieList = await wrapper.getTopRatedMovies();
    }
    //List<MinimizedMovie> movieList = await wrapper.getPopularMovies(1);
    title = movieList[i].title;
    return title;
  }

  static Future<String?> getReleaseDate(int i, String category) async {
    if (category == "Popular Movies") {
      movieList = await wrapper.getPopularMovies(1);
    }
    if (category == "In Theaters") {
      movieList = await wrapper.getNowPlayingMovies();
    }
    if (category == "Top Rated Movies") {
      movieList = await wrapper.getTopRatedMovies();
    }
    releaseDate = movieList[i].releaseDate;
    return releaseDate;
  }

  static Future<num> getVoteAverage(int i, String category) async {
    if (category == "Popular Movies") {
      movieList = await wrapper.getPopularMovies(1);
    }
    if (category == "In Theaters") {
      movieList = await wrapper.getNowPlayingMovies();
    }
    if (category == "Top Rated Movies") {
      movieList = await wrapper.getTopRatedMovies();
    }
    voteAverage = movieList[i].voteAverage;
    return voteAverage * 10;
  }

  static Future<Movie> getPoster(int i, String category) async {
    if (category == "Popular Movies") {
      movieList = await wrapper.getPopularMovies(1);
    }
    if (category == "In Theaters") {
      movieList = await wrapper.getNowPlayingMovies();
    }
    if (category == "Top Rated Movies") {
      movieList = await wrapper.getTopRatedMovies();
    }
    MinimizedMovie movieItem = movieList[i];
    int? useID = movieItem.id;
    Future<Movie> movie = wrapper.getDetailsMovie(movieId: useID);
    return movie;
  }

  /*static Future<String> getMovieID(int i) async {
    MinimizedMovie movieItem = await movieList[i];
    int? useID = movieItem.id;
    movieID = useID.toString();
    return movieID;
  }*/
  static String getMovieID(int i) {
    MinimizedMovie movieItem = movieList[i];
    int useID = movieItem.id;
    movieID = useID.toString();
    return movieID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: 6,
      itemBuilder: (_, i) {
        if (i % 2 != 1) {
          if (i == 0) {
            category = "Popular Movies";
          }
          if (i == 2) {
            category = "In Theaters";
          }
          if (i == 4) {
            category = "Top Rated Movies";
          }

          return _buildText(category);
        }
        if (i == 1) {
          return _horizontalListViewPopular();
        }
        if (i == 3) {
          return _horizontalListViewInTheaters();
        } else {
          return _horizontalListViewTopRated();
        }
      },
    ));
  }

  // build method for the different scrolling lists
  Widget _horizontalListViewPopular() {
    return SizedBox(
      height: 360,
      child: Scrollbar(
        //isAlwaysShown: true,
        //controller: _scrollController,
        child: ListView.builder(
          //controller: _scrollController,
          itemCount: 20,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) =>
              _buildBoxPopular(index),
        ),
      ),
    );
  }

  Widget _horizontalListViewInTheaters() {
    return SizedBox(
      height: 360,
      child: Scrollbar(
        //isAlwaysShown: true,
        //controller: _scrollController,
        child: ListView.builder(
          //controller: _scrollController,
          itemCount: 20,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) =>
              _buildBoxInTheaters(index),
        ),
      ),
    );
  }

  Widget _horizontalListViewTopRated() {
    return SizedBox(
      height: 360,
      child: Scrollbar(
        //isAlwaysShown: true,
        //controller: _scrollController,
        child: ListView.builder(
          //controller: _scrollController,
          itemCount: 20,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) =>
              _buildBoxTopRated(index),
        ),
      ),
    );
  }

  // build method for each individual movie
  Widget _buildBoxPopular(int index) => Container(
        margin: const EdgeInsets.all(8),
        height: 360,
        width: 200,
        child: OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    ShowDetails(showId: "634649"),
                fullscreenDialog: true,
              ),
            );
          },
          // ignore: unnecessary_new
          child: new Column(children: <Widget>[
            Container(
              width: 200,
              height: 250,
              margin: const EdgeInsets.only(
                  left: 0.0, top: 0.0, bottom: 10.0, right: 0.0),
              child: FutureBuilder<Movie>(
                future: getPoster(index, "Popular Movies"),
                builder: (BuildContext ctx, AsyncSnapshot<Movie> snapshot) {
                  if (snapshot.hasData && snapshot.data?.posters != null) {
                    final posters = snapshot.data?.posters;
                    if (posters != null) {
                      // Gets the first poster in the array of posters for that movie
                      return posters[0];
                    }
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(
                  left: 0.0, top: 0.0, bottom: 5.0, right: 0.0),
              child: FutureBuilder<String?>(
                future: getTitle(index,
                    "Popular Movies"), // a previously-obtained Future<String> or null
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  return Text('${snapshot.data}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0));
                },
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(
                  left: 0.0, top: 0.0, bottom: 0.0, right: 0.0),
              child: FutureBuilder<num>(
                future: getVoteAverage(index, "Popular Movies"),
                builder: (BuildContext context, AsyncSnapshot<num> snapshot) {
                  return Text('Rating: ${snapshot.data?.toInt()}%',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0));
                },
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(
                  left: 0.0, top: 0.0, bottom: 10.0, right: 0.0),
              child: FutureBuilder<String?>(
                future: getReleaseDate(index,
                    "Popular Movies"), // a previously-obtained Future<String> or null
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  return Text('Released: ${snapshot.data}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0));
                },
              ),
            ),
          ]),
        ),
      );

  // build method for each individual movie
  Widget _buildBoxInTheaters(int index) => Container(
        margin: const EdgeInsets.all(8),
        height: 360,
        width: 200,
        child: OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ShowDetails(showId: movieID),
                fullscreenDialog: true,
              ),
            );
          },
          // ignore: unnecessary_new
          child: new Column(children: <Widget>[
            Container(
              width: 200,
              height: 250,
              margin: const EdgeInsets.only(
                  left: 0.0, top: 0.0, bottom: 10.0, right: 0.0),
              child: FutureBuilder<Movie>(
                future: getPoster(index, "In Theaters"),
                builder: (BuildContext ctx, AsyncSnapshot<Movie> snapshot) {
                  if (snapshot.hasData && snapshot.data?.posters != null) {
                    final posters = snapshot.data?.posters;
                    if (posters != null) {
                      // Gets the first poster in the array of posters for that movie
                      return posters[0];
                    }
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(
                  left: 0.0, top: 0.0, bottom: 5.0, right: 0.0),
              child: FutureBuilder<String?>(
                future: getTitle(index,
                    "In Theaters"), // a previously-obtained Future<String> or null
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  return Text('${snapshot.data}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0));
                },
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(
                  left: 0.0, top: 0.0, bottom: 0.0, right: 0.0),
              child: FutureBuilder<num>(
                future: getVoteAverage(index, "In Theaters"),
                builder: (BuildContext context, AsyncSnapshot<num> snapshot) {
                  return Text('Rating: ${snapshot.data?.toInt()}%',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0));
                },
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(
                  left: 0.0, top: 0.0, bottom: 10.0, right: 0.0),
              child: FutureBuilder<String?>(
                future: getReleaseDate(index,
                    "In Theaters"), // a previously-obtained Future<String> or null
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  return Text('Released: ${snapshot.data}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0));
                },
              ),
            ),
          ]),
        ),
      );

  // build method for each individual movie
  Widget _buildBoxTopRated(int index) => Container(
        margin: const EdgeInsets.all(8),
        height: 360,
        width: 200,
        child: OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ShowDetails(showId: movieID),
                fullscreenDialog: true,
              ),
            );
          },
          // ignore: unnecessary_new
          child: new Column(children: <Widget>[
            Container(
              width: 200,
              height: 250,
              margin: const EdgeInsets.only(
                  left: 0.0, top: 0.0, bottom: 10.0, right: 0.0),
              child: FutureBuilder<Movie>(
                future: getPoster(index, "Top Rated Movies"),
                builder: (BuildContext ctx, AsyncSnapshot<Movie> snapshot) {
                  if (snapshot.hasData && snapshot.data?.posters != null) {
                    final posters = snapshot.data?.posters;
                    if (posters != null) {
                      // Gets the first poster in the array of posters for that movie
                      return posters[0];
                    }
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(
                  left: 0.0, top: 0.0, bottom: 5.0, right: 0.0),
              child: FutureBuilder<String?>(
                future: getTitle(index,
                    "Top Rated Movies"), // a previously-obtained Future<String> or null
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  return Text('${snapshot.data}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0));
                },
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(
                  left: 0.0, top: 0.0, bottom: 0.0, right: 0.0),
              child: FutureBuilder<num>(
                future: getVoteAverage(index, "Top Rated Movies"),
                builder: (BuildContext context, AsyncSnapshot<num> snapshot) {
                  return Text('Rating: ${snapshot.data?.toInt()}%',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0));
                },
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(
                  left: 0.0, top: 0.0, bottom: 10.0, right: 0.0),
              child: FutureBuilder<String?>(
                future: getReleaseDate(index,
                    "Top Rated Movies"), // a previously-obtained Future<String> or null
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  return Text('Released: ${snapshot.data}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0));
                },
              ),
            ),
          ]),
        ),
      );

  // build method for creating the different scrolling list titles
  Widget _buildText(String category) => Container(
        margin: const EdgeInsets.all(12),
        height: 25,
        width: 200,
        child: Text(category,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      );
}
