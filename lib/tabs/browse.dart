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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(""),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: genreName
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FilterResults(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    height: 80,
                    width: MediaQuery.of(context).size.width - 15,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.purple, Colors.orange])),
                    child: Center(
                        child: Text(
                      e.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    )),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
