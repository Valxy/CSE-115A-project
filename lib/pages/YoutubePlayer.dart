import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// ignore: must_be_immutable
class YoutubeTrailer extends StatefulWidget {
  String urlLink;

  YoutubeTrailer(this.urlLink, {Key? key}) : super(key: key);

  @override
  _YoutubeTrailerState createState() => _YoutubeTrailerState();
}

class _YoutubeTrailerState extends State<YoutubeTrailer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId:
            YoutubePlayerController.convertUrlToId(widget.urlLink!)!,
        params: const YoutubePlayerParams(
          showControls: true,
          mute: true,
        ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 300,
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.all(5.0),
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: screenSize.width,
        width: screenSize.width,
        child: YoutubePlayerControllerProvider(
          controller: _controller,
          child: YoutubePlayerIFrame(
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
