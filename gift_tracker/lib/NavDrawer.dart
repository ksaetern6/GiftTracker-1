import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'GiftListPage.dart';
import 'GiftList.dart';
import 'package:gift_tracker/models/Gift.dart';
import 'HomePage.dart';
import 'auth.dart';

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
                // this giftList class and gift list is created here and then passed to each page
                //  I do this because we don't want to keep creating instances of new giftLists,
                //  otherwise the gifts won't be added to the same list
                //  YEAH THIS PROBABLY ISNT THE BEST WAY TO DO THIS BUT IT WORKS FOR NOW
                //  A better way at some point might be needed
                // TODO one issue is the list is deleted when the gift list page is left, but only when we go to the gift list
                // TODO   from this drawer link. the one on the home page works keeps the state even when the gift list page is left
                var giftClass = new GiftList();
                var giftList = new List<Gift>();

                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => GiftListPage(
                        giftClass: giftClass, giftList: giftList, auth: auth,
                    )));
              },
            ),
          ],
        )
    );
  }
}