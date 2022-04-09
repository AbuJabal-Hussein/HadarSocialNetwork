import 'package:hadar/profiles/profileItems/basicItemsForAllProfiles.dart';
import 'package:flutter/material.dart';
import 'package:hadar/users/CurrentUser.dart';
import 'package:hadar/users/User.dart' as a;
import '../Design/basicTools.dart';
import '../Design/mainDesign.dart';

class AdminProfile extends StatefulWidget {
  final a.User user;
  final String privilege = 'Admin';


  AdminProfile(this.user);

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  late BasicLists getLists;
  bool adminIsOnProfile = false;

  _AdminProfileState(){
    a.User currUser = CurrentUser.curr_user;
    if(currUser.id != widget.user.id) {
      adminIsOnProfile = true;
    }
  }

  Widget userOrAdminAccess() {
    if (adminIsOnProfile) return SortByCatForAll(widget, widget.user, getLists.listForUserAdminView);
    return SortByCatForAll(widget, widget.user, getLists.listForAdminView);
  }

  @override
  Widget build(BuildContext context) {

    getLists = BasicLists(widget.user, widget, context);

    return Scaffold(
        bottomNavigationBar: AdminBottomBar(),
        backgroundColor: BasicColor.backgroundClr,
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(expandedHeight: 150, title: widget.user.name),
              pinned: true,
            ),
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MainInfo(widget.user, widget.privilege),
                    SizedBox(
                      height: 40,
                    ),
                    userOrAdminAccess(),
                    SizedBox(
                      height: 80,
                    ),
                    SignOut(),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}
