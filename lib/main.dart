import 'package:flutter/material.dart';

import 'tabs/browse.dart';
import 'tabs/explore.dart';
import 'tabs/search.dart';

void main() async {
  ///Need this for apps running asynchronous functions
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TMDBApp());
}

const List<List<Widget>> _tabs = [
  [
    NavigationDestination(
      icon: Icon(Icons.explore),
      label: 'Explore',
    ),
    ExploreTab()
  ],
  [
    NavigationDestination(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    SearchTab()
  ],
  [
    NavigationDestination(
      icon: Icon(Icons.view_list),
      label: 'Browse',
    ),
    BrowseTab()
  ],
];

class TMDBApp extends StatefulWidget {
  const TMDBApp({Key? key}) : super(key: key);

  @override
  _TMDBAppState createState() => _TMDBAppState();
}

class _TMDBAppState extends State<TMDBApp> with SingleTickerProviderStateMixin {
  int _currentTabIndex = 0;

  late AnimationController _animationController;
  late Animation _animation;

  void _setIndex(int i) {
    setState(() {
      _currentTabIndex = i;
    });

    _animationController.forward(from: 0.0);
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));

    _animation = Tween<double>(begin: 0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCubic));

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Movie Database',
      theme: ThemeData.light(),
      home: Scaffold(
        body: AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) {
            return Opacity(
              opacity: _animation.value,
              child: _tabs.elementAt(_currentTabIndex)[1],
            );
          },
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentTabIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: _setIndex,
          destinations: List.of(_tabs.map((e) => e.elementAt(0))),
        ),
      ),
    );
  }
}
