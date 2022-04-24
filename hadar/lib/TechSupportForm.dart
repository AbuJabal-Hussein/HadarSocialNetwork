import 'package:flutter/material.dart';

import 'package:hadar/profiles/profile.dart';
import 'package:hadar/services/DataBaseServices.dart';
import 'package:hadar/users/CurrentUser.dart';
import 'package:hadar/utils/UsersInquiry.dart';

import 'Design/mainDesign.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TechSupportForm extends StatelessWidget {
  ProfilePage parent;
  BuildContext context;

  late DescriptonBox desReason;
  late DescriptonBox desBox;
  late DescriptonBox desName;
  late DescriptonBox desId;
  late DescriptonBox desPhone;

  TechSupportForm(this.parent, this.context) {
    this.desName = DescriptonBox(title: AppLocalizations.of(context)!.name, parent: parent);
    this.desId = DescriptonBox(title: AppLocalizations.of(context)!.id, parent: parent);
    this.desPhone = DescriptonBox(title: AppLocalizations.of(context)!.telNumber, parent: parent);
    this.desReason = DescriptonBox(title: AppLocalizations.of(context)!.inquiryReasonInShort, parent: parent);
    this.desBox = DescriptonBox(title: AppLocalizations.of(context)!.explanation, parent: parent);
  }


  Widget getRelContainer(DescriptonBox des){
    return Container(
      height: 100,
      child: des,
    );
  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(

        bottomNavigationBar: BottomBar(),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate:
              MySliverAppBar(expandedHeight: 150, title: AppLocalizations.of(context)!.inquiry),
              pinned: true,
            ),
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: Column( children:[
                  SizedBox(
                    height: 100,
                  ),
                  getRelContainer(desName),
                  getRelContainer(desId),
                  getRelContainer(desPhone),
                  getRelContainer(desReason),
                  getRelContainer(desBox),
                  SizedBox(
                    height: 40,
                  ),
                  RaisedButton(
                    onPressed: () async{
                      String userName = desName.getDataEntered();
                      String userId = desId.getDataEntered();
                      String userPhone = desPhone.getDataEntered();
                      String reason = desReason.getDataEntered();
                      String description = desBox.getDataEntered();
                      print(userName);
                      print(userPhone);
                      print(reason);
                      print(description);
                      UserInquiry userInquiry= UserInquiry(userName, userId, userPhone, reason, description, DateTime.now());
                      DataBaseService().addInquiryToDataBase(userInquiry);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage(userToShow: CurrentUser.curr_user!)),
                      );
                      // Navigator.canPop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.confirm),
                  ),
                ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}


class DescriptonBox extends StatefulWidget {
  DescriptonBox({required this.title, required this.parent});
  _DescriptonBox desBoxState = _DescriptonBox();
  final String title;
  final ProfilePage parent;

  String getDataEntered(){
    return desBoxState.getDataEntered();
  }

  @override
  _DescriptonBox createState() => desBoxState;
}

class _DescriptonBox extends State<DescriptonBox> {

  TextEditingController inputtextField = TextEditingController();

  String getDataEntered(){
    return inputtextField.text;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: inputtextField,
                  autofocus: true,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: widget.title,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
