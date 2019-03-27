import 'package:flutter/material.dart';
import 'NavDrawer.dart';
import 'Gift.dart';

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

      drawer: NavDrawer(),

      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Sign Up"),
              onPressed: () => print("sign up")//TODO sign up using google account,
            ),
          ],
        )
      )

    );
  }
}
