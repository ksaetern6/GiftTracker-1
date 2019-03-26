import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
        title: "GiftTracker",
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),

        home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget
{
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple UI App"),
      ),

      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Sign Up"),
              //onPressed: //TODO sign up using google account,
            )
          ],
        )
      )

    );
  }
}