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
  late Future<List<MinimizedMovie>> testDetails;

  SearchItem() {
    testDetails = TmdbApiWrapper().getPopularMovies();
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
    late Future<List<dynamic>> results = TmdbApiWrapper().search(query: query);
    return FutureBuilder<List<dynamic>>(
      future: results,
      builder: (BuildContext ctx, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return resultFetching(snapshot.data);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // the plan for this function is to show some suggested movies when
  // the serach bar is open, this will be implemented later
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      late Future<List<dynamic>> results =
          TmdbApiWrapper().search(query: query);
      return FutureBuilder<List<dynamic>>(
        future: results,
        builder: (BuildContext ctx, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return resultFetching(snapshot.data);
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
    }
    return const Text("");
  }

  Widget resultFetching(List<dynamic>? results) {
    int resultSize = results?.length ?? 0;

    return ListView.builder(
        itemCount: results?.length ?? 0,
        itemBuilder: (context, index) {
          if (results != null && results.isNotEmpty && resultSize > 0) {
            final resultItem = results[index];
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

            if (results[index] is MinimizedMovie) {
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
            } else if (results[index] is MinimizedTvShow) {
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

            return ListTile(
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
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 0, bottom: 5),
                      child: Text(title),
                    ),
                    // year container
                    if (year != "")

                      // some movies/shows doesn't have years, so if that's the case
                      // don't show the container
                      Container(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 0, bottom: 5),
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
          } else {
            // return Container(
            //   alignment: Alignment.center,
            //   child: const Text("No result"),
            // );
            print("I am here");
            return Text("no data");
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
          List<CastMember>? emptyCast = null;
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
}
