import 'package:hadar/profiles/profileItems/basicItemsForAllProfiles.dart';
import 'package:flutter/material.dart';
import 'package:hadar/users/CurrentUser.dart';
import 'package:hadar/users/Privilege.dart';
import 'package:hadar/users/User.dart' as a;
import '../Design/basicTools.dart';
import '../Design/mainDesign.dart';

class ProfilePage extends StatefulWidget {
  final a.User user;

  ProfilePage(this.user);

  @override
  State<ProfilePage> createState() => _ProfilePageState(user);
}

class _ProfilePageState extends State<ProfilePage> {
  a.User userToShow;
  late String privilege;
  bool adminIsOnProfile = false;
  late BasicLists getLists;

  _ProfilePageState(this.userToShow){
    a.User currUser = CurrentUser.curr_user!;

    if (currUser.privilege == Privilege.Admin) {
      adminIsOnProfile = true;
      privilege = 'Admin';
    }
    else{
      userToShow = currUser;
    }
    switch (userToShow.privilege) {
      case Privilege.UserInNeed:
        privilege = 'User in need';
        break;
      case Privilege.Volunteer:
        privilege = 'Volunteer';
        break;
      case Privilege.Organization:
        privilege = 'Organization';
        break;
      default:
        privilege = 'default';
        break;
    }
  }


  Widget userOrAdminAccess() {
    if (adminIsOnProfile) return SortByCatForAll(widget, widget.user, getLists.listForUserAdminView);
    return SortByCatForAll(widget, widget.user, getLists.listForUserView);
  }

  Widget checkBottomBar() {
    if (adminIsOnProfile) return AdminBottomBar();
    return BottomBar();
  }

  Widget ifUserShowSignOut() {
    if (adminIsOnProfile) return SizedBox();
    return SignOut();
  }



  @override
  Widget build(BuildContext context) {

    getLists=BasicLists(userToShow, widget, context);

    return  Scaffold(
        bottomNavigationBar: checkBottomBar(),
        backgroundColor: BasicColor.backgroundClr,
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(expandedHeight: 150, title: userToShow.name),
              pinned: true,
            ),
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MainInfo(userToShow, privilege),
                    SizedBox(
                      height: 40,
                    ),
                    userOrAdminAccess(),
                    SizedBox(
                      height: 80,
                    ),
                    ifUserShowSignOut(),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}
