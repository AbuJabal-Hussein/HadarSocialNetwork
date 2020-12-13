import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hadar/Design/basicTools.dart';

import 'package:hadar/services/DataBaseServices.dart';
import 'package:hadar/feeds/helper_feed.dart';
import 'package:hadar/user_inneed_feed.dart';
import 'package:hadar/users/RegisteredUser.dart';
import 'package:hadar/users/User.dart';
import 'package:hadar/users/UserInNeed.dart';
import 'package:hadar/users/Volunteer.dart';
import 'package:hadar/utils/HelpRequest.dart';
import 'package:hadar/utils/HelpRequestType.dart';
import 'package:provider/provider.dart';

import 'package:hadar/home_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'feed_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Log_In_Screen(),
  ));
}

class Log_In_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BasicColor.BackgroundClr,
        appBar: AppBar(
          backgroundColor: BasicColor.AppBarClr,
          title: Text('Hadar',
          style: TextStyle(
            color: BasicColor.BackgroundClr,
            fontSize: 30,
          ),),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Center(
              child: RaisedButton(
                child: Text("go to volunteer feed"),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => tmp()),
                  );
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text("go to user in_need feed"),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) {
                          //User(this.name, this.phoneNumber, this.email, this.privilege , this.id
                          //       );
                          return StreamProvider<List<HelpRequest>>.value(
                            value: DataBaseService().getUserHelpRequests(User("haitham", "099000","no_need",Privilege.UserInNeed,"123456789")),
                            child: UserInNeedHelpRequestsFeed(),
                          );
                        }
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

class tmp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<HelpRequestType> list1 = List<HelpRequestType>();
    list1.add(HelpRequestType('food'));
    list1.add(HelpRequestType('money'));

    return StreamProvider<List<HelpRequest>>.value(
      value: DataBaseService().getVolPendingRequests(Volunteer('hsen', 'sa', '123', false, '4', list1)),
      child: Scaffold(
        backgroundColor: BasicColor.BackgroundClr,
        appBar: AppBar(
          title: Text('Volunteer Feed'),
          backgroundColor: BasicColor.HelperClr,
          elevation: 0.0,
        ),
        body: HelperFeed(),
      ),
    );
  }
}
