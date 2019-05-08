import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'GiftListPage.dart';
import 'HomePage.dart';
import 'auth.dart';
import 'joinListPage.dart';

class NavDrawer extends StatelessWidget
{
  final BaseAuth auth = Auth();
  @override
  Widget build(BuildContext context){
    // forces portrait usage of this page/widget
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

      return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text("DO SOMETHING HERE"), //TODO do something here
              decoration: BoxDecoration(
                  color: Colors.yellow
              ),
            ),

            ListTile(
              title: Text(
                "Home Page",
                style: TextStyle(fontSize: 20.0)
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>  HomePage()));
              },
            ),

            ListTile(
              title: Text(
                "Gift List",
                style: TextStyle(fontSize: 20.0),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => GiftListPage(
                         auth: auth,
                    )));

              },
            ),

            ListTile(
              title: Text(
                "Join List",
                style: TextStyle(fontSize: 20.0),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => joinListPage()));

              },
            ),
          ],
        )
    );
  }
}