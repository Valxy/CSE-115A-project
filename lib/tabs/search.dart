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
        return const CircularProgressIndicator();
      },
    );
  }

  // the plan for this function is to show some suggested movies when
  // the serach bar is open, this will be implemented later
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<MinimizedMovie>>(
      future: testDetails,
      builder:
          (BuildContext ctx, AsyncSnapshot<List<MinimizedMovie>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return buildSuggestionsSuccess(snapshot.data);
        }
        return const CircularProgressIndicator();
      },
    );
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
            Widget noPoster = const Icon(
              Icons.local_movies_outlined,
              size: 40,
            );

            if (results[index] is MinimizedMovie) {
              movieResult = resultItem;
              resultId = movieResult.id;
              posterPath = movieResult?.posterPath ?? "";
              title = movieResult?.title ?? "";
            } else if (results[index] is MinimizedTvShow) {
              tvResult = resultItem;
              resultId = tvResult.id;
              posterPath = tvResult?.posterPath ?? "";
              title = tvResult.name;
            } else {
              print("some other stuff");
              print(results[index].toString());
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
                title: Text(title));
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
              leading: Image.network("https://image.tmdb.org/t/p/w500" +
                  (suggestion.posterPath ?? "")),
              title: Text(suggestion?.title ?? ""),
            );
          } else {
            return const Text("");
          }
        });
  }
}
