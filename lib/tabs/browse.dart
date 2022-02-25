import 'package:flutter/material.dart';
import 'package:tmdb/pages/filter.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({Key? key}) : super(key: key);

  @override
  _BrowseTabState createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  get title => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            "Action & Adventure",
            "Animation",
            "Comedy",
            "Crime",
            "Documentary",
            "Drama",
            "Family",
            "Kids",
            "Fantasy",
            "History",
            "Horror",
            "Music",
            "Mystery",
            "News",
            "Romance",
            "Science Fiction",
            "Talk",
            "TV Movie",
            "Thriller",
            "War & Politics",
            "Western",
          ]
              .map(
                (e) => Container(
                  margin: const EdgeInsets.all(5.0),
                  height: 100.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      color: Colors.blue,
                      border: Border.all(color: Colors.red, width: 0.3)),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FilterResults(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(e,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                          )),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
