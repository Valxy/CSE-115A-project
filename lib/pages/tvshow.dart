import 'dart:math';

import 'package:flutter/material.dart';

import '../models/tmdb_api_wrapper.dart';
import '../widgets/backdrops_carousel.dart';
import '../widgets/persons.dart';
import '../widgets/reviews.dart';
import '../widgets/seasons.dart';

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

          return SingleChildScrollView(
            child: Column(
              children: [
                BackdropsCarousel(
                  backdrops: tvShow.backdrops,
                  videos: tvShow.videos,
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
                                    tvShow.firstAirDate.split("-")[0] +
                                        " - " +
                                        tvShow.lastAirDate.split("-")[0],
                                    style: Theme.of(context).textTheme.caption,
                                  ),
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
                Seasons(
                  seasons: tvShow.seasons,
                ),
                Reviews(
                  reviews: tvShow.reviews,
                ),
                Persons(
                  title: "Cast",
                  persons: tvShow.cast,
                ),
                Persons(
                  title: "Crew",
                  persons: uniqueCrew,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
