import 'package:flutter/material.dart';
import 'package:hadar/Design/basicTools.dart';
import 'package:hadar/Design/mainDesign.dart';

import 'package:hadar/services/DataBaseServices.dart';
import 'package:hadar/users/Volunteer.dart';
import 'package:hadar/utils/HelpRequest.dart';
import 'package:hadar/feeds/feed_items/help_request_tile.dart';
import 'package:hadar/utils/HelpRequestType.dart';
import 'package:provider/provider.dart';

import 'feed_items/category_scrol.dart';

class volunteer_feed_pafe_state {
  static _VolunteerFeedStatefulState? state;
}

class HelperFeed extends StatefulWidget {
  @override
  _HelperFeedState createState() => _HelperFeedState();
}

class _HelperFeedState extends State<HelperFeed> {
  @override
  Widget build(BuildContext context) {
    final requests = Provider.of<List<HelpRequest>>(context);
    if(requests.isNotEmpty) {
      return new Directionality(
        textDirection: TextDirection.rtl,
        child: new Builder(
          builder: (BuildContext context) {
            return ListView(
              padding: const EdgeInsets.only(bottom: 70.0, top: 20),
              semanticChildCount: requests.length,
              children: requests.map((request) {
                return FeedTile(tileWidget: VolunteerFeedTile(request));
              }).toList(),
            );
          },
        ),
      );
    }
    else{
      //todo: translate this sentence
      return Center(
        child: Text('No Help Requests Available'),
      );
    }
  }
}

class VolunteerFeedStateful extends StatefulWidget {

  late final _VolunteerFeedStatefulState state;

  VolunteerFeedStateful(Volunteer user, List<MyListView> categories, String title){
    state = _VolunteerFeedStatefulState(user, categories, title);
  }

  @override
  _VolunteerFeedStatefulState createState() => state;

}

class _VolunteerFeedStatefulState extends State<VolunteerFeedStateful> {
  Volunteer curr_user;
  String title = '';

  _VolunteerFeedStatefulState(this.curr_user, this.categories, this.title);

  List<MyListView> categories;

  @override
  Widget build(BuildContext context) {
    volunteer_feed_pafe_state.state = this;
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      backgroundColor: BasicColor.backgroundClr,
      body: CustomScrollView(slivers: [
        AdminViewRequestsBar(title),
        SliverFillRemaining(
          child: Container(
            // margin: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Expanded(
                    child: StatefulCategoriesList(
                        categories,
                        DataBaseService().getVolunteerHelpRequestsByCategory(
                            HelpRequestType(categories[0].Help_request_type),
                            curr_user.id),
                        categories[0].Help_request_type)),
                //Expanded(child: HelperFeed()),
              ],
            ),
          ),
        ),
      ]),
      // body: HelperFeed(),
    );
  }
}

class VolunteerFeed extends StatelessWidget {
  final Volunteer curr_user;
  final String title;
  final List<MyListView> categories;

  VolunteerFeed(this.curr_user, this.categories, this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      backgroundColor: BasicColor.backgroundClr,
      body: CustomScrollView(slivers: [
        AdminViewRequestsBar(title),
        SliverFillRemaining(
          child: Container(
            // margin: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Expanded(
                    child: StatefulCategoriesList(
                        categories,
                        DataBaseService().getVolunteerHelpRequestsByCategory(
                            HelpRequestType(categories[0].Help_request_type),
                            curr_user.id),
                        categories[0].Help_request_type)),
                //Expanded(child: HelperFeed()),
              ],
            ),
          ),
        ),
      ]),
      // body: HelperFeed(),
    );
  }
}
