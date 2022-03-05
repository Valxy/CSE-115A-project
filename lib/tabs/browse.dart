import 'package:flutter/material.dart';
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
                  builder: (context) =>
                      FilterResults(genre: genreName[index].id),
                ));
          },
          child: Container(
              height: 20,
              width: MediaQuery.of(context).size.width / 2 - 15,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.blueGrey),
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.favorite,
                    color: Colors.pink,
                    size: 15,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    genreName[index].name,

                    /// index
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              )),
        );
      },
    ));
  }
}