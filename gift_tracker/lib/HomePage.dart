import 'package:flutter/material.dart';
import 'auth.dart';
import 'NavDrawer.dart';
class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signedOut() async {
    try{
      await auth.signOut();
      onSignedOut();
    }
    catch (e) {
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
            child: Text('Logout', style: TextStyle(
                fontSize: 17.0,
                color: Colors.white
              ),
            ),
            onPressed: _signedOut,
          ),
        ],
      ),

      drawer: NavDrawer(),
      
      body: Container(
        child: Center(
          child: Text("Welcome", style: TextStyle(fontSize: 30.0),),
        ),
      ),
    );
  }
}