import 'dart:math';

import 'package:flutter/material.dart';

import '../models/src/api_objects.dart';

class GenreChips extends StatelessWidget {
  final List<Genre> genres;

  const GenreChips({Key? key, required this.genres}) : super(key: key);

  @override
  build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 4,
        children: genres
            .sublist(
              0,
              min(genres.length, 3),
            )
            .map(
              (e) => SizedBox(
                child: ActionChip(
                  onPressed: () {
                    // TODO: Filter page
                  },
                  label: Text(
                    e.name,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  visualDensity:
                      const VisualDensity(horizontal: -4.0, vertical: -4.0),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
