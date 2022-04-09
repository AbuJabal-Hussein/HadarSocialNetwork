import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hadar/Design/basicTools.dart';
import 'package:hadar/Design/mainDesign.dart';
import 'package:hadar/services/DataBaseServices.dart';
import 'package:hadar/users/Admin.dart';
import 'package:hadar/users/Privilege.dart';
import 'package:hadar/users/UnregisteredUser.dart';
import 'package:hadar/users/User.dart';
import 'package:hadar/utils/HelpRequest.dart';
import 'package:hadar/utils/HelpRequestType.dart';
import 'package:hadar/utils/VerificationRequest.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as Intl;
import 'package:url_launcher/url_launcher.dart';

import 'adminfeedtile.dart';
import 'feed_items/help_request_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AdminJoinRequestsFeed extends StatelessWidget{
  final Admin admin;
  AdminJoinRequestsFeed(this.admin);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<VerificationRequest>>.value(
      value: DataBaseService().getVerificationRequests(),
      initialData: [],
      child: _AdminJoinRequestsFeed(admin: admin,),
    );
  }

}

class _AdminJoinRequestsFeed extends StatefulWidget{

  final Admin admin;
  _AdminJoinRequestsFeed({required this.admin});

  @override
  State<StatefulWidget> createState() => _AdminJoinRequestsFeedState();

}


class _AdminJoinRequestsFeedState extends State<_AdminJoinRequestsFeed>{

  late List<VerificationRequest>? feed;

  void handleAcceptVerificationRequest(VerificationRequest joinRequest){
    setState(() {
      feed!.remove(joinRequest);
      DataBaseService().acceptVerificationRequest(joinRequest);
    });
  }

  void showJoinRequestStatus(VerificationRequest joinRequest) {
    showModalBottomSheet(
        context: context,
        /*shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30) ,topRight: Radius.circular(30))
        ),*/
        builder: (context) {
          return JoinRequestStatusWidget(joinRequest, this);
        });
  }

  @override
  Widget build(BuildContext context) {

    feed = Provider.of<List<VerificationRequest>>(context);
    //final requests = Provider.of<List<HelpRequest>>(context);
    List<FeedTile> feedTiles = [];

    if(feed != null) {
      feedTiles = feed!.map((VerificationRequest joinRequest) {
        return FeedTile(tileWidget: JoinRequestItem(
          joinRequest: joinRequest, parent: this,
        ),);
      }).toList();
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        semanticChildCount: (feed == null) ? 0 : feed!.length,
        padding: const EdgeInsets.only(bottom: 70.0, top: 10),
        children: feedTiles,
      ),
    );

  }
}

class JoinRequestItem extends StatelessWidget {
  JoinRequestItem({required this.joinRequest, required this.parent})
      : super(key: ObjectKey(joinRequest));

  final VerificationRequest joinRequest;
  final _AdminJoinRequestsFeedState parent;

  @override
  Widget build(BuildContext context) {
    final Intl.DateFormat dateFormat = Intl.DateFormat.yMd().add_Hm();
    return ListTile(
      onTap: () => parent.showJoinRequestStatus(joinRequest),
      isThreeLine: true,
      title: Column(
        children: [

          Row(
              children: <Widget> [
                Container(
                  child: Text(joinRequest.sender.name),
                  alignment: Alignment.topRight,
                ),
                Spacer(),
                Container(
                  child:Text(dateFormat.format(joinRequest.date)),
                  alignment: Alignment.topLeft,
                ),

              ]
          ),
          Container(
            child:(){
              String userType = AppLocalizations.of(context)!.userInNeed;
              if(joinRequest.type == Privilege.Volunteer)
                userType = AppLocalizations.of(context)!.volunteer;
              else if(joinRequest.type == Privilege.Admin)
                userType = AppLocalizations.of(context)!.admin;
              return Text( AppLocalizations.of(context)!.wantToJoinAs + userType , style:TextStyle(color: BasicColor.clr));
            }() ,
            alignment: Alignment.topRight,
          ),
        ],
      ),
      subtitle: Container(
          child:
                Row(children: <Widget>[
                  Spacer(),
                  Spacer(),
                  CallWidget(joinRequest.sender.phoneNumber),
                ]),

      ),

    );
  }
}

