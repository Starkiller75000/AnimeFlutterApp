import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AnimeDetailPage extends StatefulWidget {
  const AnimeDetailPage({Key key, this.name, this.id}) : super(key: key);
  final String name;
  final String id;

  @override
  _AnimeDetailPageState createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  List<Tab> _list = [
    new Tab(
      icon: const Icon(Icons.list),
      text: 'Episodes',
    ),
    new Tab(
      icon: const Icon(Icons.description),
      text: 'Résumé',
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: new ListView(
          children: <Widget>[
            new Container(
              decoration:
                  new BoxDecoration(color: Theme.of(context).primaryColor),
              child: new TabBar(
                controller: _controller,
                tabs: _list,
              ),
            ),
            new Container(
              height: 80.0,
              child: new TabBarView(
                controller: _controller,
                children: <Widget>[
                  new Container(
                    child: new InkWell(
                      child: new InkWell(
                        onTap: () {},
                        child: new Card(
                          child: new ListTile(
                            leading: const Icon(Icons.home),
                            title: new Text("Episode XX"),
                            subtitle: new Text("Boruto Uzumaki !"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  new StreamBuilder<DocumentSnapshot>(
                    stream: Firestore.instance.collection('anime').document(widget.id).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error ${snapshot.error}');
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting: return Dialog(
                          child: CircularProgressIndicator(),
                        );
                        default: return Text(snapshot.data['description']);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
