import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'NavDrawer.dart';
import 'AddGiftPage.dart';
import 'GiftList.dart';
import 'Gift.dart';

class GiftListPage extends StatefulWidget
{
  final GiftList giftClass;
  final List<Gift> giftList;

  GiftListPage({Key key, this.giftClass, this.giftList}) : super(key: key);

  @override
  _GiftListPage createState() => _GiftListPage();
}

class _GiftListPage extends State<GiftListPage>
{
  // -- Variables -- //
  //var gifts = new GiftList();


  // -- Functions -- //

  _buildGiftsList(index)
  {
    if(widget.giftClass.isListEmpty(widget.giftList))
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
           // TODO when the gift is tapped the giftee should be able to update the gift parameters

           // TODO later on, ONLY the giftee should be able to tap the gift
           // TODO  and make updates it
           print("gift tapped");
         },
        child: Container(
          padding: EdgeInsets.only(left: 10.0, top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                            widget.giftClass.getName(widget.giftList, index),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        Text(
                            widget.giftClass.getDescription(widget.giftList, index),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontStyle: FontStyle.italic
                            )
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                              "\$${(widget.giftClass.getPrice(widget.giftList, index)).toString()}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ],
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
            builder: (context) => new AddGiftPage(
                giftClass: widget.giftClass, giftList: widget.giftList
            )))
        }
      ),

      appBar: AppBar(
        title: Text("Gift List"), //TODO this should later be the name of the list
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.format_list_bulleted, size: 30.0),
                onPressed: () => {
                  print("bullet list called")
                },
              ),

              IconButton(
                icon: Icon(Icons.apps, size: 31.0),
                onPressed: () => {
                  print("tiles list called")
                },
              ),

              SizedBox(width: 10.0)

            ],
          )
        ]
      ),

      drawer: NavDrawer(),

      body: Container(
        child: ListView.builder(
          itemCount: widget.giftClass.getLengthOfList(widget.giftList),
          itemBuilder: (BuildContext context, int index) => _buildGiftsList(index)
        )
      )
    );
  }
}

