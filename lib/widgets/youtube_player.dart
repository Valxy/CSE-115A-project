import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeTrailer extends StatefulWidget {
  final String youtubeId;

  const YoutubeTrailer(this.youtubeId, {Key? key}) : super(key: key);

  @override
  _YoutubeTrailerState createState() => _YoutubeTrailerState();
}

class _YoutubeTrailerState extends State<YoutubeTrailer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: widget.youtubeId,
        params: const YoutubePlayerParams(
          autoPlay: false,
          playsInline: false,
          showVideoAnnotations: false,
          strictRelatedVideos: true,
        ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      alignment: Alignment.centerRight,
      child: SizedBox(
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
