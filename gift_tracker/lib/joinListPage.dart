import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'NavDrawer.dart';
import 'AddGiftPage.dart';
import 'package:gift_tracker/models/Gift.dart';
import 'auth.dart';
import 'models/Gift.dart';

class joinListPage extends StatefulWidget {
  @override
  _joinListPage createState() => _joinListPage();
}

class _joinListPage extends State<joinListPage> {
  final linkController = TextEditingController();
  List<dynamic> linkList = List<dynamic>();
  String myUserID = "";
  Auth auth = Auth();

  void initState() {
    super.initState();
    auth.getCurrentUser().then((user) {
      setState(() {
        myUserID = user.uid;
      });
      if (myUserID == "") print("ERROR: USERID IS NULL");
    });
  }

  buildStream() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection(myUserID)
          .document('sharedLists')
          .collection('sharedLists')
          .snapshots(),
      builder: (context, snapshot) {
        getLinks(snapshot);
        return buildLinks();
      },
    );
  }

  getLinks(AsyncSnapshot<QuerySnapshot> snap) {
    if (snap.data == null) {
      return;
    } else {
      linkList = snap.data.documents.map((doc) => doc['link']).toList();
    }
    print(linkList);
  }

  buildLinks() {
    return GridView.builder(
      itemCount: linkList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return buildCards(index);
      },
    );
  }

  buildCards(int index){
    return Card(
      elevation: 2.0,
      child: Text(linkList[index]),
    );
   }
  addLink() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: TextFormField(
              decoration: InputDecoration(
                labelText: 'Paste Link Here!',
                icon: Icon(Icons.content_paste),
              ),
              validator: (value) => value.isEmpty ? 'Cannot be empty' : null,
              controller: linkController,
            ),
            actions: <Widget>[
              RaisedButton(
                child: Text("Add"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () => addLinkDB(),
              )
            ],
          );
        });
    //Navigator.pop(context);
  }

  addLinkDB() {
    var myMap = Map<String, dynamic>();
    myMap['link'] = linkController.text;
    var doc = Firestore.instance
        .collection(myUserID)
        .document('sharedLists')
        .collection('sharedLists')
        .document(linkController.text);
    Firestore.instance.runTransaction((tx) async {
      await tx.set(doc, myMap);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => addLink(),
      ),
      appBar: AppBar(
        title: Text("Your Lists"),
      ),
      drawer: NavDrawer(),
      body: Container(
        child: buildStream(),
      ),
    );
  }
}
