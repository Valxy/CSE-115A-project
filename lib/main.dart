import 'package:flutter/material.dart';

void main() {
  runApp(TMDBApp());
}

class TMDBApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Movie Database',
      theme: ThemeData.light(),
      home: Scaffold(
        bottomNavigationBar: TMDBNavigationBar(),
      ),
    );
  }
}

class TMDBNavigationBar extends StatefulWidget {
  @override
  _TMDBNavigationBarState createState() => _TMDBNavigationBarState();
}

class _TMDBNavigationBarState extends State<TMDBNavigationBar> {
  int _currentPageIndex = 0;

  void _setIndex(int i) {
    setState(() {
      _currentPageIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _currentPageIndex,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      onDestinationSelected: _setIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite),
          label: 'Favorite',
        ),
        NavigationDestination(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
