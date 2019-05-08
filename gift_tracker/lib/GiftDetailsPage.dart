import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'NavDrawer.dart';

class GiftDetailsPage extends StatefulWidget
{
  var gift;

  GiftDetailsPage({Key key, this.gift}) : super(key: key);

  @override
  _GiftDetailsPage createState() => _GiftDetailsPage();
}

class _GiftDetailsPage extends State<GiftDetailsPage> {



  boughtStatus()
  {
    if(widget.gift.giftBought == true)
      return "Someone has already bought this gift!";
    else
      return "This gift is still available to buy!";
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
        appBar: AppBar(
            title: Text( "Gift List")
        ),//TODO this should later be the name of the list

        //drawer: NavDrawer(),

        body: Container(
            padding: EdgeInsets.fromLTRB(30, 100, 10, 100),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                        "Name: ",
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(width: 10),
                    Text(
                        "${widget.gift.giftName}",
                        style: TextStyle(fontSize: 20)
                    )
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  children: <Widget>[
                    Text(
                        "Description: ",
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(width: 10),
                    Text(
                        "${widget.gift.giftDescription}",
                        style: TextStyle(fontSize: 20)
                    )
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  children: <Widget>[
                    Text(
                        "Priority: ",
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(width: 10),
                    Text(
                        "${(widget.gift.giftPriority).round()}",
                        style: TextStyle(fontSize: 20)
                    )
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  children: <Widget>[
                    Text(
                        "Price: ",
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(width: 10),
                    Text(
                        "\$ ${widget.gift.giftPrice}",
                        style: TextStyle(fontSize: 20)
                    )
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  children: <Widget>[
                    Text(
                        "Date Added: ",
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(width: 10),
                    Text(
                        "${widget.gift.giftDateAdded}",
                        style: TextStyle(fontSize: 20)
                    )
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  children: <Widget>[
                    Text(
                        "Link: ",
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child:

                    Text(
                        "${widget.gift.giftLink}",
                        style: TextStyle(fontSize: 20),
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                    )),
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  children: <Widget>[
                    Text(
                        "Gift status: ",
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(width: 10),
                    Text(
                        "${boughtStatus()}",
                        style: TextStyle(fontSize: 15)
                    )
                  ],
                )


              ],
            )
        ));
  }
}
