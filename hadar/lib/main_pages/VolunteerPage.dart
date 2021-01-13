import 'package:flutter/material.dart';
import 'package:hadar/feeds/feed_items/category_scrol.dart';
import 'package:hadar/feeds/helper_feed.dart';
import 'package:hadar/users/UserInNeed.dart';
import 'package:hadar/users/Volunteer.dart';


class VolunteerPage extends StatelessWidget {

  final Volunteer curr_user;
  List<MyListView> categoers;
  VolunteerPage(this.curr_user,this.categoers);
  @override
  Widget build(BuildContext context) {
    return VolunteerFeed(curr_user,categoers);
  }
}