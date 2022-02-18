import 'package:flutter/material.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({Key? key}) : super(key: key);

  @override
  _BrowseTabState createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  get title => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Action & Adventure",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Animation",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Comedy",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Crime",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Documentary",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Drama",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Family",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Kids",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Fantasy",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("History",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Horror",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Music",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Mystery",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("News",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Romance",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Science Fiction",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Talk",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("TV Movie",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Thriller",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("War & Politics",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: Colors.blue,
                  border: Border.all(color: Colors.red, width: 0.3)),
              child: Center(
                child: Text("Western",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
