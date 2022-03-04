// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/tmdb_api_wrapper.dart';
import 'details.dart';

class FilterResults extends StatefulWidget {
  const FilterResults({Key? key, required this.genre}) : super(key: key);
  final int genre;
  @override
  _FilterResultsState createState() => _FilterResultsState();
}

class FilterModel {
  String title;
  bool isCheck = false;
  FilterModel(this.title, this.isCheck);
  @override
  String toString() {
    return {'title': title, 'isCheck': isCheck}.toString();
  }
}

class _FilterResultsState extends State<FilterResults> {
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
  late List<MinimizedMovie> movieList1 = [];
  late List<MinimizedTvShow> tvList1 = [];
  late Future<List<MinimizedMovie>> movieList;
  late Future<List<MinimizedTvShow>> tvList;
  late Future<List<dynamic>> resultList;
  List<FilterModel> movieYear = [
    FilterModel('1990', false),
    FilterModel("2000", false),
    FilterModel("2010", false),
    FilterModel("2020", false)
  ];
  List<FilterModel> movieGenre = [
    FilterModel('Action', false),
    FilterModel("Action&Advanture", false),
    FilterModel("Horror", false),
    FilterModel("Animation", false),
    FilterModel("Crime", false),
    FilterModel("Comedy", false),
    FilterModel("Drama", false),
    FilterModel("Romance", false),
  ];
  List<FilterModel> movieType = [
    FilterModel('TV Show', false),
    FilterModel("Movie", false),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
    //var temp = movieList.length;
    // print("genreId: " + widget.genre.toString());
    // print(temp);
  }

  _loadData() async {
    movieList1 =
        await TmdbApiWrapper().getMovieListFromGenreId(genreId: widget.genre);
    movieList = TmdbApiWrapper().getMovieListFromGenreId(genreId: widget.genre);
    tvList1 = await TmdbApiWrapper().getPopularTvShows(1);
    tvList = TmdbApiWrapper().getPopularTvShows(1);
    setState(() {
      //var temp = movieList1.length;
      //print(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        endDrawer: drawerSystem(),
        body: GridView.builder(
            itemCount: movieList1.length + tvList1.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.5),
            itemBuilder: (BuildContext context, int index) {
              if (widget.genre == 10759 ||
                  widget.genre == 10762 ||
                  widget.genre == 10763 ||
                  widget.genre == 10765 ||
                  widget.genre == 10767 ||
                  widget.genre == 10768 ||
                  widget.genre == 10752 ||
                  widget.genre == 10770) {
                return _buildBoxShows(tvList, index);
              } else {
                return _buildBoxMovies(movieList, index);
              }
              //throw ("Error: One or more elements were not able to be built successfully!");
            }));
  }

  //filter
  Widget drawerSystem() {
    return Drawer(
      child: Container(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.fromLTRB(
                      10,
                      MediaQueryData.fromWindow(window).padding.top + 10,
                      0,
                      10),
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: const Text(
                    'Filter',
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                    child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 80),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: const Text('Years'),
                        ),
                        Wrap(
                          spacing: 2,
                          runSpacing: 5,
                          children: FilterItems(movieYear),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: const Text('Genre'),
                        ),
                        Wrap(
                          spacing: 2,
                          runSpacing: 5,
                          children: FilterItems(movieGenre),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: const Text('Type'),
                        ),
                        Wrap(
                          spacing: 2,
                          runSpacing: 5,
                          children: FilterItems(movieType),
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            ),
            Positioned(
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Reset')),
                    Container(
                      width: 20,
                    ),
                    FlatButton(
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Apply'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // build method for each individual tag in filter
  List<Widget> FilterItems(List<FilterModel> filters) {
    // print(filters);
    return List.generate(filters.length, (index) {
      var item = filters[index];
      return InkWell(
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: item.isCheck ? Colors.blue : Colors.black54,
                  width: 1.0),
              color: item.isCheck ? Colors.blue : Colors.grey.shade100),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
            child: Text(
              item.title,
              style:
                  TextStyle(color: item.isCheck ? Colors.white : Colors.black),
            ),
          ),
        ),
        onTap: () {
          item.isCheck = !item.isCheck;
          setState(() {});
        },
      );
    });
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
            return InkWell(
              onTap: () {
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
                  Stack(
                    children: <Widget>[
                      Container(
                          width: 200,
                          height: 260,
                          margin: const EdgeInsets.only(
                              left: 0.0, top: 0.0, bottom: 12.0, right: 0.0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8.0),
                            ),
                            child: snapshot.data![index].getPoster(),
                          )),
                      Container(
                        height: 200,
                        width: 32,
                        alignment: const Alignment(-0.8, 1.85),
                        child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black),
                            child: CircularPercentIndicator(
                              radius: 16,
                              percent:
                                  snapshot.data![index].voteAverage * (0.1),
                              lineWidth: 4,
                              backgroundColor: Colors.yellow,
                              center: Text(
                                (snapshot.data![index].voteAverage *
                                            (0.1) *
                                            100)
                                        .round()
                                        .toString() +
                                    "%",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                              progressColor: Colors.green,
                            )),
                      ),
                    ],
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                        left: 10.0, top: 2.0, bottom: 2.0, right: 10.0),
                    child: Text(snapshot.data![index].title,
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                        left: 10.0, top: 0.0, bottom: 2.0, right: 10.0),
                    child: Text(
                        '${months[DateTime.parse(snapshot.data![index].releaseDate).month - 1]} '
                        '${DateTime.parse(snapshot.data![index].releaseDate).day}, '
                        '${DateTime.parse(snapshot.data![index].releaseDate).year}',
                        style: Theme.of(context).textTheme.caption),
                  ),
                ],
              ),
            );
          },
        ),
      );

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
            return InkWell(
              onTap: () {
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
                  Stack(
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 260,
                        margin: const EdgeInsets.only(
                            left: 0.0, top: 0.0, bottom: 12.0, right: 0.0),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8.0),
                          ),
                          child: snapshot.data![index].getPoster(),
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 32,
                        alignment: const Alignment(-0.8, 1.85),
                        child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black),
                            child: CircularPercentIndicator(
                              radius: 16,
                              percent:
                                  snapshot.data![index].voteAverage * (0.1),
                              lineWidth: 4,
                              backgroundColor: Colors.yellow,
                              center: Text(
                                (snapshot.data![index].voteAverage *
                                            (0.1) *
                                            100)
                                        .round()
                                        .toString() +
                                    "%",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                              progressColor: Colors.green,
                            )),
                      ),
                    ],
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                        left: 10.0, top: 2, bottom: 2.0, right: 10.0),
                    child: Text(snapshot.data![index].name,
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                        left: 10.0, top: 0.0, bottom: 2.0, right: 10.0),
                    child: Text(
                        '${months[DateTime.parse(snapshot.data![index].firstAirDate).month - 1]} '
                        '${DateTime.parse(snapshot.data![index].firstAirDate).day}, '
                        '${DateTime.parse(snapshot.data![index].firstAirDate).year}',
                        style: Theme.of(context).textTheme.caption),
                  ),
                ],
              ),
            );
          },
        ),
      );
}
