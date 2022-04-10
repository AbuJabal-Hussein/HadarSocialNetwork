import 'package:flutter/material.dart';

import 'package:hadar/services/DataBaseServices.dart';
import 'package:hadar/users/User.dart' as a;
import 'package:hadar/utils/HelpRequestType.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../TechSupportForm.dart';
import 'basicItemsForAllProfiles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'checkBoxForCategories.dart';
import 'package:hadar/users/CurrentUser.dart';
import 'package:hadar/users/Volunteer.dart';

class VolunteerShowCategories extends StatefulWidget {
  VolunteerShowCategories();

  _VolunteerShowCategoriesState createState() =>
      _VolunteerShowCategoriesState();
}

class _VolunteerShowCategoriesState extends State<VolunteerShowCategories> {
  var isVisible = false;
  late List<HelpRequestType> types;
  ProfileButton buttonCreate = ProfileButton();


  late CheckBoxForCategories checkBox;
  Volunteer user = CurrentUser.curr_user! as Volunteer;

  Future initTypes() async {
    types = await DataBaseService().helpRequestTypesAsList();
  }


  getCurrentCategories(){
    List<Widget> current=[];
    List<HelpRequestType> getData;
    if(user.categories.isEmpty)
      getData = types;
    else
      getData =user.categories;
      for(HelpRequestType category in getData){
        if(category.description == 'אחר')
          continue;
        current.add(Chip(
          label:  Text(category.description,style: TextStyle(color: Colors.white),),
          backgroundColor: Theme.of(context).primaryColor,
        ));
    }
    return current;
  }


  @override
  Widget build(BuildContext context) {
    initTypes();
    checkBox=CheckBoxForCategories(types, context);
    return Column(
      children: [
        TextButton(
          child: buttonCreate.getChild(
              AppLocalizations.of(context)!.favoriteCategories, Icons.favorite),
          style: buttonCreate.getStyle(context),
          onPressed: () {
            setState(
              () {
                isVisible = !isVisible;
              },
            );
          },
        ),
        Visibility(
          child:  Container(
            padding: EdgeInsets.only(left:20, right:20 ),
            child: Wrap(
              spacing: 5.0,
              children:
                getCurrentCategories(),
            ),
          ),
          visible: !isVisible,
        ),
        Visibility(
          visible: isVisible,
          child: checkBox,
        ),
        Visibility(
          visible: isVisible,
          child: ElevatedButton(
            onPressed: () {
              DataBaseService()
                  .updateVolCategories(checkBox.getSelectedItems(), user);
              setState(
                () {
                  isVisible = false;

                },
              );
            },
            child: Text(AppLocalizations.of(context)!.update),
          ),
        )
      ],
    );
  }
}

class ContactUs extends StatefulWidget {
  final a.User user;
  final parent;

  ContactUs(this.user, this.parent);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  _launchCaller() async {
    String number;
    number = '0526736167';
    var url = "tel:" + number;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    ProfileButton buttonCreate = ProfileButton();
    ButtonStyle style = buttonCreate.getStyle(context);

    return Column(
      children: [
        TextButton(
          child: buttonCreate.getChild(
              AppLocalizations.of(context)!.fillApplication,
              Icons.wysiwyg_rounded),
          style: style,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TechSupportForm(widget.parent, context)),
            );
          },
        ),
        TextButton(
          child: buttonCreate.getChild(
              AppLocalizations.of(context)!.call, Icons.phone),
          style: style,
          onPressed: () {
            _launchCaller();
          },
        ),
      ],
    );
  }
}

class OtherUserAccess extends StatefulWidget {
  final a.User user;

  OtherUserAccess(this.user);

  @override
  State<OtherUserAccess> createState() => _OtherUserAccessState();
}

class _OtherUserAccessState extends State<OtherUserAccess> {

  ProfileButton buttonCreate = ProfileButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          child: buttonCreate.getChild(
              AppLocalizations.of(context)!.deleteMeFromSystem,
              Icons.person_remove),
          style: buttonCreate.getStyle(context),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => RemoveUser(widget.user),
            );
          },
        ),
      ],
    );
  }
}

class OtherAdminAccess extends StatefulWidget {
  final a.User user;

  OtherAdminAccess(this.user);

  @override
  State<OtherAdminAccess> createState() => _OtherAdminAccessState();
}

class _OtherAdminAccessState extends State<OtherAdminAccess> {
  ProfileButton buttonCreate = ProfileButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          child: buttonCreate.getChild(
              AppLocalizations.of(context)!.deleteUserFromSystem,
              Icons.person_remove),
          style: buttonCreate.getStyle(context),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => RemoveUser(widget.user),
            );
          },
        ),
      ],
    );
  }
}
