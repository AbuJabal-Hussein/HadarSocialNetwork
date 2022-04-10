
import 'package:flutter/material.dart';
import 'package:hadar/Design/basicTools.dart';
import 'package:hadar/users/CurrentUser.dart';
import 'package:hadar/users/UserInNeed.dart';
import 'package:hadar/utils/HelpRequest.dart';
import 'package:hadar/utils/HelpRequestType.dart';
import 'package:hadar/services/DataBaseServices.dart';
import 'package:provider/provider.dart';
import 'Design/mainDesign.dart';
import 'feeds/OrganizationFeed.dart';
import 'feeds/user_inneed_feed.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'main.dart';

class RequestWindow extends StatefulWidget {
  final BuildContext parentContext;
  final List<HelpRequestType> types;
  static TextEditingController locationController = TextEditingController();

  RequestWindow(this.types, this.parentContext);

  @override
  State<RequestWindow> createState() => _RequestWindowState();
}

class _RequestWindowState extends State<RequestWindow> {
  late DescriptonBox desBox;

  late Dropdown drop;

  // _RequestWindowState(){
  //   init();
  // }
  //
  void init(BuildContext context) {
    this.desBox = DescriptonBox(title: AppLocalizations.of(context)!.explanation);

    this.drop = Dropdown(desBox, widget.types);
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    String langCode = MainApp.of(widget.parentContext)!.getLangCode();
    bool isRTL = (langCode == "he" || langCode == "ar");
    return Scaffold(
        //backgroundColor: BasicColor.backgroundClr,
        bottomNavigationBar: BottomBar(),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate:
                  MySliverAppBar(expandedHeight: 150, title: AppLocalizations.of(context)!.chooseCategory),
              pinned: true,
            ),
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 120,
                    ),

                    Container(
                      height: 100,
                      child: drop,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: TextFormField(
                        controller: RequestWindow.locationController,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: BasicColor.clr),
                            ),

                            hintText:  AppLocalizations.of(context)!.changeRequestLocation,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            )
                        ),
                      ),
                    ),
                    Container(
                      height: 140,
                      child: desBox,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15, right: 10, left: 10),
                      alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.organizationServices,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: BasicColor.clr,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w400),
                      ),

                    ),
                    Container(
                      height: 300,
                        child: OrganizationsInfoList(context)
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
  final DescriptonBox desBox;
  late final DropDownState dropDownState;
  final List<HelpRequestType> types;

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

  DropDownState(this.desBox, this.types){
    selectedType = types[0];
  }

  HelpRequestType getSelectedType() {
    return selectedType;
  }

  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.end,
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

  final _DescriptonBox desBoxState = _DescriptonBox();
  final String title;

  void setSelectedType(HelpRequestType selectedType) {
    desBoxState.setSelectedType(selectedType);
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

  void handleFeedChange(HelpRequest helpRequest, bool addedRequest) {
    //setState(() {
    if (addedRequest) {
      DataBaseService().addHelpRequestToDataBaseForUserInNeed(helpRequest);
    }
    //feed.removeWhere((element) => element.category.description == "money");
    //});
  }

  void _processText() {
    setState(() {
      helpRequestType = HelpRequestType(_inputtext);
      _inputtext = inputtextField.text;
      helpRequest =
          HelpRequest(helpRequestType, _inputtext, DateTime.now(), CurrentUser.curr_user!.id,'',Status.UNVERFIED,RequestWindow.locationController.text.isEmpty ? (CurrentUser.curr_user! as UserInNeed).location: RequestWindow.locationController.text);
      print("input text" + _inputtext);
      print("helpRequest" + helpRequestType.description);

      handleFeedChange(helpRequest, true);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => UserInNeedHelpRequestsFeed()),);
      // if (Navigator.canPop(context)) {
      //   Navigator.pop(
      //     context,
      //   );
      // }
      returnToFeed();
    }
    );
  }

  void returnToFeed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return StreamProvider<List<HelpRequest>>.value(
          value: DataBaseService().getUserHelpRequests(CurrentUser.curr_user! as UserInNeed),
          initialData: [],
          child: UserInNeedHelpRequestsFeed(),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: inputtextField,
                  autofocus: true,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: widget.title,
                  ),
                )),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                RaisedButton(
                  onPressed: () {
                    returnToFeed();
                  },
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                SizedBox(
                  width: 25,
                ),
                RaisedButton(
                  onPressed: () {
                    _processText();
                  },
                  child: Text(AppLocalizations.of(context)!.confirm),
                ),

              ],
            ),


          ],
        ),
      ),
    );
  }
}
