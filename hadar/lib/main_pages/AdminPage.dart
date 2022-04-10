import 'package:flutter/material.dart';
import 'package:hadar/feeds/AdminVerifiedHelpRequestsFeed.dart';

import 'package:hadar/feeds/Admin_JoinRequest_Feed.dart';

import 'package:hadar/Design/basicTools.dart';
import 'package:hadar/Design/mainDesign.dart';
import 'package:hadar/feeds/adminfeedtile.dart';

import 'package:hadar/users/Admin.dart';
import 'package:hadar/users/CurrentUser.dart';
import 'package:hadar/utils/HelpRequest.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AdminPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Admin currUser = CurrentUser.curr_user! as Admin;
    return Scaffold(
      bottomNavigationBar: AdminBottomBar(),
      backgroundColor: BasicColor.backgroundClr,
      body: DefaultTabController(
              length: 3,
              child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    AdminViewRequestsBar(AppLocalizations.of(context)!.requests),
                    new SliverPadding(
                      padding: new EdgeInsets.all(2.0),
                      sliver: new SliverList(
                        delegate: new SliverChildListDelegate([
                          TabBar(
                            labelColor: Colors.black87,
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              new Tab(
                                  icon: Icon(Icons.account_circle_outlined,
                                  size: 25),
                                  text: AppLocalizations.of(context)!.joinRequests
                              ),
                              new Tab(
                                  icon: Icon(Icons.supervisor_account_sharp,
                                  size: 25),
                                  text: AppLocalizations.of(context)!.waitingRequests
                              ),
                              new Tab(
                                  icon: Icon(Icons.verified_user_outlined,
                                      size: 25),
                                  text: AppLocalizations.of(context)!.approvedRequests
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    Center(
                      child: AdminJoinRequestsFeed(currUser),
                    ),
                    Center(
                      child: AdminHelpRequestsFeed(currUser, Status.UNVERFIED),
                    ),
                    Center(
                      child: AdminVerifiedHelpRequestsFeed(currUser, Status.APPROVED),

                    ),
                  ],
                ),
                // Center(

              ),
            ),
      );
  }
}
