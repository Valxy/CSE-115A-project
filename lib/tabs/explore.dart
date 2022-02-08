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
  final ScrollController _scrollController = ScrollController();

  String category = "";

  static String? title;
  static String? releaseDate;
  static int? runtime;

  static Future<String?> getTitle(int i, String category) async {
    TmdbApiWrapper wrapper = TmdbApiWrapper();
    /*List<Movie> movieList = [];
    if (category == "Popular Movies")
      movieList = await wrapper.getPopularMovies();
    if (category == "In Theaters")
      movieList = await wrapper.getNowPlayingMovies();
    if (category == "Top Rated Movies")
      movieList = await wrapper.getTopRatedMovies();*/
    List<MinimizedMovie> movieList = await wrapper.getPopularMovies();
    title = await movieList[i].title;
    return title;
  }

  static Future<String?> getReleaseDate(int i, String category) async {
    TmdbApiWrapper wrapper = TmdbApiWrapper();
    List<MinimizedMovie> movieList = await wrapper.getPopularMovies();
    releaseDate = await movieList[i].releaseDate;
    return releaseDate;
  }

  static Future<int?> getRuntime(int i, String category) async {
    // TmdbApiWrapper wrapper = TmdbApiWrapper();
    // List<MinimizedMovie> movieList = await wrapper.getPopularMovies();
    // runtime = await movieList[i].runtime;
    return 0;
  }

  static Future<Movie> getPoster(int i, String category) async {
    TmdbApiWrapper wrapper = TmdbApiWrapper();
    List<MinimizedMovie> movieList = await wrapper.getPopularMovies();
    MinimizedMovie movieItem = await movieList[i];
    int? useID = movieItem.id;
    Future<Movie> movie = wrapper.getDetailsMovie(movieId: useID);
    return movie;
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
        } else {
          return _horizontalListView();
        }
      },
    ));
  }

  // build method for the different scrolling lists
  Widget _horizontalListView() {
    return SizedBox(
      height: 400,
      child: Scrollbar(
        //isAlwaysShown: true,
        //controller: _scrollController,
        child: ListView.builder(
          //controller: _scrollController,
          itemCount: 20,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) => _buildBox(index),
        ),
      ),
    );
  }

  // build method for each individual movie
  Widget _buildBox(int index) => Container(
        margin: const EdgeInsets.all(12),
        height: 400,
        width: 300,
        child: OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    const ShowDetails(showId: "634649"),
                fullscreenDialog: true,
              ),
            );
          },
          // ignore: unnecessary_new
          child: new Column(children: <Widget>[
            Container(
              width: 200,
              height: 200,
              margin: const EdgeInsets.only(
                  left: 0.0, top: 10.0, bottom: 10.0, right: 0.0),
              child: FutureBuilder<Movie>(
                future: getPoster(index, category),
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
              margin: const EdgeInsets.only(
                  left: 0.0, top: 5.0, bottom: 5.0, right: 0.0),
              child: FutureBuilder<String?>(
                future: getTitle(index,
                    category), // a previously-obtained Future<String> or null
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  return Text('${snapshot.data}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0));
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 0.0, top: 5.0, bottom: 5.0, right: 0.0),
              child: FutureBuilder<int?>(
                future: getRuntime(index, category),
                builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
                  return Text('Runtime: ${snapshot.data}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0));
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 0.0, top: 5.0, bottom: 5.0, right: 0.0),
              child: FutureBuilder<String?>(
                future: getReleaseDate(index,
                    category), // a previously-obtained Future<String> or null
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  return Text('Released: ${snapshot.data}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0));
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
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      );
}
