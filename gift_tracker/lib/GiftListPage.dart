import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'NavDrawer.dart';
import 'AddGiftPage.dart';
import 'GiftList.dart';
import 'package:gift_tracker/models/Gift.dart';
import 'auth.dart';
import 'models/Gift.dart';

enum sortFilter {
  grid,
  tile,
}

class GiftListPage extends StatefulWidget {
  final GiftList giftClass;
  final List<Gift> giftList;

  final BaseAuth auth;

  GiftListPage({Key key, this.giftClass, this.giftList, this.auth})
      : super(key: key);

  @override
  _GiftListPage createState() => _GiftListPage();
}

class _GiftListPage extends State<GiftListPage> {
  String userID = "";
  List<Gift> giftList = List<Gift>();
  sortFilter filter = sortFilter.tile;
  final Firestore firebaseDB = Firestore.instance;

  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        userID = user.uid;
      });
      if (userID == "") print("ERROR: USERID IS NULL");
    });
  }

  buildStream() {
    return StreamBuilder(
        stream: firebaseDB
            .collection(userID)
            .document("gifts")
            .collection("gifts")
            .snapshots(),
        builder: (context, snapshot) {
          getGifts(snapshot);
          if (filter == sortFilter.tile) {
            print("building tiles");
            return ListView.builder(
              itemCount: giftList.length,
              itemBuilder: (context, index) {
                return buildCards(index);
              },
            );
          } else {
            print("building Grid");
            return buildGrid();
          }
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
      child: ListTile(
        leading: GestureDetector(
          child: Text("\$ ${giftList[index].giftPrice}"),
          onTap: () => print('price tapped'),
        ),
        title: Text(giftList[index].giftName),
        trailing: GestureDetector(
          child: Text("${(giftList[index].giftPriority).round()}"),
          onTap: () => print("priority tapped"),
        ),
        onTap: () => print("${giftList[index].giftName}"),
      ),
    );
  }

  buildCardsGrid(index) {
    return Card(
        elevation: 2.0,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    giftList[index].giftName,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  ),
              Container(
                //padding: EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "\$${giftList[index].giftPrice}",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      "${giftList[index].giftPriority}",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                )
              )
            ]));
  }

  buildGrid() {
    return GridView.builder(
      itemCount: giftList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return buildCardsGrid(index);
      },
    );
  }
  // -- Main Widget Builder --//

  @override
  Widget build(BuildContext context) {
    // forces portrait usage of this page/widget
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new AddGiftPage(
                              giftClass: widget.giftClass,
                              giftList: widget.giftList,
                              auth: widget.auth)))
                }),

        //backgroundColor: Color.fromRGBO(227, 223, 236, 1.0), //TODO add a nice background color

        appBar: AppBar(
            title: Text(
                "Gift List"), //TODO this should later be the name of the list
            actions: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.format_list_bulleted, size: 30.0),
                    onPressed: () => setState(() {
                          filter = sortFilter.tile;
                        }),
                  ),
                  IconButton(
                    icon: Icon(Icons.apps, size: 29.0),
                    onPressed: () => setState(() {
                          filter = sortFilter.grid;
                        }),
                  ),
                  SizedBox(width: 10.0)
                ],
              )
            ]),
        drawer: NavDrawer(),
        body: Container(
          child: buildStream(),
        ));
  }
}
