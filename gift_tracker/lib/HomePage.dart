import 'package:flutter/material.dart';
import 'auth.dart';
import 'NavDrawer.dart';
import 'GiftListPage.dart';
import 'package:flutter/services.dart';

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
    final key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
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
      body: ListView(
        children: <Widget>[
          Center(
              child: Container(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text(
                    "Gift Tracker",
                    style: TextStyle(
                      fontSize: 50.0,
                    ),
                  ))),
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 40.0, bottom: 70.0),
              child: SizedBox(
                height: 200,
                child: Image.asset('images/HomePage_Logo.png'),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "My List",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  GestureDetector(
                    child: SizedBox(
                      child: Image.asset('images/gift.png'),
                      height: 60,
                      width: 60,
                    ),
                    onTap: () => _NavtoGiftListPage(context),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Join List",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  GestureDetector(
                    child: SizedBox(
                      child: Image.asset('images/gift.png'),
                      height: 60,
                      width: 60,
                    ),
                    onTap: () => print("shits broke yo"),
                  )
                ],
              )
            ],
          ),
          Center(
              child: Container(
                  padding: EdgeInsets.all(100.0),
                  child: SizedBox(
                    height: 60,
                    width: 200,
                    child: RaisedButton(
                      child: Text(
                        "Share List!",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.yellow,
                      onPressed: () => getUser(key),
                    ),
                  )))
        ],
      ),
//      body: Container(
//        //child: Text("Welcome", style: TextStyle(fontSize: 30.0),),
//        child: Row(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Expanded(
//              child: Container(
//                padding: EdgeInsets.all(3.0),
//                  child: SizedBox(
//                    height: 150,
//                    child: GestureDetector(
//                        onTap: () => _NavtoGiftListPage(context),
//                        child: Card(
//                            elevation: 3.0,
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: <Widget>[
//                                Text("My List", style: TextStyle(fontSize: 20.0),)
//                              ],
//                            ))))),
//            ),
//            Expanded(
//              child: Container(
//                  padding: EdgeInsets.all(3.0),
//                  child: SizedBox(
//                      height: 150,
//                      child: GestureDetector(
//                          onTap: () => print('Open List Tapped!'),
//                          child: Card(
//                              elevation: 3.0,
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.center,
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                children: <Widget>[
//                                  Text("Join List", style: TextStyle(fontSize: 20.0),)
//                                ],
//                              ))))),
//            )
//          ],
//        ),
//      ),
    );
  } //build context

  void _NavtoGiftListPage(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => GiftListPage(auth: Auth())));
  }

  void getUser(key) async {
    var user = await auth.getCurrentUser();
    var userID = user.uid;
    Clipboard.setData(ClipboardData(text: userID));
    key.currentState.showSnackBar(SnackBar(content: Text('Copied to Clipboard'),));
  }
}
