import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'anime_detail_page.dart';

class Home extends StatelessWidget {
  const Home({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home ${user.email}'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('anime').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Dialog(
              child: CircularProgressIndicator(),
            );
            default:
              return new GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(10.0),
                  children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                      return Container(
                        width: 200.0,
                        height: 250.0,
                        child: InkWell(
                          onTap: () {
                            navigateToDetailProduct(context, document.documentID, document['name']);
                          },
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                Image.network(document['url'] != null ? document['url'] : '',
                                  width: double.infinity,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      children: <Widget>[
                                        Text(document['name'],
                                          maxLines: 2,
                                          style: Theme.of(context).primaryTextTheme.subhead.copyWith(
                                              color: Colors.blue,
                                              fontSize: 12
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      );
                    }).toList()
              );
          }
        },
      ),
    );
  }

  void navigateToDetailProduct(BuildContext context, String id, String name) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AnimeDetailPage(name: name, id: id)));
  }
}

