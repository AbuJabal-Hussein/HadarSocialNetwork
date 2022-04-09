import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hadar/lang/HebrewText.dart';

import 'package:hadar/users/CurrentUser.dart';
import 'package:hadar/users/User.dart';
import 'package:hadar/users/UserInNeed.dart';
import 'package:hadar/utils/HelpRequest.dart';
import 'package:hadar/utils/HelpRequestType.dart';
import 'package:hadar/services/DataBaseServices.dart';
import 'package:intl/intl.dart' as Intl;
import 'package:provider/provider.dart';

import '../Design/mainDesign.dart';
import '../main.dart';
import '../profiles/adminProfile.dart';
import '../feeds/user_inneed_feed.dart';
import '../users/Privilege.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class AdminRequestWindow extends StatelessWidget {
  late DescriptonBox desBox;
  late DescriptonBox desAge;
  late DescriptonBox desId;
  late DescriptonBox desLocation;
  late DescriptonBox desName;
  late DescriptonBox desPhone;
  late Dropdown drop;
  List<HelpRequestType> types;
  BuildContext context;

  AdminRequestWindow(this.types, this.context) {
    init();
  }

  void init() {
    this.desBox = DescriptonBox(title: AppLocalizations.of(context)!.requestDescription);
    this.desAge = DescriptonBox(title: AppLocalizations.of(context)!.age);
    this.desId = DescriptonBox(title: AppLocalizations.of(context)!.id);
    this.desLocation = DescriptonBox(title: AppLocalizations.of(context)!.location);
    this.desName = DescriptonBox(title: AppLocalizations.of(context)!.name);
    this.desPhone = DescriptonBox(title: AppLocalizations.of(context)!.telNumber);
    this.drop = Dropdown(desBox, types);
  }

  Widget getRelContainer(DescriptonBox des){
    return                   Container(
      height: 100,
      child: des,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: AdminBottomBar(),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate:
                  MySliverAppBar(expandedHeight: 150, title: AppLocalizations.of(context)!.addRequest),
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
                  getRelContainer(desAge),
                  getRelContainer(desLocation),
                    Container(
                      height: 50,
                      child: drop,
                    ),
                  getRelContainer(desBox),
                  SizedBox(
                    height: 40,
                  ),
                  RaisedButton(
                    onPressed: () async{
                      String userId = desId.getDataEntered();
                      String userName = desName.getDataEntered();
                      String userAge = desAge.getDataEntered();
                      String locationDescription = desLocation.getDataEntered();
                      String userPhone = desPhone.getDataEntered();
                      String requestDescription = desBox.getDataEntered();
                      HelpRequestType helpRequestType=drop.getSelectedType();
                      int val = int.tryParse(userAge) ?? 0;
                      String dummy = 'אנונימי';
                      print(userId);
                      print(userAge);
                      print(userName);
                      print(userPhone);
                      HelpRequest req = HelpRequest(helpRequestType, requestDescription, DateTime.now(), userId, '', Status.AVAILABLE,locationDescription);
                      UserInNeed to_add = UserInNeed(Privilege.Anonymous, userName, userPhone, dummy, userId, 0, val, locationDescription, dummy, 0, dummy, dummy, dummy, dummy);
                      await DataBaseService().addUserInNeedToDataBase(to_add);
                      DataBaseService().addHelpRequestToDataBaseForUserInNeed(req);


                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminProfile(CurrentUser.curr_user)),
                      );
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

class Dropdown extends StatefulWidget {
  DescriptonBox desBox;
  late DropDownState dropDownState;
  List<HelpRequestType> types;

  Dropdown(this.desBox, this.types) {
    this.dropDownState = DropDownState(desBox, types);
  }

  @override
  State createState() => dropDownState;

  HelpRequestType getSelectedType() {
    return dropDownState.getSelectedType();
  }
}

class DropDownState extends State<Dropdown> {
  late HelpRequestType selectedType;
  DescriptonBox desBox;
  List<HelpRequestType> types;

  DropDownState(this.desBox, this.types);

  HelpRequestType getSelectedType() {
    return selectedType;
  }

  @override
  Widget build(BuildContext context) {
    String langCode = MainApp.of(context)!.getLangCode();
    bool isRTL = (langCode == "he" || langCode == "ar");
    return Scaffold(
      body: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: DropdownButton<HelpRequestType>(
            hint: Text(AppLocalizations.of(context)!.chooseCategory),
            value: selectedType,
            onChanged: (HelpRequestType? value) {
              setState(
                () {
                  selectedType = value!;
                  desBox.setSelectedType(selectedType);
                },
              );
            },
            items: types.map((HelpRequestType type) {
              return DropdownMenuItem<HelpRequestType>(
                value: type,
                child: Row(
                  mainAxisAlignment: isRTL ? MainAxisAlignment.start : MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      type.description,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

//when a user clicks on the category, he gets a description box,
// where he can describe his request
class DescriptonBox extends StatefulWidget {
  DescriptonBox({required this.title});
  _DescriptonBox desBoxState = _DescriptonBox();
  final String title;

  void setSelectedType(HelpRequestType selectedType) {
    desBoxState.setSelectedType(selectedType);
  }

  String getDataEntered(){
    return desBoxState.getDataEntered();
  }



  HelpRequestType getHelpRequestType() {
    return desBoxState.getHelpRequestType();
  }

  @override
  _DescriptonBox createState() => desBoxState;
}

class _DescriptonBox extends State<DescriptonBox> {
  String _inputtext = '';
  late HelpRequest helpRequest;
  TextEditingController inputtextField = TextEditingController();
  late HelpRequestType helpRequestType;



  void setSelectedType(HelpRequestType selectedType) {
    setState(() {
      _inputtext = selectedType.description;
    });
  }

  HelpRequestType getHelpRequestType() {
    return helpRequestType;
  }

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
                )
            ),
          ],
        ),
      ),
    );
  }
}
