
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/cupertino.dart';
import 'package:hadar/feeds/feed_items/category_scrol.dart';
import 'package:hadar/main_pages/AdminPage.dart';
import 'package:hadar/main_pages/UserInNeedPage.dart';
import 'package:hadar/main_pages/VolunteerPage.dart';
import 'package:hadar/services/DataBaseServices.dart';
import 'package:hadar/services/WorkmanagerHandling.dart';
import 'package:hadar/users/Admin.dart';
import 'package:hadar/users/UserInNeed.dart';
import 'package:hadar/users/Volunteer.dart';
import 'package:hadar/utils/DummyWidget.dart';
import 'package:hadar/utils/HelpRequestType.dart';
import 'Privilege.dart';
import 'User.dart';

class CurrentUser{

  static User? curr_user;
  static Widget userMainWidget = DummyWidget.get();

  User? getCurrent() {
    return curr_user;
  }

  static Future<Widget> init_user(BuildContext context) async{
    curr_user = await DataBaseService().getCurrentUser();

    if(curr_user == null){
      return userMainWidget;
    }

    switch(curr_user!.privilege){
      case Privilege.Admin:
        if(curr_user!.lastNotifiedTime != -1 && !kIsWeb) {
          initWorkmanager();
        }
        userMainWidget = AdminPage(curr_user as Admin);
        return userMainWidget;

      case Privilege.UserInNeed:
        userMainWidget = UserInNeedPage(curr_user as UserInNeed);
        return userMainWidget;

      case Privilege.Volunteer:
        if(curr_user!.lastNotifiedTime != -1 && !kIsWeb) {
          initWorkmanager();
        }
        List<HelpRequestType> db_categories = await DataBaseService().helpRequestTypesAsList();
        List<HelpRequestType> user_categories = (curr_user as Volunteer).categories;

        if(user_categories.isEmpty) {
          for (var i = 0; i < db_categories.length; i++) {
            (curr_user as Volunteer).categoriesAsList.add(MyListView(db_categories[i].description));
          }
        }

        (curr_user as Volunteer).categoriesAsList.add(MyListView('אחר'));
        userMainWidget = VolunteerPage(curr_user as Volunteer , (curr_user as Volunteer).categoriesAsList);
        return userMainWidget;

      case Privilege.UnregisterUser:
        print('error in curr user');
        break;
      default:
        print('error in curr user');
        break;
    }
    return userMainWidget;
  }

  // static Widget get_current_user_page(User curr_user) async{
  //   List<HelpRequestType> categoers = await DataBaseService().helpRequestTypesAsAlist();
  //   List<MyListView> categoers_list_items;
  //   for(var i = 0; i < categoers.length; i++){
  //     categoers_list_items.add(MyListView(categoers[i].description));
  //   }
  //
  //   print(curr_user);
  //   switch(curr_user.privilege){
  //
  //     case Privilege.Admin:
  //       return AdminPage(curr_user as Admin);
  //       break;
  //     case Privilege.UserInNeed:
  //       return UserInNeedPage(curr_user as UserInNeed);
  //       break;
  //     case Privilege.Volunteer:
  //       return VolunteerPage(curr_user as Volunteer , categoers_list_items);
  //       break;
  //     case Privilege.UnregisterUser:
  //       print('error in curr user');
  //       break;
  //     default:
  //       print('error in curr user');
  //       break;
  //   }
  //
  //
  // }
}