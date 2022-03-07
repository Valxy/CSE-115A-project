import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/src/api_objects.dart';
import '../models/tmdb_api_wrapper.dart';

class Episodes extends StatefulWidget {
  final TvShow tvShow;
  final int seasonNumber;

  const Episodes({
    Key? key,
    required this.tvShow,
    this.seasonNumber = 1,
  }) : super(key: key);

  @override
  _EpisodesState createState() => _EpisodesState();
}

class _EpisodesState extends State<Episodes> {
  late Future<TvShowSeason> seasonDetails;
  late int seasonNumber;

  @override
  void initState() {
    super.initState();
    seasonDetails = TmdbApiWrapper().getDetailsTvShowSeason(
        tvId: widget.tvShow.id, seasonNumber: widget.seasonNumber);
    seasonNumber = widget.seasonNumber;
    //_CustomMenuItem(
    //  name: "Season ${widget.seasonNumber}", index: widget.seasonNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FutureBuilder(
          future: seasonDetails,
          builder: (BuildContext ctx, AsyncSnapshot<TvShowSeason> snapshot) {
            return Text(widget.tvShow.name);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DropdownButton<int>(
            isExpanded: true,
            value: seasonNumber,
            onChanged: (int? newValue) {
              setState(() {
                seasonNumber = newValue!;

                seasonDetails = TmdbApiWrapper().getDetailsTvShowSeason(
                    tvId: widget.tvShow.id, seasonNumber: seasonNumber);
              });
            },
            items: widget.tvShow.seasons
                .map((e) => DropdownMenuItem<int>(
                      value: e.seasonNumber,
                      child: Text(e.name),
                    ))
                .toList(),
          ),
          FutureBuilder(
            future: seasonDetails,
            builder: (BuildContext ctx, AsyncSnapshot<TvShowSeason> snapshot) {
              final TvShowSeason? season = snapshot.data;
              if (!snapshot.hasData || season == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }
              final DateFormat formatter = DateFormat('MMM dd, yyyy');
              return Expanded(
                child: ListView.builder(
                  itemCount: season.episodes.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      // this is for when you click on an episode
                      onTap: () {
                        // TODO: subpage for each episode
                      },

                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 60,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(8.0),
                                        bottom: Radius.circular(8.0),
                                      ),
                                      child: season.episodes[index].poster,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Text(
                                            season.episodes[index].name,
                                          ),
                                          Text(
                                            season.episodes[index].airDate
                                                        .length !=
                                                    10
                                                ? ""
                                                : formatter.format(
                                                    DateFormat('yyyy-MM-dd')
                                                        .parse(
                                                      season.episodes[index]
                                                          .airDate,
                                                    ),
                                                  ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                season.episodes[index].overview,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
