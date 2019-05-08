import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'GiftList.dart';
import 'package:gift_tracker/models/Gift.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';


class AddGiftPage extends StatefulWidget
{
  final GiftList giftClass;
  final List<Gift> giftList;

  final BaseAuth auth;

  AddGiftPage({Key key, this.giftClass, this.giftList, this.auth}) : super(key: key);

  @override
  _AddGiftPage createState() => _AddGiftPage();
}

final Firestore firebaseDB = Firestore.instance;

class _AddGiftPage extends State<AddGiftPage>
{
  String userID = "";

  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {

      setState(() {
        userID = user.uid;

      });
      if(userID == "")
        print("ERROR: USERID IS NULL");
    });
  }

  // -- Variables -- //

  final giftNameController = new TextEditingController();
  final giftDescriptionController = new TextEditingController();
  final giftLinkController = new TextEditingController();
  //final giftPriorityController = new TextEditingController();
  final giftPriceController = new TextEditingController();
  double giftPriority = 10.0;

  final FocusNode giftNameFocus = FocusNode();
  final FocusNode giftDescriptionFocus = FocusNode();
  final FocusNode giftLinkFocus = FocusNode();
  final FocusNode giftDateAddedFocus = FocusNode();
  final FocusNode giftPriorityFocus = FocusNode();
  final FocusNode giftPriceFocus = FocusNode();

  // -- Functions -- //

  addGift()
  {
    Gift newGift = new Gift();

    giftNameController.text.isEmpty ?
      newGift.giftName = "No name given" : newGift.giftName = giftNameController.text;

    giftDescriptionController.text.isEmpty ?
      newGift.giftDescription = "No description given" : newGift.giftDescription = giftDescriptionController.text;

    giftLinkController.text.isEmpty ?
      newGift.giftLink = "No link given" : newGift.giftLink = giftLinkController.text;

    var now = new DateTime.now();
    var formatter = new DateFormat('MMMM d y');
    String formatted = formatter.format(now);
    newGift.giftDateAdded = formatted;

    giftPriceController.text.isEmpty ?
      newGift.giftPrice = -10.0 : newGift.giftPrice = double.parse(giftPriceController.text);

    newGift.giftPriority = giftPriority;


    //newGift.giftLink = giftLinkController.text;
    //newGift.giftDateAdded = giftDateAddedController.text;
    //newGift.giftPriority = int.parse(giftPriorityController.text);
    //newGift.giftPriority = giftPriority;
    //newGift.giftPrice = double.parse(giftPriceController.text);

    //FirebaseUser user = await FirebaseAuth.instance.currentUser();
    //String userID = user.uid;

    // yeah, this is dumb but it works
    var doc = firebaseDB.collection(userID).document("gifts").collection("gifts").document();

    firebaseDB.runTransaction((transaction) async {
      await transaction.set(
          doc, newGift.toMap());
    });

    Navigator.pop(context);
  }

  _sliderChange(prio)
  {
    setState(() => giftPriority = prio);
  }

  sliderValue() { return giftPriority; }


  // -- Main Widget Builder --//

  @override
  Widget build(BuildContext context) {
    // forces portrait usage of this page/widget
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Gift")
      ),

      // TODO it might be nice to eventually make this page look nicer,
      // TODO   having the text form fields line up with each other would be good
      body: Column(
        children: <Widget>[
          SizedBox(height: 15),
          Row(
            children: <Widget>[
              SizedBox(width: 7),
              Text("Gift Name", style: TextStyle(fontSize: 20.0)),
              SizedBox(width: 10),
              Flexible( // flexible means the text field can take up the rest of the window
                child: TextFormField(
                  controller: giftNameController,
                  textInputAction: TextInputAction.next,
                  focusNode: giftNameFocus,
                  onFieldSubmitted: (term){
                    FocusScope.of(context).requestFocus(giftDescriptionFocus);
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
                    onFieldSubmitted: (term){
                      FocusScope.of(context).requestFocus(giftPriorityFocus);
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
          Row( //TODO later make this a dropdown or slider or something better
            children: <Widget>[
              SizedBox(width: 7),
              Text("Priority", style: TextStyle(fontSize: 20.0)),
              SizedBox(width: 10),
              Flexible(
                child: Slider(
                  activeColor: Colors.purple,
                  inactiveColor: Colors.black12,
                  min: 0.0,
                  max: 10.0,
                  onChanged: _sliderChange,
                  value: sliderValue()

                )
              ),
              SizedBox(width: 10),
              Container(
                width: 50.0,
                alignment: Alignment.center,
                child: Text('${giftPriority.toInt()}')
              ),
              SizedBox(width: 10)
            ],
          ),

          //TODO this needs to have some kind of validation and a $ sign needs
          //TODO   to be appended
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
                    onFieldSubmitted: (term){
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

//          SizedBox(height: 15),
//          Row( //TODO later make this automatically fill with the current date
//            children: <Widget>[
//              SizedBox(width: 7),
//              Text("Date Added", style: TextStyle(fontSize: 20.0)),
//              SizedBox(width: 10),
//              Flexible(
//                  child: TextFormField(
//                    controller: giftDateAddedController,
//                    textInputAction: TextInputAction.next,
//                    keyboardType: TextInputType.datetime,
//                    focusNode: giftDateAddedFocus,
//                    onFieldSubmitted: (term){
//                      FocusScope.of(context).requestFocus(giftLinkFocus);
//                    },
//                    decoration: InputDecoration(
//                      contentPadding: EdgeInsets.all(5.0),
//                    ),
//                  )
//              ),
//              SizedBox(width: 10)
//            ],
//          ),

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

      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text("Cancel"),
              color: Theme.of(context).accentColor,
              onPressed: () => {
                Navigator.pop(context)
              }
            ),
            RaisedButton(
                child: Text("Add Gift"),
                color: Theme.of(context).accentColor,
                onPressed: () => addGift()
            )
          ],
        ),
      ),

    );
  }
}

