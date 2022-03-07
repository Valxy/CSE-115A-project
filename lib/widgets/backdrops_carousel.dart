import 'dart:math';

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
    List<Video>? youtubeTrailers = videos
        ?.where((video) => video.site == "YouTube" && video.type == "Trailer")
        .toList();

    bool hasTrailer = youtubeTrailers != null && youtubeTrailers.isNotEmpty;

    return CarouselSlider.builder(
      options: CarouselOptions(
        disableCenter: true,
        viewportFraction: 1,
      ),
      itemCount: backdrops.length + (hasTrailer ? 1 : 0),
      itemBuilder: (BuildContext ctx, int i, int p) {
        int off = 0;

        if (hasTrailer) {
          if (i == 0) {
            return YoutubeTrailer(
                youtubeTrailers[Random().nextInt(youtubeTrailers.length)].key);
          }
          off = 1;
        }

        return SizedBox(
          width: 384.0,
          child: FittedBox(
            child: backdrops[i - off],
            fit: BoxFit.fill,
          ),
        );
      },
    );
  }
}
