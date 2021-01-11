import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:hadar/feeds/Admin_JoinRequest_Feed.dart';

import 'package:hadar/Design/basicTools.dart';
import 'package:hadar/Design/mainDesign.dart';
import 'package:hadar/feeds/adminfeedtile.dart';
import 'package:hadar/feeds/feed_items/help_request_tile.dart';
import 'package:hadar/feeds/helper_feed.dart';
import 'package:hadar/services/DataBaseServices.dart';

import 'package:hadar/users/Admin.dart';
import 'package:hadar/users/CurrentUser.dart';
import 'package:hadar/utils/HelpRequest.dart';
import 'package:hadar/utils/VerificationRequest.dart';
import 'package:provider/provider.dart';

import '../viewRegisteredUsers.dart';

class AdminPage extends StatelessWidget {
  final Admin curr_user;

  AdminPage(this.curr_user);

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          title: Text('Admin page'),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: Column(
                children: [
                  Icon(Icons.admin_panel_settings_outlined , size: 40,),
                  RaisedButton(
                    child: Text('sign out'),
                    onPressed: (){
                      FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                    },
                  ),
                  RaisedButton(
                    child: Text('All requests'),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => showAllRequests(curr_user)),
                      );
                    }
                  ),
                  RaisedButton(
                      child:Text('join requests'), onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StreamProvider<List<VerificationRequest>>.value(
                            value: DataBaseService().getVerificationRequests(),
                            child: AdminJoinRequestsFeed(admin: curr_user,),),
                    )
                    );
                  }),
                  RaisedButton(
                      child:Text('allUsers'), onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllUsersView()
                        )
                    );
                  }),
                ],
            ),
          ),
        ),
      );
  }
}
