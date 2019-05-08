import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'NavDrawer.dart';
import 'AddGiftPage.dart';
import 'package:gift_tracker/models/Gift.dart';
import 'auth.dart';
import 'models/Gift.dart';
import 'linkList.dart';
import 'models/LinkList.dart';

class joinListPage extends StatefulWidget {
  @override
  _joinListPage createState() => _joinListPage();
}

class _joinListPage extends State<joinListPage> {

  final linkController = TextEditingController();
  final linkNameController = TextEditingController();

  List<LinkList> linkList = List<LinkList>();
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

    LinkList tempList = LinkList();

    if (snap.data == null) {
      return;
    } else {
      linkList = snap.data.documents.map((doc) => (tempList = LinkList.set(
        doc['name'], doc['link']
      ))).toList();


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
      shape: CircleBorder(),
      child: ListTile(
        //title: Center(child: Text('$index', style: TextStyle(fontSize: 25.0),)),
        title: Center(child: Text('${linkList[index].linkName}', style: TextStyle(fontSize: 25.0),)),
        onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (context) => linkPage(userID: linkList[index].linkLink))),
      )
    );
   }
  addLink() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 200,
              child:
            Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name of list',
                    icon: Icon(Icons.create),
                  ),
                  validator: (value) => value.isEmpty ? 'Cannot be empty' : null,
                  controller: linkNameController,
                ),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Paste Link Here!',
                    icon: Icon(Icons.content_paste),
                  ),
                  validator: (value) => value.isEmpty ? 'Cannot be empty' : null,
                  controller: linkController,
                ),
              ],
            ),
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
    myMap['name'] = linkNameController.text;
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
