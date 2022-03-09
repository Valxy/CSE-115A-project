import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmdb/pages/filter.dart';

import '../models/tmdb_api_wrapper.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({Key? key}) : super(key: key);

  @override
  _BrowseTabState createState() => _BrowseTabState();
}

Map genreList = TmdbApiWrapper.genreDictionary;
List<Genre> genreName =
    genreList.entries.map((e) => Genre(name: e.key, id: e.value)).toList();

class _BrowseTabState extends State<BrowseTab> {
  get title => null;
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  List<IconData> icons = [
    FontAwesomeIcons.running, // Action
    FontAwesomeIcons.mountain, // Action & Adventure
    FontAwesomeIcons.hiking, // Adventure
    FontAwesomeIcons.pencilRuler, // Animation
    FontAwesomeIcons.microphone, // Comedy
    FontAwesomeIcons.skull, // Crime
    FontAwesomeIcons.camera, // Documentary
    FontAwesomeIcons.theaterMasks, // Drama
    FontAwesomeIcons.home, // Family
    FontAwesomeIcons.child, // Kids
    FontAwesomeIcons.dragon, // Fantasy
    FontAwesomeIcons.scroll, // History
    FontAwesomeIcons.ghost, // Horror
    FontAwesomeIcons.music, // Music
    FontAwesomeIcons.userSecret, // Mystery
    FontAwesomeIcons.globe, // News
    FontAwesomeIcons.solidHeart, // Romance
    FontAwesomeIcons.spaceShuttle, // Science Fiction
    FontAwesomeIcons.satellite, // Sci-Fi & Fantasy
    FontAwesomeIcons.userFriends, // Talk
    FontAwesomeIcons.tv, // TV Movie
    FontAwesomeIcons.laugh, // Thriller
    FontAwesomeIcons.fighterJet, // War
    FontAwesomeIcons.fistRaised, // War & Politics
    FontAwesomeIcons.hatCowboy, // Western
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text(""),
        // ),
        body: GridView.builder(
      itemCount: genreName.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10.0,
          childAspectRatio: 3),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilterResults(
                    genre: genreName[index].id,
                    genreName: genreName[index].name,
                  ),
                ));
          },
          child: Container(
              height: 20,
              margin: const EdgeInsets.only(
                  left: 5.0, top: 5.0, bottom: 5.0, right: 5.0),
              width: MediaQuery.of(context).size.width / 2 - 15,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color.fromARGB(255, 97, 153, 218),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    offset: Offset(2, 4), // Shadow position
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 8),
                  SizedBox(
                      width: 40,
                      child: FaIcon(
                        icons[index],
                        size: 40,
                      )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            genreName[index].name,
                            overflow: TextOverflow.ellipsis,

                            /// index
                            //textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ))),
                ],
              )),
        );
      },
    ));
  }
}
