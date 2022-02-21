import 'package:flutter/material.dart';

final List<String> movieTitle = <String>['1', '2', '3'];

class FilterResults extends StatelessWidget {
  const FilterResults({Key? key}) : super(key: key);

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
    );
  }
}
