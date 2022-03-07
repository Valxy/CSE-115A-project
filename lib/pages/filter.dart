// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/tmdb_api_wrapper.dart';
import 'movie.dart';

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
  late List<MinimizedMovie> movieList = [];
  late List<MinimizedTvShow>? tvList = [];
  late List<dynamic> resultList;
  List<FilterModel> movieYear = [
    FilterModel('1990', false),
    FilterModel("2000", false),
    FilterModel("2010", false),
    FilterModel("2020", false),
    FilterModel("2021", false),
    FilterModel("2022", false),
  ];
  // List<FilterModel> movieGenre = [
  //   FilterModel('Action', false),
  //   FilterModel("Action&Advanture", false),
  //   FilterModel("Horror", false),
  //   FilterModel("Animation", false),
  //   FilterModel("Crime", false),
  //   FilterModel("Comedy", false),
  //   FilterModel("Drama", false),
  //   FilterModel("Romance", false),
  // ];
  List<FilterModel> movieType = [
    FilterModel("Movie", false),
    FilterModel('TV Show', false),
  ];
  int yearIndex = -1;
  int genreIndex = -1;
  int typeIndex = -1;

  @override
  void initState() {
    super.initState();
    _loadData();
    //var temp = movieList.length;
    // print("genreId: " + widget.genre.toString());
    // print(temp);
  }

  _loadData() async {
    movieList =
        await TmdbApiWrapper().getMovieListFromGenreId(genreId: widget.genre);
    tvList = await TmdbApiWrapper().getTvListFromGenreId(genreId: widget.genre);

    setState(() {
      //var temp = movieList1.length;
      //print(temp);
    });
  }

  reset() {
    yearIndex = -1;
    genreIndex = -1;
    typeIndex = -1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: const BackButton()),
        endDrawer: drawerSystem(),
        body: getTypeMainView());
  }

  getTypeMainView() {
    if (widget.genre == 10759 ||
        widget.genre == 16 ||
        widget.genre == 35 ||
        widget.genre == 80 ||
        widget.genre == 99 ||
        widget.genre == 18 ||
        widget.genre == 10751 ||
        widget.genre == 10762 ||
        widget.genre == 9648 ||
        widget.genre == 10763 ||
        widget.genre == 10765 ||
        widget.genre == 10767 ||
        widget.genre == 10768 ||
        widget.genre == 37) {
      if (tvList == null || tvList!.isEmpty) {
        return Container();
      }
    }

    switch (typeIndex) {
      case -1:
        late List<MinimizedTvShow> tvShowList = [];
        late List<MinimizedMovie> showList = [];
        if (yearIndex == -1) {
          tvShowList.addAll(tvList!);
          showList.addAll(movieList);
        } else {
          for (var element in tvList!) {
            if (movieYear[yearIndex].title ==
                '${DateTime.parse(element.firstAirDate).year}') {
              tvShowList.add(element);
            }
          }

          for (var element in movieList) {
            if (movieYear[yearIndex].title ==
                '${DateTime.parse(element.releaseDate).year}') {
              showList.add(element);
            }
          }
        }

        return GridView.builder(
            itemCount: tvShowList.length + showList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.5),
            itemBuilder: (BuildContext context, int index) {
              if (index < showList.length) {
                return _buildBoxMovies(showList, index);
              } else {
                return _buildBoxShows(tvShowList, index - showList.length);
              }
              //throw ("Error: One or more elements were not able to be built successfully!");
            });

      case 0:
        late List<MinimizedTvShow> tvShowList = [];
        if (yearIndex == -1) {
          tvShowList.addAll(tvList!);
        } else {
          for (var element in tvList!) {
            if (movieYear[yearIndex].title ==
                '${DateTime.parse(element.firstAirDate).year}') {
              tvShowList.add(element);
            }
          }
        }
        return GridView.builder(
            itemCount: tvShowList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.5),
            itemBuilder: (BuildContext context, int index) {
              return _buildBoxShows(tvShowList, index);
              //throw ("Error: One or more elements were not able to be built successfully!");
            });

      case 1:
        late List<MinimizedMovie> showList = [];
        if (yearIndex == -1) {
          showList.addAll(movieList);
        } else {
          for (var element in movieList) {
            if (movieYear[yearIndex].title ==
                '${DateTime.parse(element.releaseDate).year}') {
              showList.add(element);
            }
          }
        }
        return GridView.builder(
            itemCount: movieList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.5),
            itemBuilder: (BuildContext context, int index) {
              return _buildBoxMovies(movieList, index);
              //throw ("Error: One or more elements were not able to be built successfully!");
            });
    }
  }

  //filter
  Widget drawerSystem() {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.fromLTRB(10,
                    MediaQueryData.fromWindow(window).padding.top + 10, 0, 10),
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
                        children: filterItems(0, movieYear),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      //   child: const Text('Genre'),
                      // ),
                      // Wrap(
                      //   spacing: 2,
                      //   runSpacing: 5,
                      //   children: filterItems(1, movieGenre),
                      // ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: const Text('Type'),
                      ),
                      Wrap(
                        spacing: 2,
                        runSpacing: 5,
                        children: filterItems(2, movieType),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                      color: Colors.blue,
                      onPressed: () => reset(),
                      child: const Text('Reset')),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // build method for each individual tag in filter
  List<Widget> filterItems(int type, List<FilterModel> filters) {
    return List.generate(filters.length, (index) {
      var item = filters[index];
      Color bgColor = Colors.grey.shade100;
      Color txtColor = Colors.black;
      switch (type) {
        case 0:
          bgColor = yearIndex == index ? Colors.blue : Colors.grey.shade100;
          txtColor = yearIndex == index ? Colors.white : Colors.black;
          break;
        case 1:
          bgColor = genreIndex == index ? Colors.blue : Colors.grey.shade100;
          txtColor = genreIndex == index ? Colors.white : Colors.black;
          break;
        case 2:
          bgColor = typeIndex == index ? Colors.blue : Colors.grey.shade100;
          txtColor = typeIndex == index ? Colors.white : Colors.black;
          break;
      }
      return InkWell(
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black54, width: 1.0),
              color: bgColor),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
            child: Text(
              item.title,
              style: TextStyle(color: txtColor),
            ),
          ),
        ),
        onTap: () {
          item.isCheck = !item.isCheck;
          switch (type) {
            case 0:
              yearIndex = index;
              break;
            case 1:
              genreIndex = index;
              break;
            case 2:
              typeIndex = index;
              break;
          }
          // print('yearIndex:$yearIndex');
          // print('genreIndex:$genreIndex');
          // print('typeIndex:$typeIndex');
          setState(() {});
        },
      );
    });
  }

  // build method for each individual movie
  Widget _buildBoxMovies(List<MinimizedMovie> movies, int index) => Container(
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
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    MoviePage(id: movies[index].id),
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
                        child: movies[index].getPoster(),
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
                          percent: movies[index].voteAverage * (0.1),
                          lineWidth: 4,
                          backgroundColor: Colors.yellow,
                          center: Text(
                            (movies[index].voteAverage * (0.1) * 100)
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
                child: Text(movies[index].title,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              Container(
                width: 200,
                margin: const EdgeInsets.only(
                    left: 10.0, top: 0.0, bottom: 2.0, right: 10.0),
                child: Text(
                    '${months[DateTime.parse(movies[index].releaseDate).month - 1]} '
                    '${DateTime.parse(movies[index].releaseDate).day}, '
                    '${DateTime.parse(movies[index].releaseDate).year}',
                    style: Theme.of(context).textTheme.caption),
              ),
            ],
          ),
        ),
      );

  Widget _buildBoxShows(List<MinimizedTvShow> shows, int index) => Container(
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
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    MoviePage(id: shows[index].id),
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
                        left: 0.0, top: 0.0, bottom: 10.0, right: 0.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8.0),
                      ),
                      child: shows[index].getPoster(),
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
                          percent: shows[index].voteAverage * (0.1),
                          lineWidth: 4,
                          backgroundColor: Colors.yellow,
                          center: Text(
                            (shows[index].voteAverage * (0.1) * 100)
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
                child: Text(shows[index].name,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              Container(
                width: 200,
                margin: const EdgeInsets.only(
                    left: 10.0, top: 0.0, bottom: 2.0, right: 10.0),
                child: Text(
                    '${months[DateTime.parse(shows[index].firstAirDate).month - 1]} '
                    '${DateTime.parse(shows[index].firstAirDate).day}, '
                    '${DateTime.parse(shows[index].firstAirDate).year}',
                    style: Theme.of(context).textTheme.caption),
              ),
            ],
          ),
        ),
      );
}