import 'package:flutter/material.dart';

// Define a custom Form widget.
class TextInput extends StatefulWidget {
  late List<String> someList;

  TextInput(List<String> someList, {Key? key}) : super(key: key) {
    this.someList = someList;
  }

  @override
  _TextInputState createState() => _TextInputState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _TextInputState extends State<TextInput> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 400,
          height: 50,
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 0),
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
              for (int i = 0; i < widget.someList.length; i++) {
                widget.someList[i] += "a";
                //print(widget.someList);
              }
              print(myController.text);
              print(widget.someList);
            },
            child: const Text('Search'),
          ),
        ),
      ],
    );
  }
}
