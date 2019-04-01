import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'NavDrawer.dart';
import 'AddGiftPage.dart';
import 'GiftList.dart';

class GiftListPage extends StatefulWidget
{
  @override
  _GiftListPage createState() => _GiftListPage();
}

class _GiftListPage extends State<GiftListPage>
{
  // -- Variables -- //
  var gifts = new GiftList();

  // -- Functions -- //

  _buildGiftsList(index)
  {
    if(gifts.isListEmpty())
      return new Center( //TODO make this something better looking
          child: Text("Your list is empty! \n"
                      "Add some gifts and they will be displayed here!",
                 style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold)
          )
      );
    else
      return new GestureDetector(
        onTap: ()
         {
           // TODO later on, ONLY the giftee should be able to tap the gift
           // TODO  and make updates it
           print("gift tapped");
         },
        child: Container(
          padding: EdgeInsets.only(left: 10.0, top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      //"temp",
                      gifts.getName(index),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Text(
                      //"temp",
                      gifts.getDescription(index),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic
                      )
                    )
                  ],
                )
              )
            ],
          )
        )
      );
  }

  // -- Main Widget Builder --//

  @override
  Widget build(BuildContext context) {
    // forces portrait usage of this page/widget
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => new AddGiftPage()))
        }
      ),

      appBar: AppBar(
        title: Text("Gift List") //TODO this should later be the name of the list
      ),

      drawer: NavDrawer(),

      body: Container(
        child: ListView.builder(
          itemCount: gifts.getLengthOfList(),
          itemBuilder: (BuildContext context, int index) => _buildGiftsList(index)
            //TODO i think this should be rebuilt everytime the page is brought up
        )
      )
    );
  }
}

