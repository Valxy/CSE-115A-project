import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../models/tmdb_api_wrapper.dart';
import '../widgets/youtube_player.dart';

class BackdropsCarousel extends StatelessWidget {
  final List<Widget> backdrops;
  final List<Video>? videos;

  const BackdropsCarousel({Key? key, required this.backdrops, this.videos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Video>? youtubeVideos =
        videos?.where((video) => video.site == "YouTube").toList();

    youtubeVideos?.shuffle();

    return CarouselSlider(
      options: CarouselOptions(
        disableCenter: true,
        viewportFraction: 1,
      ),
      items: (youtubeVideos != null && youtubeVideos.isNotEmpty
              ? <Widget>[
                  YoutubeTrailer(
                      "https://www.youtube.com/watch?v=${youtubeVideos.first.key}"),
                ]
              : <Widget>[]) +
          backdrops
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
    );
  }
}
