import 'package:hadar/profiles/profileItems/basicItemsForAllProfiles.dart';
import 'package:flutter/material.dart';
import 'package:hadar/users/CurrentUser.dart';
import 'package:hadar/users/Privilege.dart';
import 'package:hadar/users/User.dart' as a;
import '../Design/basicTools.dart';
import '../Design/mainDesign.dart';

//todo: fix this
class ProfilePage extends StatefulWidget {
  late a.User user;
  late final String privilege;
  bool adminIsOnProfile = false;

  ProfilePage(a.User currUser) {
    user = CurrentUser.curr_user!;

    if (user.privilege == Privilege.Admin) {
      adminIsOnProfile = true;
      privilege = 'Admin';
      user = currUser;
    }
    switch (user.privilege) {
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

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late BasicLists getLists;

  Widget userOrAdminAccess() {
    if (widget.adminIsOnProfile) return SortByCatForAll(widget, widget.user, getLists.listForUserAdminView);
    return SortByCatForAll(widget, widget.user, getLists.listForUserView);
  }

  Widget checkBottomBar() {
    if (widget.adminIsOnProfile) return AdminBottomBar();
    return BottomBar();
  }

  Widget ifUserShowSignOut() {
    if (widget.adminIsOnProfile) return SizedBox();
    return SignOut();
  }

  @override
  Widget build(BuildContext context) {

    getLists=BasicLists(widget.user, widget, context);

    return  Scaffold(
        bottomNavigationBar: checkBottomBar(),
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