class CallWidget extends StatelessWidget {
  final String phoneNumber;

  CallWidget(this.phoneNumber);

  _launchCaller() async{
    var url = "tel:" + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.call,
        size: 20.0,
        color: BasicColor.clr,
      ),
      onPressed: _launchCaller,
    );
  }
}


class JoinRequestStatusWidget extends StatelessWidget {
  JoinRequestStatusWidget(this.joinRequest, this.feedWidgetObject)
      : super(key: ObjectKey(joinRequest));

  final VerificationRequest joinRequest;
  final _AdminJoinRequestsFeedState feedWidgetObject;

  @override
  Widget build(BuildContext context) {
    final Intl.DateFormat dateFormat = Intl.DateFormat.yMd().add_Hm();
    return Container(
      //this color is to make the corners look transparent to the main screen: Color(0xFF696969)
      color: Color(0xFF696969),
      height: MediaQuery.of(context).size.height /1.5,
      child: Container(
        decoration:  BoxDecoration(
          color: BasicColor.backgroundClr,
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(20),
            topLeft: const Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child:Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                //width: MediaQuery.of(context).size.width,
                child:Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    dateFormat.format(joinRequest.date),
                    style: TextStyle(
                      fontSize: 14,
                      color: BasicColor.clr,
                      fontFamily: "Arial",
                    ),
                  ),
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: (){
                    String userType = AppLocalizations.of(context)!.userInNeed;
                    if(joinRequest.type == Privilege.Volunteer)
                      userType = AppLocalizations.of(context)!.volunteer;
                    else if(joinRequest.type == Privilege.Admin)
                      userType = AppLocalizations.of(context)!.admin;
                    return Text(joinRequest.sender.name + AppLocalizations.of(context)!.wantToJoinAs + userType ,
                      style: TextStyle(
                        fontSize: 25,
                        color:BasicColor.clr,
                        fontFamily: "Arial"
                    ),);
                  }()
                ),
              ),

              Container(
                padding: const EdgeInsets.only(left: 20, bottom: 5, top: 5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppLocalizations.of(context)!.nameTwoDots + joinRequest.sender.name,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: "Arial"
                    ),
                    maxLines: 10,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, bottom: 5, top: 5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppLocalizations.of(context)!.emailTwoDots + joinRequest.sender.email,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: "Arial"
                    ),
                    maxLines: 10,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, bottom: 5, top: 5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppLocalizations.of(context)!.idTwoDots + joinRequest.sender.id,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: "Arial"
                    ),
                    maxLines: 10,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, bottom: 5, top: 5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppLocalizations.of(context)!.telNumberTwoDots + joinRequest.sender.phoneNumber,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: "Arial"
                    ),
                    maxLines: 10,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),

              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child:Row(
                    children: [
                      RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        onPressed: () {
                          feedWidgetObject.handleAcceptVerificationRequest(joinRequest);
                          if (Navigator.canPop(context)) {
                            Navigator.pop(
                              context,
                            );
                          }
                          else{
                            log("error: couldn't pop the ModalBottomSheet context from the navigator!");
                          }

                        },
                        child: Text(AppLocalizations.of(context)!.approveRequest),
                      ),
                      Spacer(),
                      RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        onPressed: () {
                          DataBaseService().DenyVerficationRequest(joinRequest);
                          if (Navigator.canPop(context)) {
                            Navigator.pop(
                              context,
                            );
                          }
                          else{
                            log("error: couldn't pop the ModalBottomSheet context from the navigator!");
                          }

                        },
                        child: Text(AppLocalizations.of(context)!.rejectRequest),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

