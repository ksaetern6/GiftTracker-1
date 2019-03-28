import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'NavDrawer.dart';


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
    // forces portrait usage of this page/widget
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text("GiftTracker"),
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
