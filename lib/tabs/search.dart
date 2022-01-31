import 'package:flutter/material.dart';
import 'text_input.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  bool freshPage = true;
  List<String> someList = ["f", "e", "d", "c", "b", "a"];

  @override
  Widget build(BuildContext context) {
    const title = 'Floating App Bar';

    return MaterialApp(
      title: title,
      home: Scaffold(
        resizeToAvoidBottomInset:
            false, // prevents the keyboard resizing the search bar
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              // collapsedHeight: 10.0, does not work for some reason...
              floating: true,
              // backgroundColor: Color.fromARGB(0, 20, 130, 219),
              // shadowColor: Colors.transparent,
              // foregroundColor: Color.fromARGB(0, 20, 130, 219),
              expandedHeight: 130,
              // a work around for an overflow issue
              // works by adding an empty box below the search bar
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(60.0),
                child: Text(''),
              ),
              flexibleSpace: Center(
                child: TextInput(someList),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(title: Text(someList[index])),
                childCount: someList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
