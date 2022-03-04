import 'package:flutter/material.dart';
import 'package:filter_list/filter_list.dart';

class FilterResults extends StatefulWidget {
  const FilterResults({Key? key}) : super(key: key);
  @override
  _FilterResultsState createState() => _FilterResultsState();
}

final List<String> movieTitle = <String>['1', '2', '3'];

class _FilterResultsState extends State<FilterResults> {
  void openFilterDialog() async {
    await FilterListDialog.display<GenreFilter>(
      context,
      listData: genreList,
      selectedListData: selectedList,
      choiceChipLabel: (filter) => filter!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedList = List.from(list!);
        });
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Center(
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      height: MediaQuery.of(context).size.height / 4 + 15,
                      child: const Text("test1"),
                      color: Colors.green[100],
                    ),
                    Container(
                      margin: const EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      height: MediaQuery.of(context).size.height / 4 + 15,
                      child: const Text("test2"),
                      color: Colors.green[100],
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: movieTitle.length)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          openFilterDialog();
        },
        label: const Text(''),
        icon: const Icon(Icons.filter_list),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

class GenreFilter {
  final String? name;
  GenreFilter(this.name);
}

List<GenreFilter>? selectedList = [];
final List<GenreFilter> genreList = [
  GenreFilter("70s"),
  GenreFilter("80s"),
  GenreFilter("90s"),
  GenreFilter("1"),
  GenreFilter("2"),
  GenreFilter("3"),
];
