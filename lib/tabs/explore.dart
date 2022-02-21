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

  String category = "";

  // Tags used in conditional statements to check which category the item belongs to (movie or tv show)
  static String popularMoviesTag = "Popular Movies";
  static String inTheatersTag = "In Theaters";
  static String topRatedMoviesTag = "Top Rated Movies";
  static String popularShowsTag = "Popular TV Shows";
  static String nowAiringShowsTag = "Now Airing TV Shows";
  static String topRatedShowsTag = "Top Rated TV Shows";

  static String? title;
  static String? releaseDate;
  static num voteAverage = 0;
  static String movieID = "634649";
  static List<MinimizedMovie> movieList = [];
  static List<MinimizedTvShow> showList = [];
  static TmdbApiWrapper wrapper = TmdbApiWrapper();

  /* Helper functions for getting movie and tv show details. */

  // Returns the title of the movie or tv show as a String
  static Future<String?> getTitle(int i, String category, bool isMovie) async {
    if (isMovie == true) {
        if (category == popularMoviesTag) { movieList = await wrapper.getPopularMovies(1); }
      if (category == inTheatersTag) { movieList = await wrapper.getNowPlayingMovies(); }
      if (category == topRatedMoviesTag) { movieList = await wrapper.getTopRatedMovies(); }
      title = movieList[i].title;
    }
    else {
      if (category == popularShowsTag) { showList = await wrapper.getPopularTvShows(); }
      if (category == nowAiringShowsTag) { showList = await wrapper.getNowAiringTvShows(); }
      if (category == topRatedShowsTag) { showList = await wrapper.getTopRatedTvShows(); }
      title = showList[i].name;
    }
    return title;
  }

  // Returns the release date for the movie, or the first air date for the tv show, as a String
  static Future<String?> getReleaseDate(int i, String category, bool isMovie) async {
    if (isMovie == true) {
      if (category == popularMoviesTag) { movieList = await wrapper.getPopularMovies(1); }
      if (category == inTheatersTag) { movieList = await wrapper.getNowPlayingMovies(); }
      if (category == topRatedMoviesTag) { movieList = await wrapper.getTopRatedMovies(); }
      releaseDate = movieList[i].releaseDate;
    }
    else {
      if (category == popularShowsTag) { showList = await wrapper.getPopularTvShows(); }
      if (category == nowAiringShowsTag) { showList = await wrapper.getNowAiringTvShows(); }
      if (category == topRatedShowsTag) { showList = await wrapper.getTopRatedTvShows(); }
      releaseDate = showList[i].firstAirDate;
    }
    return releaseDate;
  }

  // Returns the (popularity) rating of the movie or tv show as a num
  static Future<num> getVoteAverage(int i, String category, bool isMovie) async {
    if (isMovie == true) {
      if (category == popularMoviesTag) { movieList = await wrapper.getPopularMovies(1); }
      if (category == inTheatersTag) { movieList = await wrapper.getNowPlayingMovies(); }
      if (category == topRatedMoviesTag) { movieList = await wrapper.getTopRatedMovies(); }
      voteAverage = movieList[i].voteAverage;
    }
    else {
      if (category == popularShowsTag) { showList = await wrapper.getPopularTvShows(); }
      if (category == nowAiringShowsTag) { showList = await wrapper.getNowAiringTvShows(); }
      if (category == topRatedShowsTag) { showList = await wrapper.getTopRatedTvShows(); }
      voteAverage = showList[i].voteAverage;
    }
    return voteAverage*10;
  }

  // Returns the poster of the movie or the backdrop of the tv show as a Widget
  static Future<Widget> getPoster(int i, String category, bool isMovie) async {
    Widget poster;
    if (isMovie == true) {
      if (category == popularMoviesTag) { movieList = await wrapper.getPopularMovies(1); }
      if (category == inTheatersTag) { movieList = await wrapper.getNowPlayingMovies(); }
      if (category == topRatedMoviesTag) { movieList = await wrapper.getTopRatedMovies(); }
      MinimizedMovie movieItem = movieList[i];
      poster = movieItem.getPoster();
    }
    else {
      if (category == popularShowsTag) { showList = await wrapper.getPopularTvShows(); }
      if (category == nowAiringShowsTag) { showList = await wrapper.getNowAiringTvShows(); }
      if (category == topRatedShowsTag) { showList = await wrapper.getTopRatedTvShows(); }
      MinimizedTvShow showItem = showList[i];
      poster = showItem.getBackdrop();
    }
    return poster;
  }

  /* End of helper functions to get movie or tv show details. */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: 12,
      itemBuilder: (_, i) {
        if (i % 2 != 1) {
          if (i == 0) { category = popularMoviesTag; }
          if (i == 2) { category = popularShowsTag; }
          if (i == 4) { category = inTheatersTag; }
          if (i == 6) { category = nowAiringShowsTag; }
          if (i == 8) { category = topRatedMoviesTag; }
          if (i == 10) { category = topRatedShowsTag; } 
          
          return _buildText(category);
        } 
        if (i == 1) { return _horizontalListViewMovies(popularMoviesTag, true); }
        else if (i == 3) { return _horizontalListViewShows(popularShowsTag, false); }
        else if (i == 5) { return _horizontalListViewMovies(inTheatersTag, true); }
        else if (i == 7) { return _horizontalListViewShows(nowAiringShowsTag, false); }
        else if (i == 9) { return _horizontalListViewMovies(topRatedMoviesTag, true); }
        else if (i == 11) { return _horizontalListViewShows(topRatedShowsTag, false); }

        throw("Error: One or more elements were not able to be built successfully!");
      },
    ));
  }

  // build method for the different scrolling lists
  Widget _horizontalListViewMovies(String type, bool isMovie) {
    return SizedBox(
      height: 360,
      child: Scrollbar(
        child: ListView.builder(
          itemCount: 20,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) => _buildBoxMovies(index, type, isMovie),
        ),
      ),
    );
  }

  // build method for the different scrolling lists
  Widget _horizontalListViewShows(String type, bool isMovie) {
    return SizedBox(
      height: 360,
      child: Scrollbar(
        child: ListView.builder(
          itemCount: 20,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) => _buildBoxShows(index, type, isMovie),
        ),
      ),
    );
  }

  // build method for each individual movie
  Widget _buildBoxMovies(int index, String type, bool isMovie) => Container(
        margin: const EdgeInsets.all(8),
        height: 360,
        width: 200,
        child: OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    ShowDetails(showId: "${movieList[index].id}"),
                fullscreenDialog: true,
              ),
            );
          },
          child: Column(children: <Widget>[
            Container(
              width: 200,
              height: 250,
              margin: const EdgeInsets.only(
                  left: 0.0, top: 0.0, bottom: 10.0, right: 0.0),
              child: FutureBuilder<Widget>(
                future: getPoster(index, type, isMovie),
                builder: (BuildContext ctx, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final poster = snapshot.data;
                    if (poster != null) {
                      return poster;
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
                future: getTitle(index, type, isMovie), // a previously-obtained Future<String> or null
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
                future: getVoteAverage(index, type, isMovie),
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
                future: getReleaseDate(index, type, isMovie), // a previously-obtained Future<String> or null
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
  Widget _buildBoxShows(int index, String type, bool isMovie) => Container(
        margin: const EdgeInsets.all(8),
        height: 360,
        width: 200,
        child: OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    ShowDetails(showId: "${showList[index].id}"),
                fullscreenDialog: true,
              ),
            );
          },
          child: Column(children: <Widget>[
            Container(
              width: 200,
              height: 250,
              margin: const EdgeInsets.only(
                  left: 0.0, top: 0.0, bottom: 10.0, right: 0.0),
              child: FutureBuilder<Widget>(
                future: getPoster(index, type, isMovie),
                builder: (BuildContext ctx, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final poster = snapshot.data;
                    if (poster != null) {
                      return poster;
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
                future: getTitle(index, type, isMovie), // a previously-obtained Future<String> or null
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
                future: getVoteAverage(index, type, isMovie),
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
                future: getReleaseDate(index, type, isMovie), // a previously-obtained Future<String> or null
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  return Text('Date First Aired: ${snapshot.data}',
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
