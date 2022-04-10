import 'package:hadar/profiles/profileItems/basicItemsForAllProfiles.dart';
import 'package:flutter/material.dart';
import 'package:hadar/users/CurrentUser.dart';
import 'package:hadar/users/User.dart' as a;
import '../Design/basicTools.dart';
import '../Design/mainDesign.dart';

class AdminProfile extends StatefulWidget {
  late final a.User user;
  final String privilege = 'Admin';


  AdminProfile({a.User? userToShow}){
    if(userToShow == null){
      this.user = CurrentUser.curr_user!;
    }
    else{
      user = userToShow;
    }
  }

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  late BasicLists getLists;
  bool adminIsOnProfile = false;

  Widget userOrAdminAccess() {
    if (adminIsOnProfile) return SortByCatForAll(widget, widget.user, getLists.listForUserAdminView);
    return SortByCatForAll(widget, widget.user, getLists.listForAdminView);
  }

  @override
  Widget build(BuildContext context) {

    a.User currUser = CurrentUser.curr_user!;
    if(currUser.id != widget.user.id) {
      adminIsOnProfile = true;
    }

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
