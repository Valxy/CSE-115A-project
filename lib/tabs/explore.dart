import 'package:flutter/material.dart';

import '../models/tmdb_api_wrapper.dart';
import '../pages/details.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({Key? key}) : super(key: key);

  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final List<String> movie_titles = <String>[
    'Movie 1',
    'Movie 2',
    'Movie 3',
    'Movie 4'
  ];
  final List<String> movie_ratings = <String>[
    'Rated R',
    'Rated PG-13',
    'Not Yet Rated',
    'Rated M'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (_, i) {
          if (i % 2 != 1)
            return _buildText();
          else
            return _horizontalListView();
        },
      ),
    );
  }

  Widget _horizontalListView() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, __) => _buildBox(),
      ),
    );
  }

  Widget _buildBox() => Container(
        margin: EdgeInsets.all(12),
        height: 100,
        width: 200,
        //color: Colors.blue,
        child: OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    ShowDetails(showId: "634649"),
                fullscreenDialog: true,
              ),
            );
          },
          child: Text("Spider-Man: No Way Home\n\nRated PG-13"),
        ),
      );
  Widget _buildText() => Container(
      margin: EdgeInsets.all(12),
      height: 20,
      width: 200,
      child: Text("Popular Releases"));
}
