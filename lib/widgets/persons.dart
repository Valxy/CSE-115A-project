import 'package:flutter/material.dart';

import '../models/src/api_objects.dart';
import '../pages/person_details.dart';

class Persons extends StatelessWidget {
  final String title;
  final List<Person> persons;

  const Persons({Key? key, required this.title, required this.persons})
      : super(key: key);

  @override
  build(BuildContext context) {
    return persons.isNotEmpty
        ? Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 6),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Container(
                  height: 135,
                  padding: const EdgeInsets.all(0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: persons
                        .where((cast) => cast.profilePath != "")
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      PersonDetails(personId: "${e.id}"),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CircleAvatar(
                                    radius: 45.0,
                                    foregroundImage: NetworkImage(
                                        "https://image.tmdb.org/t/p/w500" +
                                            e.profilePath),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Center(
                                    child: Text(
                                      e.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                )
                              ],
                            ),
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
