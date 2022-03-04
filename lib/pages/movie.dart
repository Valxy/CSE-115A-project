import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/tmdb_api_wrapper.dart';
import '../widgets/persons.dart';
import '../widgets/youtube_player.dart';

class MoviePage extends StatefulWidget {
  final num id;

  const MoviePage({Key? key, required this.id}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late Future<Movie> movieDetails;

  @override
  void initState() {
    super.initState();

    movieDetails = TmdbApiWrapper().getDetailsMovie(movieId: widget.id);
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

          List<Video> youtubeVideos =
              movie.videos.where((video) => video.site == "YouTube").toList();

          youtubeVideos.shuffle();

          return SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    disableCenter: true,
                    viewportFraction: 1,
                  ),
                  items: (youtubeVideos.isNotEmpty
                          ? <Widget>[
                              YoutubeTrailer(
                                  "https://www.youtube.com/watch?v=${youtubeVideos.first.key}"),
                            ]
                          : <Widget>[]) +
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
                        child: movie.poster,
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
                Persons(title: "Cast", persons: movie.cast),
                Persons(title: "Crew", persons: movie.crew),
              ],
            ),
          );
        },
      ),
    );
  }
}
