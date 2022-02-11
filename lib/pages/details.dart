import 'package:carousel_slider/carousel_slider.dart';
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
        title: FutureBuilder(
          future: movieDetails,
          builder: (BuildContext ctx, AsyncSnapshot<Movie> snapshot) {
            return Text(snapshot.data?.title ?? "");
          },
        ),
      ),
      body: FutureBuilder(
        future: movieDetails,
        builder: (BuildContext ctx, AsyncSnapshot<Movie> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                ],
              ),
            );
          }

          final posters = snapshot.data!.posters;

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      disableCenter: true,
                      viewportFraction: 1,
                    ),
                    items: <Widget>[
                      Container(
                        width: 384.0,
                        color: Colors.red,
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
                  child: Container(
                    height: 240,
                    padding: const EdgeInsets.all(0),
                    child: Row(children: [
                      posters[0],
                      const Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        flex: 22,
                        child: Container(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data?.title ?? "",
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "",
                              ),
                              Wrap(
                                spacing: 18,
                                children: [
                                  Text(
                                    snapshot.data!.releaseDate.split("-")[0],
                                  ),
                                  const Text(
                                    "PG-13",
                                  ),
                                  Text(
                                    "${snapshot.data!.runtime! ~/ 60}h",
                                  )
                                ],
                              ),
                              const Text(
                                "",
                              ),
                              Text(snapshot.data?.overview ?? "",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ]),
                  ),
                ),
                Card(
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data!.crew
                          .map(
                            (e) => Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CircleAvatar(
                                    radius: 50.0,
                                    child: Text(e.name.split(" ")[0][0]),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Center(
                                    child: Text(
                                      e.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
