import 'package:flutter/material.dart';
import '../pages/details.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({Key? key}) : super(key: key);

  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final ScrollController _scrollController = ScrollController();

  final List<String> movie_Titles = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          itemCount: 8,
          itemBuilder: (_, i) {
          if (i % 2 != 1)
            return _buildText();
          else
            return _horizontalListView();
        },
      )
    );
  }

  Widget _horizontalListView() {
    return SizedBox(
      height: 250,
      child: Scrollbar(
        //isAlwaysShown: true,
        //controller: _scrollController,
        child: ListView.builder(
          //controller: _scrollController,
          itemCount: movie_Titles.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) => _buildBox(),
        ),
      ),
    );
  }

  Widget _buildBox() => Container(
    margin: EdgeInsets.all(12),
    height: 250,
    width: 200,
    child: OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                ShowDetails(showId: "634649"),
            fullscreenDialog: true,
          ),
        );
      },
      // ignore: unnecessary_new
      child: new Column(
        children: <Widget> [
          Container(
            margin: EdgeInsets.only(left: 0.0,top: 10.0, bottom: 10.0, right:0.0),
            child: Text('Image goes here'),
          ),
          Container(
            margin: EdgeInsets.only(left: 0.0,top: 10.0, bottom: 10.0, right:0.0),
            child: Text('Entry ${movie_Titles[1]}', 
              style: new TextStyle( color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold, fontSize: 20.0)
            )
          ),
          Container(
            margin: EdgeInsets.only(left: 0.0,top: 5.0, bottom: 5.0, right:0.0),
            child: Text('This movie is about something which is very interesting.',
              style: new TextStyle( color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold, fontSize: 12.0 )
            )
          ),
        ]
      ),
    ),
  );

  Widget _buildText() => Container(
    margin: EdgeInsets.all(12),
    height: 25,
    width: 200,
    child: Text("Popular Releases", style: TextStyle(fontSize: 20)),
  );
}
