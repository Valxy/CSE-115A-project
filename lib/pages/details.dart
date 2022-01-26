import 'package:flutter/material.dart';

import '../widgets/YoutubePlayer.dart';

class ShowDetails extends StatefulWidget {
  final String showId;

  const ShowDetails({Key? key, required this.showId}) : super(key: key);

  @override
  _ShowDetailsState createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            widget.showId,
          ),
          Container(
            alignment: Alignment.center,
            height: 600,
            width: 400,
            child:
                YoutubeTrailer("https://www.youtube.com/watch?v=JfVOs4VSpmA"),
          ),
        ],
      ),
    );
  }
}
