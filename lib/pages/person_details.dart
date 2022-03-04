import 'package:flutter/material.dart';

import '../models/tmdb_api_wrapper.dart';

class PersonDetails extends StatefulWidget {
  final String personId;

  const PersonDetails({Key? key, required this.personId}) : super(key: key);

  @override
  _PersonDetailsState createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails> {
  late Future<Person> personDetails;

  @override
  void initState() {
    super.initState();

    personDetails =
        TmdbApiWrapper().getDetailsPerson(personId: widget.personId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FutureBuilder(
          future: personDetails,
          builder: (BuildContext ctx, AsyncSnapshot<Person> snapshot) {
            return Text(snapshot.data?.name ?? "");
          },
        ),
      ),
      body: FutureBuilder(
        future: personDetails,
        builder: (BuildContext ctx, AsyncSnapshot<Person> snapshot) {
          //return the progress indicator if data hasn't loaded.
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                ],
              ),
            );
          }

          //build the page
          return SingleChildScrollView(
            child: Column(
              children: [
                //backdrop carousel
                // CarouselSlider(
                //   options: CarouselOptions(
                //     disableCenter: true,
                //     viewportFraction: 1,
                //   ),
                //   items: snapshot.data?.profiles
                //       .map(
                //         (e) => SizedBox(
                //           width: 384.0,
                //           child: FittedBox(
                //             child: e,
                //             fit: BoxFit.fill,
                //           ),
                //         ),
                //       )
                //       .toList(),
                // ),

                //title, genre, description
                Card(
                  child: Container(
                    height: 300,
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      children: [
                        snapshot.data!.profilePicture,
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 26,
                          child: Container(
                            padding: const EdgeInsets.only(top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  snapshot.data?.name ?? "",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),

                                // where the genres are in details page
                                // should add something like
                                // "actor, director, writer"
                                // Not currently available
                                /*
                              Wrap(
                                spacing: 4,
                                children: snapshot.data!.creditId
                                    .map((e) => Chip(label: Text(e.name)))
                                    .toList()
                                    .sublist(0, 3),
                              ),*/
                                const SizedBox(
                                  height: 5,
                                ),
                                Wrap(
                                  spacing: 18,
                                  children: [
                                    Text(
                                      snapshot.data!.birthday,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    Text(
                                      snapshot.data!.birthPlace,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    Text(
                                      snapshot.data!.deathday,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  snapshot.data!.biography,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 11,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
