import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'NavDrawer.dart';
import 'AddGiftPage.dart';
import 'package:gift_tracker/models/Gift.dart';
import 'auth.dart';
import 'models/Gift.dart';
import 'package:intl/intl.dart';

enum sortFilter {
  grid,
  tile,
}


class GiftListPage extends StatefulWidget
{
  final BaseAuth auth;

  GiftListPage({Key key, this.auth}) : super(key: key);

  @override
  _GiftListPage createState() => _GiftListPage();
}

class _GiftListPage extends State<GiftListPage> {
  String userID = "";
  List<Gift> giftList = List<Gift>();
  sortFilter filter = sortFilter.tile;
  final Firestore firebaseDB = Firestore.instance;

  // controllers and focus nodes

  final giftNameController = new TextEditingController();
  final giftDescriptionController = new TextEditingController();
  final giftLinkController = new TextEditingController();
  final giftPriceController = new TextEditingController();
  final giftPriorityController = new TextEditingController();

  final FocusNode giftNameFocus = FocusNode();
  final FocusNode giftDescriptionFocus = FocusNode();
  final FocusNode giftLinkFocus = FocusNode();
  final FocusNode giftDateAddedFocus = FocusNode();
  final FocusNode giftPriorityFocus = FocusNode();
  final FocusNode giftPriceFocus = FocusNode();


  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        userID = user.uid;
      });
      if (userID == "") print("ERROR: USERID IS NULL");
    });
  }


  buildStream(){
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
        onTap: () => showUpdateDialog(giftList[index], index),
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
  updateGift(giftList, index) async
  {
    Gift newGift = new Gift();

    giftNameController.text.isEmpty ?
    newGift.giftName = giftList.giftName : newGift.giftName = giftNameController.text;

    giftDescriptionController.text.isEmpty ?
    newGift.giftDescription = giftList.giftDescription : newGift.giftDescription = giftDescriptionController.text;

    giftLinkController.text.isEmpty ?
    newGift.giftLink = giftList.giftLink : newGift.giftLink = giftLinkController.text;

    newGift.giftDateAdded = giftList.giftDateAdded;

    giftPriceController.text.isEmpty ?
    newGift.giftPrice = giftList.giftPrice : newGift.giftPrice = double.parse(giftPriceController.text);

    giftPriorityController.text.isEmpty ?
    newGift.giftPriority = giftList.giftPriority : newGift.giftPriority= double.parse(giftPriorityController.text);

    var foundDocID;
    var doc;
    firebaseDB.collection(userID).document("gifts").collection("gifts").snapshots().listen((snapshot) async
    {
      foundDocID = snapshot.documents.elementAt(index).documentID.toString();

      doc = firebaseDB.collection(userID).document("gifts").collection("gifts").document(foundDocID);

    });
    try {
      firebaseDB.runTransaction((transaction) async {
        await transaction.update(
            doc, newGift.toMap());
      });
    }
    catch(e){
      print("error here");
      print(e);
  }

    giftLinkController.clear();
    giftPriorityController.clear();
    giftNameController.clear();
    giftPriceController.clear();
    giftDescriptionController.clear();

    Navigator.pop(context);
  }

  deleteGift(giftList, index)
  {
    var foundDocID;
    var doc;
    firebaseDB.collection(userID).document("gifts").collection("gifts").snapshots().listen((snapshot) async
    {
      foundDocID = snapshot.documents.elementAt(index).documentID.toString();

      doc = firebaseDB.collection(userID).document("gifts").collection("gifts").document(foundDocID);

    });

    firebaseDB.runTransaction((transaction) async {
      await transaction.delete(doc);
    });

    Navigator.pop(context);
  }

  showUpdateDialog(giftList, index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update Gift"),
            content: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Gift Name", style: TextStyle(fontSize: 20.0)),
                    SizedBox(width: 10),
                    Flexible( // flexible means the text field can take up the rest of the window
                        child: TextFormField(
                          controller: giftNameController,
                          textInputAction: TextInputAction.next,
                          focusNode: giftNameFocus,
                          onFieldSubmitted: (term) {
                            FocusScope.of(context).requestFocus(
                                giftDescriptionFocus);
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5.0),
                          ),
                        )
                    ),
                  ],
                ),

                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    SizedBox(width: 7),
                    Text("Description", style: TextStyle(fontSize: 20.0)),
                    SizedBox(width: 10),
                    Flexible(
                        child: TextFormField(
                          controller: giftDescriptionController,
                          textInputAction: TextInputAction.next,
                          focusNode: giftDescriptionFocus,
                          onFieldSubmitted: (term) {
                            FocusScope.of(context).requestFocus(
                                giftPriorityFocus);
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5.0),
                          ),
                        )
                    ),
                    SizedBox(width: 10)
                  ],
                ),

                SizedBox(height: 15),
                Row( //TODO slider doesn't work
                  children: <Widget>[
                    SizedBox(width: 7),
                    Text("Priority (1 - 10)", style: TextStyle(fontSize: 20.0)),
                    SizedBox(width: 10),
                    Flexible(
                        child: TextFormField(
                          controller: giftPriorityController,
                          textInputAction: TextInputAction.next,
                          focusNode: giftPriorityFocus,
                          onFieldSubmitted: (term) {
                            FocusScope.of(context).requestFocus(giftPriceFocus);
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5.0),
                          ),
                        )
                    ),
                    SizedBox(width: 10),
                  ],
                ),

                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    SizedBox(width: 7),
                    Text("Price", style: TextStyle(fontSize: 20.0)),
                    SizedBox(width: 10),
                    Flexible(
                        child: TextFormField(
                          controller: giftPriceController,
                          focusNode: giftPriceFocus,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (term) {
                            FocusScope.of(context).requestFocus(giftLinkFocus);
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5.0),
                              hintText: 'In Dollars, no \'\$\''
                          ),
                        )
                    ),
                    SizedBox(width: 10)
                  ],
                ),

                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    SizedBox(width: 7),
                    Text("Link", style: TextStyle(fontSize: 20.0)),
                    SizedBox(width: 10),
                    Flexible(
                        child: TextFormField(
                          controller: giftLinkController,
                          textInputAction: TextInputAction.done,
                          focusNode: giftLinkFocus,
                          maxLines: null,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5.0),
                          ),
                        )
                    ),
                    SizedBox(width: 10)
                  ],
                ),

              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  SizedBox(width: 10),
                  RaisedButton(
                    child: Text(
                        "Delete Gift",
                        style: TextStyle(color: Colors.black)
                    ),
                    onPressed: () => deleteGift(giftList, index)
                  ),
                  SizedBox(width: 10),

                  SizedBox(width: 10),

                  RaisedButton(
                      child: Text(
                          "Update gift",
                          style: TextStyle(color: Colors.black)
                      ),
                      onPressed: () => updateGift(giftList, index)
                  ),
                  SizedBox(width: 10),

                  SizedBox(width: 10),
                  RaisedButton(
                    child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black)
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: 25),

                ],
              )
            ],
          );
        }
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
