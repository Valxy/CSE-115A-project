import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/tmdb_api_wrapper.dart';
import '../widgets/youtube_player.dart';

import './person_details.dart';

class TVShowPage extends StatefulWidget {
  final num id;

  const TVShowPage({Key? key, required this.id}) : super(key: key);

  @override
  _TVShowPageState createState() => _TVShowPageState();
}

class _TVShowPageState extends State<TVShowPage> {
  late Future<TvShow> tvShowDetails;

  @override
  void initState() {
    super.initState();

    tvShowDetails = TmdbApiWrapper().getDetailsTvShow(tvId: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FutureBuilder(
          future: tvShowDetails,
          builder: (BuildContext ctx, AsyncSnapshot<TvShow> snapshot) {
            return Text(snapshot.data?.name ?? "");
          },
        ),
      ),
      body: FutureBuilder(
        future: tvShowDetails,
        builder: (BuildContext ctx, AsyncSnapshot<TvShow> snapshot) {
          final TvShow? tvShow = snapshot.data;

          if (!snapshot.hasData || tvShow == null) {
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

          for (var cast in tvShow.cast) {
            seen.add(cast.originalName);
          }

          List<CrewMember> uniqueCrew = tvShow.crew
              .where((crew) =>
                  seen.add(crew.originalName) && crew.profilePath != "")
              .toList();

          uniqueCrew.sort((a, b) => (b.popularity - a.popularity).ceil());

          List<Video> youtubeVideos =
              tvShow.videos.where((video) => video.site == "YouTube").toList();

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
                      tvShow.backdrops
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
                        child: tvShow.poster,
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
                                snapshot.data?.name ?? "",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Wrap(
                                spacing: 14,
                                children: [
                                  Text(
                                    tvShow.firstAirDate.split("-")[0],
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    tvShow.lastAirDate.split("-")[0],
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
                                  children: tvShow.genres
                                      .sublist(
                                        0,
                                        min(tvShow.genres.length, 3),
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
                          children: tvShow.cast
                              .where((cast) => cast.profilePath != "")
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            ShowPersonDetails(
                                                personId: "${e.id}"),
                                        fullscreenDialog: true,
                                      ),
                                    );
                                  },
                                  child: Column(
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
                                      (e) => GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  ShowPersonDetails(
                                                      personId: "${e.id}"),
                                              fullscreenDialog: true,
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
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
