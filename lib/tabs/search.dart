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
          title: const Text("search movies and tv shows"),
          centerTitle: true,
          actions: [
            IconButton(
              // search button
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchItem());
              },
            )
          ],
          backgroundColor: Colors.purple,
        ),
        body: Icon(Icons.search),
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

  // this function will build the query result and display it in a list
  // this will need to be impelmented as a list later
  // this only show one tile for now
  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.local_movies, size: 120),
          const SizedBox(
            height: 48,
          ),
          Text(
            query,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  // the plan for this function is to show some suggested movies when
  // the serach bar is open, this will be implemented later
  @override
  Widget buildSuggestions(BuildContext context) {
    // final suggestions = popularMovies;
    // return buildSuggestionsSuccess(suggestions);
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
                    builder: (BuildContext context) => ShowDetails(
                      showId: suggestion.id.toString(),
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              leading:
                  // TmdbApiWrapper().getImage(posterPath: suggestion.posterPath),
                  // TmdbApiWrapper().getImage(imagePath: suggestion.posterPath),
                  Image.network("https://image.tmdb.org/t/p/w500" +
                      (suggestion.posterPath ?? "")),
              title: Text(suggestion?.title ?? ""),
            );
          } else {
            return const Text("");
          }
        });
  }
}
