import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/tmdb_api_wrapper.dart';

class ShowPersonDetails extends StatefulWidget {
  final String personId;

  const ShowPersonDetails({Key? key, required this.personId}) : super(key: key);

  @override
  _ShowPersonDetailsState createState() => _ShowPersonDetailsState();
}

class _ShowPersonDetailsState extends State<ShowPersonDetails> {
  late Future<Person> personDetails;
  static const _imageBaseUrl = "https://image.tmdb.org/t/p/w500";

  @override
  void initState() {
    super.initState();

    personDetails =
        TmdbApiWrapper().getDetailsPerson(personId: widget.personId);
    print(personDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FutureBuilder(
          future: personDetails,
          builder: (BuildContext ctx, AsyncSnapshot<Person> snapshot) {
            return Text(snapshot.data!.name);
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
                CarouselSlider(
                  options: CarouselOptions(
                    disableCenter: true,
                    viewportFraction: 1,
                  ),
                  items: snapshot.data?.profiles
                      .map(
                        (e) => Container(
                          width: 384.0,
                          child: FittedBox(
                            child: e,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                      .toList(),
                ),

                //title, genre, description
                Card(
                  child: Container(
                    height: 300,
                    padding: const EdgeInsets.all(0),
                    child: Row(children: [
                      snapshot.data!.profilePicture,
                      const Spacer(
                        flex: 1,
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
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
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
                              Wrap(
                                spacing: 18,
                                children: [
                                  Text(
                                    snapshot.data!.birthday,
                                  ),
                                  Text(
                                    snapshot.data!.birthPlace,
                                  ),
                                  Text(
                                    snapshot.data!.deathday,
                                  )
                                ],
                              ),
                              const Text(
                                "",
                              ),
                              Text(
                                snapshot.data!.biography,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ]),
                  ),
                ),

                //bottom scroll list for actors
                /*
                Card(
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data!.cast
                          .map(
                            (e) => Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: e.profilePath != null
                                      ? CircleAvatar(
                                          radius: 50.0,
                                          foregroundImage: NetworkImage(
                                              "https://image.tmdb.org/t/p/w500" +
                                                  e.profilePath),
                                        )
                                      : CircleAvatar(
                                          radius: 50.0,
                                          child: Text(e.name.split(" ")[0][0]),
                                        ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Center(
                                    child: Text(
                                      e.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),*/
              ],
            ),
          );
        },
      ),
    );
  }
}
