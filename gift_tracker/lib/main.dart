import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'NavDrawer.dart';
import 'loginPage.dart';
import 'auth.dart';

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
        //backgroundColor: Color.fromRGBO(223, 75, 253, 1.0),
      ),

      drawer: NavDrawer(/*giftClass, giftList*/),

      body: Center(
      child: RaisedButton(
        child: Text('Login'),

        //auth: Auth() implements BaseAuth abstract class
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => LoginPage(auth: Auth(),))
            )
          },
        ),
      ),
    );
  }

} //_HomePage

