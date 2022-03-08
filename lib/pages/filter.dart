// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/tmdb_api_wrapper.dart';
import 'package:tmdb/pages/tvshow.dart';
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
  int gid;
  int minYear;
  int maxYear;
  FilterModel(this.title, this.isCheck, this.gid, this.minYear, this.maxYear);

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
  late List<MinimizedMovie> movieList = [];
  late List<MinimizedTvShow> tvList = [];
  List<MinimizedTvShow> resultList = [];
  List<FilterModel> movieYear = [
    FilterModel('Before 1980', false, -1, 1900, 1979),
    FilterModel('1980-1999', false, -1, 1980, 1999),
    FilterModel('2000-2010', false, -1, 2000, 2010),
    FilterModel("2011-2015", false, -1, 2011, 2015),
    FilterModel("2016-2020", false, -1, 2016, 2020),
    FilterModel("2021", false, -1, 2021, 2021),
    FilterModel("2022", false, -1, 2022, 2022),
  ];
  List<FilterModel> movieGenre = [
    FilterModel('Action', false, 28, 0, 0),
    FilterModel("Action&Advanture", false, 10759, 0, 0),
    FilterModel("Adventure", false, 12, 0, 0),
    FilterModel("Animation", false, 16, 0, 0),
    FilterModel("Comedy", false, 35, 0, 0),
    FilterModel("Crime", false, 80, 0, 0),
    FilterModel("Documentary", false, 99, 0, 0),
    FilterModel("Drama", false, 18, 0, 0),
    FilterModel("Family", false, 10751, 0, 0),
    FilterModel("Kids", false, 10762, 0, 0),
    FilterModel("Fantasy", false, 14, 0, 0),
    FilterModel("History", false, 36, 0, 0),
    FilterModel("Horror", false, 27, 0, 0),
    FilterModel("Music", false, 10402, 0, 0),
    FilterModel("Mystery", false, 9648, 0, 0),
    FilterModel("News", false, 10763, 0, 0),
    FilterModel("Romance", false, 10749, 0, 0),
    FilterModel("Science Fiction", false, 878, 0, 0),
    FilterModel("Sci-Fi & Fantasy", false, 10765, 0, 0),
    FilterModel("Talk", false, 10767, 0, 0),
    FilterModel("TV Movie", false, 10770, 0, 0),
    FilterModel("Thriller", false, 53, 0, 0),
    FilterModel("War", false, 10752, 0, 0),
    FilterModel("War & Politics", false, 10768, 0, 0),
    FilterModel("Western", false, 37, 0, 0),
  ];
  List<FilterModel> movieType = [
    FilterModel("Movie", false, -1, 0, 0),
    FilterModel('TV Show', false, -1, 0, 0),
  ];
  int yearIndex = -1;
  int genreIndex = -1;
  int typeIndex = -1;

  Future<List<MinimizedTvShow>> makeTvQuery(int pageNumber) async {
    return TmdbApiWrapper()
        .getTvListFromGenreId(genreId: widget.genre, pageNumber: pageNumber);
  }

  Future<void> updateTvResultList(int i) async {
    List<MinimizedTvShow> results = await makeTvQuery(i);
    tvList.addAll(results);
  }

  Future<List<MinimizedMovie>> makeMovieQuery(int pageNumber) async {
    return TmdbApiWrapper()
        .getMovieListFromGenreId(genreId: widget.genre, pageNumber: pageNumber);
  }

  Future<void> updateMovieResultList(int i) async {
    List<MinimizedMovie> movieResults = await makeMovieQuery(i);
    movieList.addAll(movieResults);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    //var temp = movieList.length;
    // print("genreId: " + widget.genre.toString());
    // print(temp);
  }

  _loadData() async {
    movieList = await TmdbApiWrapper()
        .getMovieListFromGenreId(genreId: widget.genre, pageNumber: 1);

    for (int i = 2; i < 8; i++) {
      updateMovieResultList(i);
    }
    tvList = await TmdbApiWrapper()
        .getTvListFromGenreId(genreId: widget.genre, pageNumber: 1);
    for (int i = 2; i < 8; i++) {
      updateTvResultList(i);
    }

    setState(() {});
  }

  reset() {
    yearIndex = -1;
    genreIndex = -1;
    typeIndex = -1;
    setState(() {});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              leading: const BackButton(),
              backgroundColor: const Color.fromARGB(255, 97, 153, 218),
            ),
            preferredSize: const Size.fromHeight(50.0)),
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
      if ((tvList.isEmpty)) {
        return Container();
      }
    }

    void updateTvShowGenre(List<MinimizedTvShow> tvShowList) {
      for (var element in tvList) {
        if (element.genres.isNotEmpty) {
          for (var e in element.genres) {
            if (e.id == movieGenre[genreIndex].gid) {
              tvShowList.add(element);
            }
          }
        }
      }
    }

    void updateTvShowYear(List<MinimizedTvShow> tvShowList) {
      for (var element in tvList) {
        if (element.firstAirDate.isNotEmpty &&
            movieYear[yearIndex].minYear <=
                DateTime.parse(element.firstAirDate).year &&
            movieYear[yearIndex].maxYear >=
                DateTime.parse(element.firstAirDate).year) {
          tvShowList.add(element);
        }
      }
    }

    void updateTvShowBoth(List<MinimizedTvShow> tvShowList) {
      for (var element in tvList) {
        if (element.genres.isNotEmpty && element.firstAirDate.isNotEmpty) {
          for (var e in element.genres) {
            if (e.id == movieGenre[genreIndex].gid &&
                movieYear[yearIndex].minYear <=
                    DateTime.parse(element.firstAirDate).year &&
                movieYear[yearIndex].maxYear >=
                    DateTime.parse(element.firstAirDate).year) {
              tvShowList.add(element);
            }
          }
        }
      }
    }

    void updateMovieGenre(List<MinimizedMovie> showList) {
      for (var element in movieList) {
        if (element.genres.isNotEmpty) {
          for (var e in element.genres) {
            if (e.id == movieGenre[genreIndex].gid) {
              showList.add(element);
            }
          }
        }
      }
    }

    void updateMovieYear(List<MinimizedMovie> showList) {
      for (var element in movieList) {
        if (element.releaseDate.isNotEmpty &&
            movieYear[yearIndex].minYear <=
                DateTime.parse(element.releaseDate).year &&
            movieYear[yearIndex].maxYear >=
                DateTime.parse(element.releaseDate).year) {
          showList.add(element);
        }
      }
    }

    void updateMovieBoth(List<MinimizedMovie> showList) {
      for (var element in movieList) {
        if (element.genres.isNotEmpty && element.releaseDate.isNotEmpty) {
          for (var e in element.genres) {
            if (e.id == movieGenre[genreIndex].gid &&
                movieYear[yearIndex].minYear <=
                    DateTime.parse(element.releaseDate).year &&
                movieYear[yearIndex].maxYear >=
                    DateTime.parse(element.releaseDate).year) {
              showList.add(element);
            }
          }
        }
      }
    }

    switch (typeIndex) {
      // nothing chosen
      case -1:
        late List<MinimizedTvShow> tvShowList = [];
        late List<MinimizedMovie> showList = [];
        if (yearIndex == -1 && genreIndex == -1) {
          tvShowList.addAll(tvList);
          showList.addAll(movieList);
        } else if (yearIndex != -1 && genreIndex == -1) {
          updateTvShowYear(tvShowList);
          updateMovieYear(showList);
        } else if (genreIndex != -1 && yearIndex == -1) {
          updateMovieGenre(showList);
          updateTvShowGenre(tvShowList);
        } else {
          updateMovieBoth(showList);
          updateTvShowBoth(tvShowList);
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

      //type movie
      case 0:
        late List<MinimizedMovie> showList = [];
        if (yearIndex == -1 && genreIndex == -1) {
          showList.addAll(movieList);
        } else if (genreIndex == -1 && yearIndex != -1) {
          updateMovieYear(showList);
        } else if (yearIndex == -1 && genreIndex != -1) {
          updateMovieGenre(showList);
        } else {
          updateMovieBoth(showList);
        }

        return GridView.builder(
            itemCount: showList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.5),
            itemBuilder: (BuildContext context, int index) {
              return _buildBoxMovies(showList, index);
              //throw ("Error: One or more elements were not able to be built successfully!");
            });

      // type tv
      case 1:
        late List<MinimizedTvShow> tvShowList = [];

        if (yearIndex == -1 && genreIndex == -1) {
          tvShowList.addAll(tvList);
        } else if (genreIndex == -1 && yearIndex != -1) {
          updateTvShowYear(tvShowList);
        } else if (yearIndex == -1 && genreIndex != -1) {
          updateTvShowGenre(tvShowList);
        } else {
          updateTvShowBoth(tvShowList);
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
                height: MediaQuery.of(context).padding.top + 50,
                padding: EdgeInsets.fromLTRB(10,
                    MediaQueryData.fromWindow(window).padding.top + 20, 0, 10),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 97, 153, 218)),
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
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: const Text('Genre'),
                      ),
                      Wrap(
                        spacing: 2,
                        runSpacing: 5,
                        children: filterItems(1, movieGenre),
                      ),
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
              padding: const EdgeInsets.fromLTRB(105, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                      color: const Color.fromARGB(255, 97, 153, 218),
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
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                        left: 10.0, top: 2.0, bottom: 2.0, right: 10.0),
                    child: Text(movies[index].title,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(bottom: 5),
                    margin: const EdgeInsets.only(
                        left: 10.0, top: 0.0, bottom: 2.0, right: 10.0),
                    child: Text(
                        movies[index].releaseDate.isEmpty
                            ? ''
                            : '${months[DateTime.parse(movies[index].releaseDate).month - 1]} '
                                '${DateTime.parse(movies[index].releaseDate).day}, '
                                '${DateTime.parse(movies[index].releaseDate).year}',
                        style: Theme.of(context).textTheme.caption),
                  ),
                ],
              ))
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
                    TVShowPage(id: shows[index].id),
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
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                        left: 10.0, top: 2, bottom: 2.0, right: 10.0),
                    child: Text(shows[index].name,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.titleSmall),
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
              )),
            ],
          ),
        ),
      );
}
