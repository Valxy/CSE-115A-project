import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/tmdb_api_wrapper.dart';
import '../widgets/youtube_player.dart';

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
          final Movie? movie = snapshot.data;

          if (!snapshot.hasData || movie == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                ],
              ),
            );
          }

          var seen = <String>{};

          for (var cast in movie.cast) {
            seen.add(cast.originalName);
          }

          List<CrewMember> uniqueCrew = movie.crew
              .where((crew) =>
                  seen.add(crew.originalName) && crew.profilePath != "")
              .toList();

          uniqueCrew.sort((a, b) => (b.popularity - a.popularity).ceil());

          return SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    disableCenter: true,
                    viewportFraction: 1,
                  ),
                  items: <Widget>[
                        YoutubeTrailer(
                            "https://www.youtube.com/watch?v=${movie.videos.where((video) => video.site == "YouTube").first.key}"),
                      ] +
                      movie.backdrops
                          .map(
                            (e) => SizedBox(
                              width: 384.0,
                              child: FittedBox(
                                child: e,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                          .toList(),
                ),
                Card(
                  child: Container(
                    height: 280,
                    padding: const EdgeInsets.all(0),
                    child: Row(children: [
                      SizedBox(
                        child: movie.posters[0],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data?.title ?? "",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Wrap(
                                spacing: 14,
                                children: [
                                  Text(
                                    movie.releaseDate.split("-")[0],
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    movie.releases.first.certification,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    "${movie.runtime ~/ 60}h",
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Wrap(
                                  spacing: 4,
                                  children: movie.genres
                                      .sublist(
                                        0,
                                        min(movie.genres.length, 3),
                                      )
                                      .map(
                                        (e) => SizedBox(
                                          child: Chip(
                                            label: Text(
                                              e.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                            visualDensity: const VisualDensity(
                                                horizontal: -4.0,
                                                vertical: -4.0),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                snapshot.data?.overview ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 8,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ]),
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 6),
                        child: Text(
                          'Cast',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Container(
                        height: 150,
                        padding: const EdgeInsets.all(0),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: movie.cast
                              .where((cast) => cast.profilePath != "")
                              .map(
                                (e) => Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CircleAvatar(
                                        radius: 50.0,
                                        foregroundImage: NetworkImage(
                                            "https://image.tmdb.org/t/p/w500" +
                                                e.profilePath),
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
                      )
                    ],
                  ),
                ),
                uniqueCrew.isNotEmpty
                    ? Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 6),
                              child: Text(
                                'Crew',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Container(
                              height: 150,
                              padding: const EdgeInsets.all(0),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: uniqueCrew
                                    .map(
                                      (e) => Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: CircleAvatar(
                                              radius: 50.0,
                                              foregroundImage: NetworkImage(
                                                  "https://image.tmdb.org/t/p/w500" +
                                                      e.profilePath),
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
                            )
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }
}
