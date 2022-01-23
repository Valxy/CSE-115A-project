import 'package:flutter/material.dart';

import 'tabs/explore.dart';
import 'tabs/search.dart';

void main() {
  runApp(TMDBApp());
}

const List<Widget> _pages = <Widget>[
  ExploreTab(),
  SearchTab(),
  Center(
    child: Text(
      'TBD: BrowseTab',
    ),
  ),
];

class TMDBApp extends StatefulWidget {
  @override
  _TMDBAppState createState() => _TMDBAppState();
}

class _TMDBAppState extends State<TMDBApp> {
  int _currentPageIndex = 0;

  void _setIndex(int i) {
    setState(() {
      _currentPageIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Movie Database',
      theme: ThemeData.light(),
      home: Scaffold(
        body: _pages.elementAt(_currentPageIndex),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentPageIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: _setIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.view_list),
              label: 'Browse',
            ),
          ],
        ),
      ),
    );
  }
}
