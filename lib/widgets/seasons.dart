import 'package:flutter/material.dart';

import '../models/src/api_objects.dart';

class Seasons extends StatelessWidget {
  final List<TvShowSeason> seasons;

  const Seasons({Key? key, required this.seasons}) : super(key: key);

  @override
  build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 6),
            child: Text(
              "Seasons",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 220),
            child: ListView(
              shrinkWrap: true,
              children: seasons.reversed
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        // TODO: Episodes page
                      },
                      child: ListTile(
                        dense: false,
                        leading: Image.network(
                            "https://image.tmdb.org/t/p/w500${e.posterPath}"),
                        title: Text(e.name),
                        subtitle: Text((e.airDate.length > 4
                                ? e.airDate.substring(0, 4)
                                : e.airDate) +
                            " | " +
                            "${e.episodeCount} Episodes"),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
