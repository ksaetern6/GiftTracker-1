import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'NavDrawer.dart';
import 'loginPage.dart';


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

class HomePage extends StatelessWidget
{

  //AuthGoogle authService = AuthGoogle();
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
      child: RaisedButton(
        child: Text('Login'),
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => LoginPage())
            )
          },
        ),
      ),
    );
  }

} //_HomePage

