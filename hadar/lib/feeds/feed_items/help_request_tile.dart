import 'package:flutter/material.dart';
import 'package:hadar/Design/basicTools.dart';
import 'package:hadar/feeds/helper_feed.dart';
import 'package:hadar/services/DataBaseServices.dart';
import 'package:hadar/services/getters/getUserName.dart';
import 'package:hadar/utils/HelpRequest.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';


class HelpRequestTile extends StatefulWidget {

  final HelpRequest helpRequest;
  HelpRequestTile({this.helpRequest});

  @override
  _HelpRequestTileState createState() => _HelpRequestTileState();
}




class _HelpRequestTileState extends State<HelpRequestTile> {


  _HelpRequestTileState();

  //final String formatted = formatter.format(now);


  @override
  Widget build(BuildContext context) {
    final DateTime now = widget.helpRequest.date;
    final DateFormat formatter = DateFormat.yMd().add_Hm();
    var fromnow = (Jiffy(now)).fromNow();
    Offset _tapPosition;
    void _storePosition(TapDownDetails details) {
      _tapPosition = details.globalPosition;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        color: Colors.brown[30],
        child: ListTile(
          //dense: true,
//          leading: CircleAvatar(
//            radius: 25.0,
//            backgroundColor: Colors.brown,
//          ),
          isThreeLine: true,
          //title: Text(widget.helpRequest.category.description),
          title: Row(
            children: <Widget> [
              Container(
                child:Text(widget.helpRequest.category.description) ,
                alignment: Alignment.topLeft,
              ),
              Spacer(),
              Container(
                child:Text(formatter.format(now)),
                alignment: Alignment.topRight,
              ),
            ]
          )
          ,
          subtitle: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Text(widget.helpRequest.date.toString()),
               // GetUserName(widget.helpRequest.sender_id, DataBaseService().userInNeedCollection),
                //Text(formatter.format(now)),
                //Text(fromnow),
                Text(widget.helpRequest.description),
              ]
            )
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () => print("Tap: call"),
                onLongPress: () => print("Long Press: Call"),
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.call,
                        size: 20.0,
                        color: BasicColor.userInNeedClr,
                        )
                ),
              ),
              GestureDetector(
                onTap: () => print("Tap: more_vert"),
                onTapDown: _storePosition,
                onLongPress: () async {
                  final RenderBox overlay =
                  Overlay.of(context).context.findRenderObject();
                  final int _selected = await showMenu(
                    items: [
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.done,
                                      color: Colors.green,),
                            const Text("   Accept"),

                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.clear,
                                      color: Colors.red),
                            const Text("   Deny"),
                          ]
                        )
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.person),
                            const Text("   Profile"),
                          ],
                        ),
                      )
                    ],
                    context: context,
                    position: RelativeRect.fromRect(
                        _tapPosition &
                        const Size(40, 40), // smaller rect, the touch area
                        Offset.zero & overlay.size // Bigger rect, the entire screen
                    ),
                  );
                  switch (_selected) {
                    case 1:
                      print("accept seleted");

//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => testing_stream()),
//                      );
                      break;
                    case 2:
                      print("deny seleted");
                      break;
                    case 3:
                      print("profile selected");
                      break;
                  }
                },
                child: Icon(
                  Icons.more_vert,
                  size: 20.0,
                  color: Colors.brown[900],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


