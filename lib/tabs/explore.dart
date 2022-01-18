import 'package:flutter/material.dart';

import '../pages/details.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({Key? key}) : super(key: key);

  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ShowDetails(showId: "634649"),
              fullscreenDialog: true,
            ),
          );
        },
        child: Text("Spider-Man: No Way Home"),
      ),
    );
  }
}
