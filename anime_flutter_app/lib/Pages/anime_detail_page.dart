import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AnimeDetailPage extends StatefulWidget {
  const AnimeDetailPage({Key key, this.name, this.id}) : super(key: key);
  final String name;
  final String id;

  @override
  _AnimeDetailPageState createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          bottom: TabBar(
            isScrollable: false,
            tabs: choices.map((Choice choice) {
              return Tab(
                icon: Icon(choice.icon),
                text: choice.title,
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              child: StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance
                      .collection('anime')
                      .document(widget.id)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error ${snapshot.error}');
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Dialog(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        return ListView(
                          children: <Widget>[
                            StreamBuilder<DocumentSnapshot>(
                                stream: Firestore.instance
                                    .collection('anime')
                                    .document(widget.id)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error ${snapshot.error}');
                                  }
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return Dialog(
                                        child: CircularProgressIndicator(),
                                      );
                                    default:
                                      return Text("LOL");
                                  }
                                }),
                          ],
                        );
                    }
                  }),
            ),
            Container(
              child: StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance
                      .collection('anime')
                      .document(widget.id)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error ${snapshot.error}');
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Dialog(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        return Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(snapshot.data['description'],
                              style: TextStyle(fontSize: 12)),
                        );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Episodes', icon: Icons.list),
  const Choice(title: 'Résumé', icon: Icons.description),
];
