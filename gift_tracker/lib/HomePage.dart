import 'package:flutter/material.dart';
import 'auth.dart';
import 'NavDrawer.dart';
import 'GiftListPage.dart';
import 'GiftList.dart';
import 'package:gift_tracker/models/Gift.dart';

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signedOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        //specifying widgets to right of appBar
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 17.0, color: Colors.white),
            ),
            onPressed: _signedOut,
          ),
        ],
      ),
      drawer: NavDrawer(),
      body: Container(
        //child: Text("Welcome", style: TextStyle(fontSize: 30.0),),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(3.0),
                  child: SizedBox(
                    height: 150,
                    child: GestureDetector(
                        onTap: () => _NavtoGiftListPage(context),
                        child: Card(
                            elevation: 3.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("My List", style: TextStyle(fontSize: 20.0),)
                              ],
                            ))))),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(3.0),
                  child: SizedBox(
                      height: 150,
                      child: GestureDetector(
                          onTap: () => print('Open List Tapped!'),
                          child: Card(
                              elevation: 3.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Join List", style: TextStyle(fontSize: 20.0),)
                                ],
                              ))))),
            )
          ],
        ),
      ),
    );
  }//build context

  void _NavtoGiftListPage(context)
  {
    // TODO create the entry in firebase here for the user


    GiftList giftClass = GiftList();
    List<Gift> giftList = List<Gift>();

    print('Create List Tapped!');

    Navigator.push(context, MaterialPageRoute(builder:
        (context) => GiftListPage(
          giftClass: giftClass, giftList: giftList, auth: Auth(),
        )));
  }
}
