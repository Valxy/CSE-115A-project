import 'package:flutter/material.dart';

import '../models/tmdb_api_wrapper.dart';
import '../widgets/YoutubePlayer.dart';

class ShowDetails extends StatefulWidget {
  final String showId;

  const ShowDetails({Key? key, required this.showId}) : super(key: key);

  @override
  _ShowDetailsState createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  late Future<Movie> movieDetails;

  @override
  void initState() {
    super.initState();

    movieDetails = TmdbApiWrapper().getDetailsMovie(movieId: widget.showId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            height: 216.0,
            child: ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                FutureBuilder<Movie>(
                  future: movieDetails,
                  builder: (BuildContext ctx, AsyncSnapshot<Movie> snapshot) {
                    if (snapshot.hasData && snapshot.data?.posters != null) {
                      final posters = snapshot.data?.posters;
                      if (posters != null) {
                        return posters[2];
                      }
                    }

                    return CircularProgressIndicator();
                  },
                ),
                Container(
                  width: 384.0,
                  color: Colors.blue,
                ),
                Container(
                  width: 384.0,
                  color: Colors.green,
                ),
                Container(
                  width: 384.0,
                  color: Colors.yellow,
                ),
                Container(
                  width: 384.0,
                  color: Colors.orange,
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FutureBuilder<Movie>(
                  future: movieDetails,
                  builder: (BuildContext ctx, AsyncSnapshot<Movie> snapshot) {
                    if (snapshot.hasData) {
                      return ListTile(
                        title: Text(snapshot.data?.title ?? ""),
                        subtitle: Text(snapshot.data?.overview ?? ""),
                      );
                    }

                    return CircularProgressIndicator();
                  },
                )
              ],
            ),
          ),
          Container(
            height: 300,
            child:
                YoutubeTrailer("https://www.youtube.com/watch?v=JfVOs4VSpmA"),
          ),
        ],
      ),
    );
  }
}
