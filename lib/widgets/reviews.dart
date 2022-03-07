import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

import '../models/src/api_objects.dart';

class Reviews extends StatelessWidget {
  final List<Review> reviews;

  const Reviews({Key? key, required this.reviews}) : super(key: key);

  @override
  build(BuildContext context) {
    return reviews.isNotEmpty
        ? Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 6),
                  child: Text(
                    "User Reviews",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Container(
                  height: 190,
                  width: double.infinity,
                  margin: const EdgeInsets.all(12),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                    ),
                    items: reviews
                        .map(
                          (e) => SingleChildScrollView(
                            child: Text.rich(TextSpan(children: [
                              TextSpan(
                                text: "@" + e.authorName + "     ",
                                style: Theme.of(context).textTheme.caption,
                              ),
                              TextSpan(
                                text: DateFormat.yMMMd().format(
                                    DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                                        .parse(e.updatedAt)),
                                style: Theme.of(context).textTheme.caption,
                              ),
                              const TextSpan(text: "\n"),
                              const WidgetSpan(
                                child: SizedBox(
                                  height: 28,
                                ),
                              ),
                              TextSpan(
                                text: e.content,
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            ])),
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
