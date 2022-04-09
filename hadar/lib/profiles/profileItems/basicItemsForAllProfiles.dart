import 'package:flutter/material.dart';
import 'package:hadar/Design/basicTools.dart';
import 'package:hadar/Design/descriptionBox.dart';
import 'package:hadar/profiles/profileItems/validators.dart';
import 'package:hadar/services/DataBaseServices.dart';
import 'package:hadar/users/CurrentUser.dart';
import 'package:hadar/users/Privilege.dart';
import 'package:hadar/users/User.dart' as a;
import 'package:hadar/utils/HelpRequestType.dart';
import 'ChangeLangDialogue.dart';
import 'basicItemsForAdminProfile.dart';
import 'basicItemsForUserProfile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'changePassword.dart';
import 'notificationSwitch.dart';

Widget changeLocationDialogue(BuildContext context) {
  // a.User user = CurrentUser.curr_user!;
  final newLoactionKey = GlobalKey<FormState>();
  final newLoactionController = TextEditingController();

  return SingleChildScrollView(
    child: new AlertDialog(
      backgroundColor: BasicColor.backgroundClr,
      title: Center(
          child: Text(AppLocalizations.of(context)!.changeStableLocation)),
      content: Column(
        children: [
          Container(
            height: 90,
            child: Form(
              child: DescriptionBox(
                  AppLocalizations.of(context)!.current,
                  Icon(Icons.lock, color: Colors.white),
                  Colors.white,
                  Colors.white,
                  Validators.validateLocation,
                  newLoactionController,
                  false,
                  Colors.black),
              key: newLoactionKey,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            Spacer(
              flex: 1,
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: ()async {
               await DataBaseService().updateLocation(newLoactionController.text, CurrentUser.curr_user!);
                Navigator.pop(context, true);
              },
              child: Text(AppLocalizations.of(context)!.confirm),
            ),
          ],
        ),
      ],
    ),
  );
}

//when a user clicks on the category, he gets a description box,
// where he can describe his request
class DescriptonBox extends StatefulWidget {

  DescriptonBox(this.title);

  final _DescriptonBox desBoxState = _DescriptonBox();
  final String title;

  void processText() {
    desBoxState.processText();
  }

  @override
  _DescriptonBox createState() => desBoxState;
}

class _DescriptonBox extends State<DescriptonBox> {
  String _inputtext = '';
  TextEditingController inputtextField = TextEditingController();

  void processText() {
    setState(() {
      _inputtext = inputtextField.text;
      HelpRequestType helpRequestType = HelpRequestType(_inputtext);
      _inputtext = ''; //todo: if there is a problem return this to null and check it
      DataBaseService().addHelpRequestTypeDataBase(helpRequestType);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  controller: inputtextField,
                  textAlign: TextAlign.right,
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

class MainInfo extends StatelessWidget {
  final a.User user;
  final String privilege;

  MainInfo(this.user, this.privilege);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(AppLocalizations.of(context)!.language),
                Icon(Icons.language),
              ],
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    ChangeLangDialogue(privilege),
              );
            }),
        SizedBox(
          height: 60,
        ),
        Text(
          user.name,
          style: TextStyle(
              fontSize: 25.0,
              color: Colors.blueGrey,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 10,
        ),
        /*Text(
          privilege,
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.black45,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w300),
        ),*/
      ],
    );
  }
}

class AboutMe extends StatelessWidget {
  final a.User user;

  AboutMe(this.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.telNumberTwoDots + user.phoneNumber,
          style: TextStyle(
              fontSize: 15.0,
              color: Colors.blueGrey,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          AppLocalizations.of(context)!.emailTwoDots + user.email,
          style: TextStyle(
              fontSize: 15.0,
              color: Colors.blueGrey,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class ManagePersonalInfo extends StatefulWidget {
  final a.User user;

  ManagePersonalInfo(this.user);

  @override
  State<ManagePersonalInfo> createState() => _ManagePersonalInfoState();
}

class _ManagePersonalInfoState extends State<ManagePersonalInfo> {
  final nameKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  late ProfileButton buttonCreate;

  late List<HelpRequestType> types;

  _ManagePersonalInfoState(){
    buttonCreate = ProfileButton();
    init();
  }


  init() async {
    List<HelpRequestType> types =
        await DataBaseService().helpRequestTypesAsList();
  }



  ifVolunteerShowCat(BuildContext context) {
    if (widget.user.privilege == Privilege.Volunteer) {
      return VolunteerShowCategories();
    } else
      return SizedBox();
  }

  ifNotAdminShowLocation(BuildContext context){
    ButtonStyle style = buttonCreate.getStyle(context);
    if(widget.user.privilege!=Privilege.Admin){
      return TextButton(
        child: buttonCreate.getChild(
            AppLocalizations.of(context)!.changeStableLocation,
            Icons.location_on),
        style: style,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                changeLocationDialogue(context),
          );
        },
      );
    }
    else{
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    ButtonStyle style = buttonCreate.getStyle(context);

    return Column(
      children: [
        Row(
          children: [
            TextButton(
              child: buttonCreate.getChild(
                  AppLocalizations.of(context)!.notification,
                  Icons.notifications_rounded),
              style: style,
              onPressed: (){},
            ),
            Spacer(),
            Container(
              child: NotificationSwitch(),
              padding: EdgeInsets.only(left: 10.0),
            ),
          ],
        ),
        ifNotAdminShowLocation(context),
        TextButton(
          child: buttonCreate.getChild(
              AppLocalizations.of(context)!.changePassword, Icons.lock),
          style: style,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  changePasswordDialogue(context),
            );
          },
        ),
        ifVolunteerShowCat(context),
      ],
    );
  }
}

class SignOut extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            AppLocalizations.of(context)!.signOut,
            style: TextStyle(
                fontSize: 17.0,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
          ),
          Icon(Icons.logout),
        ],
      ),
      style: TextButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        padding: EdgeInsets.only(left: 10.0),
      ),
      onPressed: () {
        DataBaseService().Sign_out(context);
      },
    );
  }
}

