import 'package:flutter/material.dart';

class SearchName extends StatefulWidget {
  final String name;
  const SearchName({required Key key, required this.name}) : super(key: key);

  @override
  _SearchNameState createState() => _SearchNameState();
}

class _SearchNameState extends State<SearchName> {
  @override
  Widget build(BuildContext context) {
    if (widget.name == "hello world") {
      return Container(
        child: SliverList(
          // Use a delegate to build items as they're scrolled on screen.
          delegate: SliverChildBuilderDelegate(
            // The builder function returns a ListTile with a title that
            // displays the index of the current item.
            (context, index) => ListTile(title: Text('Item #$index')),
            // Builds 1000 ListTiles
            childCount: 1000,
          ),
        ),
      );
    } else {
      return Container(
        child: const Text("no result"),
      );
    }
  }
}
