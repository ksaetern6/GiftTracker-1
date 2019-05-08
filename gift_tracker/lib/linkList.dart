import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/Gift.dart';

class linkPage extends StatefulWidget {
  linkPage({this.userID});

  final String userID;

  @override
  _linkPageState createState() => _linkPageState();
}

class _linkPageState extends State<linkPage> {

  final Firestore firebaseDB = Firestore.instance;
  List<Gift> giftList = List<Gift>();
  buildStream(){
    return StreamBuilder(
        stream: firebaseDB
            .collection(widget.userID)
            .document("gifts")
            .collection("gifts")
            .snapshots(),
        builder: (context, snapshot) {
          getGifts(snapshot);
          return ListView.builder(
              itemCount: giftList.length,
              itemBuilder: (context, index) {
            return buildCards(index);
          });

        });
  }
  getGifts(AsyncSnapshot<QuerySnapshot> snap) {
    if (snap.data == null) {
      return;
    } else {
      Gift gift = Gift();
      giftList = snap.data.documents
          .map((doc) => (gift = Gift.set(
          doc['name'],
          doc['description'],
          doc['priority'],
          doc['price'],
          doc['dateAdded'],
          doc['link'],
          doc['bought'])))
          .toList();
    } //else
    print(giftList);
  }

  buildCards(int index) {

    return Card(
      elevation: 2.0,
      color: Colors.deepPurple[50],
      margin: EdgeInsets.fromLTRB(13, 5, 13, 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      child: ListTile(
        contentPadding: EdgeInsets.only(left: 10.0, top: 10.0, right: 20.0, bottom: 10.0),
        title: Text(
            giftList[index].giftName,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
        ),
        trailing: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                  "\$ ${(giftList[index].giftPrice).round()}",
                  style: TextStyle(fontSize: 20)
              ),
              SizedBox(height: 10),
              Text(
                  "${(giftList[index].giftPriority).round()}",
                  style: TextStyle(fontSize: 20)
              ),
            ],
          ),//Text("Priority: ${(giftList[index].giftPriority).round()}", style: TextStyle(fontSize: 20),),
          onTap: () => print("priority tapped"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
      ),
      body: Container(
        child: buildStream(),

      ),
    );
  }
}