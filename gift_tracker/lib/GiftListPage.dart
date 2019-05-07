import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'NavDrawer.dart';
import 'AddGiftPage.dart';
import 'GiftList.dart';
import 'Gift.dart';
import 'auth.dart';

class GiftListPage extends StatefulWidget
{
  final GiftList giftClass;
  final List<Gift> giftList;

  final BaseAuth auth;

  GiftListPage({Key key, this.giftClass, this.giftList, this.auth}) : super(key: key);

  @override
  _GiftListPage createState() => _GiftListPage();
}

class _GiftListPage extends State<GiftListPage>
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

  _buildGiftsList(index)
  {
//    if(widget.giftClass.isListEmpty(widget.giftList))
//      return new Center( //TODO make this something better looking
//          child: Text("Your list is empty! \n"
//                      "Add some gifts and they will be displayed here!",
//                 style: TextStyle(
//                    fontSize: 30.0,
//                    fontWeight: FontWeight.bold)
//          )
//      );
//    else
      return new GestureDetector(
          onTap: ()
          {
            // TODO when the gift is tapped the giftee should be able to update the gift parameters

            // TODO later on, ONLY the giftee should be able to tap the gift
            // TODO  and make updates it
            print("gift tapped");
          },
          child: Card(
            color: Colors.yellow,
            elevation: 3,
            margin: EdgeInsets.all(8),
            child:Container(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                      //widget.giftClass.getName(widget.giftList, index),
                                    "temp",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                      //"\$${(widget.giftClass.getPrice(widget.giftList, index)).toString()}",
                                    "temp",
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          fontStyle: FontStyle.italic
                                      )
                                  ),

                                  Text(
                                      //widget.giftClass.getPriority(widget.giftList, index).toString(),
                                    "temp",
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          fontStyle: FontStyle.italic
                                      )
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                  )
                ],
              )
            )
          )
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
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => new AddGiftPage(
                giftClass: widget.giftClass, giftList: widget.giftList, auth: widget.auth
            )))
        }
      ),

      //backgroundColor: Color.fromRGBO(227, 223, 236, 1.0), //TODO add a nice background color

      appBar: AppBar(
        title: Text("Gift List"), //TODO this should later be the name of the list
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.format_list_bulleted, size: 30.0),
                onPressed: () => {
                  print("bullet list called")
                },
              ),

              IconButton(
                icon: Icon(Icons.apps, size: 29.0),
                onPressed: () => {
                  print("tiles list called")
                },
              ),

              SizedBox(width: 10.0)

            ],
          )
        ]
      ),

      drawer: NavDrawer(),

      body: Container(
//        child: ListView.builder(
//          itemCount: widget.giftClass.getLengthOfList(widget.giftList),
//          itemBuilder: (BuildContext context, int index) => _buildGiftsList(index)
//        )
      )
    );
  }
}

