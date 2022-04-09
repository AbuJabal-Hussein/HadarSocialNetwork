import 'package:flutter/material.dart';
import 'package:hadar/feeds/AdminVerifiedHelpRequestsFeed.dart';

import 'package:hadar/feeds/Admin_JoinRequest_Feed.dart';

import 'package:hadar/Design/basicTools.dart';
import 'package:hadar/Design/mainDesign.dart';
import 'package:hadar/feeds/adminfeedtile.dart';

import 'package:hadar/users/Admin.dart';
import 'package:hadar/utils/HelpRequest.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hadar/users/User.dart' as USR;


class AdminPage extends StatelessWidget {
  final USR.User curr_user;

  AdminPage(this.curr_user);

  @override
  Widget build(BuildContext context) {

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
                      child: AdminJoinRequestsFeed(curr_user as Admin),
                    ),
                    Center(
                      child: AdminHelpRequestsFeed(curr_user as Admin,Status.UNVERFIED),
                    ),
                    Center(
                      child: AdminVerifiedHelpRequestsFeed(curr_user as Admin,Status.APPROVED),

                    ),
                  ],
                ),
                // Center(

              ),
            ),
      );
  }
}