class Item {
  Item({
    required this.name,
    required this.builder,
    this.isExpanded = false,
  });

  String name;
  Widget builder;
  bool isExpanded;
}

class BasicLists {
  a.User user;
  Widget parent;
  late List<Item> listForUserView;
  late List<Item> listForUserAdminView;
  late List<Item> listForAdminView;

  BasicLists(this.user, this.parent, BuildContext context) {

    listForAdminView = [
      Item(
        name: AppLocalizations.of(context)!.infoAboutMe,
        builder: AboutMe(user),
      ),
      Item(
        name: AppLocalizations.of(context)!.managePersonalInfo,
        builder: ManagePersonalInfo(user),
      ),
      Item(
        name: AppLocalizations.of(context)!.manageSystem,
        builder: ManageTheSystem(),
      ),
      Item(
        name: AppLocalizations.of(context)!.other,
        builder: OtherUserAccess(user),
      ),
    ];
    listForUserView = [
      Item(
        name: AppLocalizations.of(context)!.infoAboutMe,
        builder: AboutMe(user),
      ),
      Item(
        name: AppLocalizations.of(context)!.managePersonalInfo,
        builder: ManagePersonalInfo(user),
      ),
      Item(
        name: AppLocalizations.of(context)!.contact,
        builder: ContactUs(user, parent),
      ),
      Item(
        name: AppLocalizations.of(context)!.other,
        builder: OtherUserAccess(user),
      ),
    ];
    listForUserAdminView = [
      Item(
        name: AppLocalizations.of(context)!.userInfo,
        builder: AboutMe(user),
      ),
      Item(
        name: AppLocalizations.of(context)!.other,
        builder: OtherAdminAccess(user),
      ),
    ];
  }
}

class RemoveUser extends StatelessWidget {
  final a.User user;

  RemoveUser(this.user);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      backgroundColor: BasicColor.backgroundClr,
      title: Center(
          child: Text(
        AppLocalizations.of(context)!.areYouSure,
        textDirection: TextDirection.rtl,
      )),
      actions: <Widget>[
        Row(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            Spacer(
              flex: 1,
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () async {
                await DataBaseService().RemoveCurrentuserFromAuthentication();
                DataBaseService().RemoveUserfromdatabase(user);
                DataBaseService().Sign_out(context);
              },
              child: Text(AppLocalizations.of(context)!.confirm),
            ),
          ],
        ),
      ],
    );
  }
}

class SortByCatForAll extends StatefulWidget {
  final Widget parent;
  final a.User user;
  final List<Item> items;

  SortByCatForAll(this.parent, this.user, this.items);

  @override
  _SortByCatForAllState createState() =>
      _SortByCatForAllState(user, parent, items);
}

class _SortByCatForAllState extends State<SortByCatForAll> {
  a.User user;
  Widget parent;
  List<Item> _items;

  _SortByCatForAllState(this.user, this.parent, this._items);

  ExpansionPanelRadio _buildExpansionPanelRadio(Item item) {
    return ExpansionPanelRadio(
      value: item.name,
      backgroundColor: Colors.white,
      canTapOnHeader: true,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Container(
          child: ListTile(
            title: Text(
              item.name,
              //textDirection: TextDirection.rtl,
            ),
          ),
        );
      },
      body: item.builder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList.radio(
      expandedHeaderPadding: EdgeInsets.all(10),
      dividerColor: BasicColor.backgroundClr,
      elevation: 4,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _items[index].isExpanded = !isExpanded;
        });
      },
      children: _items.map((item) => _buildExpansionPanelRadio(item)).toList(),
    );
  }
}

class ProfileButton {
  Widget getChild(String title, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon),
        Text(title),
      ],
    );
  }

  ButtonStyle getStyle(BuildContext context) {
    return TextButton.styleFrom(
      primary: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(right: 25.0),
    );
  }
}
