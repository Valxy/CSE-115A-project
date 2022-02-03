import 'package:flutter/material.dart';

// Define a custom Form widget.
class TextInput extends StatefulWidget {
  TextInput({Key? key}) : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _TextInputState extends State<TextInput> {
  List<String> queryResult = [];

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

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
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 400,
                      height: 50,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 50, bottom: 0),
                      // color: const Color.fromARGB(255, 23, 163, 218),
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.transparent,
                      ),
                      child: TextField(
                        controller: myController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'search movies and tv shows',
                        ),
                      ),
                    ),
                    Container(
                      //margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
                      width: 60,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.red,
                          onSurface: Colors.red,
                        ),
                        onPressed: () {
                          for (int i = 0; i < 30; i++) {
                            setState(() {
                              queryResult.add("${myController.text} $i");
                            });
                          }
                        },
                        child: const Text('Search'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(title: Text(queryResult[index])),
                childCount: queryResult.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
