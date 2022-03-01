import 'package:flutter/material.dart';
import 'package:tmdb/models/src/api_objects.dart';
import '../models/tmdb_api_wrapper.dart';

class SeasonDetails extends StatefulWidget {
  final TvShow tvShow;
  final int seasonNumber;

  const SeasonDetails({
    Key? key,
    required this.tvShow,
    this.seasonNumber = 1,
  }) : super(key: key);

  @override
  _SeasonDetailsState createState() => _SeasonDetailsState();
}

class _SeasonDetailsState extends State<SeasonDetails> {
  late Future<TvShowSeason> season;

  @override
  void initState() {
    super.initState();
    season = TmdbApiWrapper().getDetailsTvShowSeason(
        tvId: widget.tvShow.id, seasonNumber: widget.seasonNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: season,
      builder: (context, snapshot) {
        return Column(children: [
          Row(children: [Text("Episodes")]),
          DropdownButton<_CustomMenuItem>(
            items: List<DropdownMenuItem<_CustomMenuItem>>.generate(
                widget.tvShow.numberOfSeasons,
                (index) => DropdownMenuItem<_CustomMenuItem>(
                      child: _CustomMenuItem(
                        index: index,
                        name: "Season $index",
                      ),
                    )),
            onChanged: (value) {
              setState(() {});
            },
          ),
          ListView(),
        ]);
      },
    ));
  }
}

class _CustomMenuItem extends StatelessWidget {
  const _CustomMenuItem({
    required this.name,
    required this.index,
    Key? key,
  }) : super(key: key);

  final String name;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Text(name);
  }
}
