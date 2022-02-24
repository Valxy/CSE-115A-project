import 'package:flutter/material.dart';
import '../models/tmdb_api_wrapper.dart';
import '../pages/details.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: GestureDetector(
              onTap: () {
                showSearch(context: context, delegate: SearchItem());
              },
              child: Container(
                height: 50,
                color: Colors.white,
                child: Row(
                  children: const [
                    Text(
                      "Search",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )),
      );
}

class SearchItem extends SearchDelegate<String> {
  final ScrollController _scrollController = ScrollController();
  List<dynamic> resultList = [];
  ValueNotifier<int> resultSize = ValueNotifier<int>(0);
  int nextPage = 1;
  SearchItem() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        nextPage += 1;
        updateResultList();
      }
    });
  }

  @override
  // clear button
  // this function handles the X button on the top right corner
  // it clears the search query or closes the search bar if search bar is empty
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, "");
          } else {
            query = "";
          }
        },
      )
    ];
  }

  // backward button
  // this function is similar to the handle X button function
  // it closes the search bard regardless the content in the serach bar
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    resultList = [];
    nextPage = 1;
    late Future<List<dynamic>> results = makeQuery(pageNumber: 1);
    return FutureBuilder<List<dynamic>>(
      future: results,
      builder: (BuildContext ctx, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          resultList.addAll(snapshot.data ?? []);
          resultSize.value = resultList.length;
          return resultFetching(resultList);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildLiveResults(List<dynamic> results) {
    return buildListView(results);
  }

  Future<void> updateResultList() async {
    List<dynamic> results = await makeQuery(pageNumber: nextPage);
    resultList.addAll(results);
    resultSize.value = resultList.length;
  }

  // live serach result update
  // no longer needed
  @override
  Widget buildSuggestions(BuildContext context) {
    resultList = [];
    nextPage = 1;
    if (query.isNotEmpty) {
      late Future<List<dynamic>> results = makeQuery(pageNumber: 1);

      return FutureBuilder<List<dynamic>>(
        future: results,
        builder: (BuildContext ctx, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            // return buildResults(snapshot?.data ?? []);
            return buildLiveResults(snapshot.data ?? []);
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
    }
    return const Text("");
  }

  Future<List<dynamic>> makeQuery({int pageNumber = 1}) async {
    if (query.isNotEmpty) {
      return TmdbApiWrapper().search(query: query, pageNumber: pageNumber);
    }
    return [];
  }

  // main helper method for fetching results
  // used by live result and result
  Widget resultFetching(List<dynamic> someList) {
    return ValueListenableBuilder(
        valueListenable: resultSize,
        builder: (BuildContext ctx, int sizeValue, Widget? child) =>
            buildListView(someList));
  }

  // this method builds the layout of the list and where each result goes
  // it also parse the type of tv, movie or person object
  Widget buildListView(List<dynamic> someList) {
    return ListView.builder(
        controller: _scrollController,
        itemCount: someList.length,
        itemBuilder: (context, index) {
          if (someList.isNotEmpty && index < someList.length) {
            final resultItem = someList[index];
            MinimizedMovie movieResult; // movie object
            MinimizedTvShow tvResult; // tv object
            int resultId = 0; // id of the show/tv
            String posterPath = ""; // path of the poster
            String title = "no title";
            String year = "";
            String type = "none";
            Widget noPoster = const Icon(
              Icons.local_movies_outlined,
              size: 40,
            );

            if (someList[index] is MinimizedMovie) {
              movieResult = resultItem;
              resultId = movieResult.id;
              posterPath = movieResult.posterPath;
              title = movieResult.title;
              type = "movie";
              if (movieResult.releaseDate.length >= 4) {
                year = movieResult.releaseDate.substring(0, 4);
              } else {
                year = "";
              }
            } else if (someList[index] is MinimizedTvShow) {
              tvResult = resultItem;
              resultId = tvResult.id;
              posterPath = tvResult.posterPath;
              title = tvResult.name;
              type = "tv";
            } else {
              // if it's a person object, it'll return an empty text box
              return const Text("");
            }

            if (posterPath != "") {
              noPoster = Image.network(
                  "https://image.tmdb.org/t/p/w500" + (posterPath));
            }

            return buildListTile(
                year, resultId, title, type, context, noPoster);
          } else {
            return const Text("no data");
          }
        });
  }

  Widget buildSuggestionsSuccess(List<MinimizedMovie>? suggestions) {
    return ListView.builder(
        itemCount: suggestions?.length ?? 0,
        itemBuilder: (context, index) {
          if (suggestions != null && suggestions.isNotEmpty) {
            final suggestion = suggestions[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return ShowDetails(
                        showId: suggestion.id.toString(),
                      );
                    },
                    fullscreenDialog: true,
                  ),
                );
              },
              leading: Image.network(
                  "https://image.tmdb.org/t/p/w500" + (suggestion.posterPath)),
              title: Text(suggestion.title),
            );
          } else {
            return const Text("");
          }
        });
  }

  Widget getActors(int showId) {
    late Future<Movie> movieObj =
        TmdbApiWrapper().getDetailsMovie(movieId: showId);
    return FutureBuilder<Movie>(
      future: movieObj,
      builder: (BuildContext ctx, AsyncSnapshot<Movie> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<CastMember>? emptyCast;
          return Text(
            parseCast(snapshot.data?.cast ?? emptyCast),
            style: const TextStyle(fontSize: 11),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  String parseCast(List<CastMember>? temp) {
    String actorsList = "";
    if (temp != null) {
      for (int i = 0; i < temp.length && i < 3; i++) {
        actorsList += temp[i].originalName.toString();
        if (i < 2) {
          actorsList += ", ";
        }
      }
    }
    return actorsList;
  }

  // this method makes the result tile (rectangluar tile)
  Widget buildListTile(String year, resultId, title, type, BuildContext context,
      Widget noPoster) {
    Widget tile = ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ShowDetails(
              showId: resultId.toString(),
            ),
            fullscreenDialog: true,
          ),
        );
      },
      leading: noPoster,
      title: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title container
            Container(
              padding:
                  const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 5),
              child: Text(title),
            ),
            // year container
            if (year != "")

              // some movies/shows doesn't have years, so if that's the case
              // don't show the container
              Container(
                padding:
                    const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 5),
                child: Text(
                  year,
                  style: const TextStyle(fontSize: 11),
                ),
              ),

            // actor container
            if (type == "movie")
              Container(
                child: getActors(resultId),
              )
            else if (type == "tv")
              const Text("tv type"),
          ],
        ),
      ),
    );
    return tile;
  }
}
