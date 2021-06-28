import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hadar/Design/basicTools.dart';
import 'package:hadar/Design/mainDesign.dart';
import 'package:hadar/Design/text_feilds/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hadar/services/DataBaseServices.dart';
import 'package:hadar/services/authentication/validators.dart';
import 'package:hadar/users/CurrentUser.dart';
import 'package:hadar/users/UserInNeed.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class userInNeedRegisterPage extends StatefulWidget {
  final UserInNeed user;

  userInNeedRegisterPage(this.user);
  @override
  _userInNeedRegisterPageState createState() =>
      _userInNeedRegisterPageState(this.user);
}

class _userInNeedRegisterPageState extends State<userInNeedRegisterPage> {
  final age = GlobalKey<FormState>();
  final location = GlobalKey<FormState>();
  final status = GlobalKey<FormState>();
  final eduStatus = GlobalKey<FormState>();
  final numKids = GlobalKey<FormState>();
  final homephone = GlobalKey<FormState>();
  final specialstatus = GlobalKey<FormState>();
  final rev7a = GlobalKey<FormState>();
  final gender = GlobalKey<FormState>();
  final UserInNeed user;
  _userInNeedRegisterPageState(this.user);

  final age_controller = TextEditingController();
  final location_controller = TextEditingController();
  final status_controller = TextEditingController();
  final eduStatus_controller = TextEditingController();
  final numKids_controller = TextEditingController();
  final homephone_controller = TextEditingController();
  final specialstatus_controller = TextEditingController();
  final rev7a_controller = TextEditingController();
  final gender_controller = TextEditingController();

  String genderStr;
  @override
  Widget build(BuildContext context) {

    return new Directionality(
        textDirection: TextDirection.rtl,
        child: new Builder(builder: (BuildContext context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(child: get_bg()),
          );
        }));
  }

  Widget get_bg() {
    String dropdownValue = AppLocalizations.of(context).male;
    return new Scaffold(
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  demo_bg(Column(children: [
                    SizedBox(height: 60),
                    Form(
                      child: Custom_Text_feild(
                          AppLocalizations.of(context).age,
                          null,
                          Colors.white,
                          Colors.white,
                          Age_Validator.Validate,
                          age_controller,
                          false,
                          Colors.white),
                      key: age,
                    ),
                    Form(
                      child: Custom_Text_feild(
                          AppLocalizations.of(context).address,
                          null,
                          Colors.white,
                          Colors.white,
                          place_Validator.Validate,
                          location_controller,
                          false,
                          Colors.white),
                      key: location,
                    ),
                    Form(
                      child: Custom_Text_feild(
                          AppLocalizations.of(context).familyStatus,
                          null,
                          Colors.white,
                          Colors.white,
                          null,
                          status_controller,
                          false,
                          Colors.white),
                      key: status,
                    ),
                    Form(
                      child: Custom_Text_feild(
                          AppLocalizations.of(context).childrenNumbers,
                          null,
                          Colors.white,
                          Colors.white,
                          num_Of_Son_Validator.Validate,
                          numKids_controller,
                          false,
                          Colors.white),
                      key: numKids,
                    ),
                    Form(
                      child: Custom_Text_feild(
                          AppLocalizations.of(context).education,
                          null,
                          Colors.white,
                          Colors.white,
                          null,
                          eduStatus_controller,
                          false,
                          Colors.white),
                      key: eduStatus,
                    ),
                    Form(
                      child: Custom_Text_feild(
                          AppLocalizations.of(context).homePhoneNumber,
                          null,
                          Colors.white,
                          Colors.white,
                          null,
                          homephone_controller,
                          false,
                          Colors.white),
                      key: homephone,
                    ),
                    Form(
                      child: Custom_Text_feild(
                          AppLocalizations.of(context).whereYouCame,
                          null,
                          Colors.white,
                          Colors.white,
                          null,
                          specialstatus_controller,
                          false,
                          Colors.white),
                      key: specialstatus,
                    ),
                    Form(
                      child: Custom_Text_feild(
                          AppLocalizations.of(context).rev7aPatient,
                          null,
                          Colors.white,
                          Colors.white,
                          null,
                          rev7a_controller,
                          false,
                          Colors.white),
                      key: rev7a,
                    ),
                    Form(
                      child:Container(
                          //mainAxisSize.min
                          margin: const EdgeInsets.all(10.0),
                        //color: Colors.blue[600],
                          width: 200,
                          height: 40,
                          //child: ChangeLangDialogue(genderStr)
                        child: Center(
                          child: DropdownButton<String>(
                            //dropdownColor: Colors.black,
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward, color: Colors.white,),
                            iconSize: 24,
                            elevation: 16,
                            dropdownColor: Colors.grey,
                            style: const TextStyle(color: Colors.white),
                            underline: Container(
                              height: 2,
                              color: Colors.white,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            // items: <String>[AppLocalizations.of(context).male, AppLocalizations.of(context).female]
                            //     .map((String value) {
                            //   return DropdownMenuItem<String>(
                            //     value: value,
                            //     child: Center(child: new Text(value, style: TextStyle(fontSize: 18),)),
                            //   );
                            // }).toList(),
                            items: <String>[AppLocalizations.of(context).male, AppLocalizations.of(context).female]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            //value: MainApp.of(context).getLanguage(),
                            // onChanged: (String newLang) {
                            //   String male = AppLocalizations.of(context).male;
                            //   String female = AppLocalizations.of(context).female;
                            //   switch (newLang) {
                            //     case "male":
                            //       genderStr = AppLocalizations.of(context).male;
                            //       break;
                            //     case "female":
                            //       genderStr = AppLocalizations.of(context).female;
                            //       break;
                            //     default:
                            //       genderStr = AppLocalizations.of(context).male;
                            //   }
                            //
                            //
                            // },
                          ),
                        ),
                      ),
                      //child: ChangeLangDialogue(genderStr),
                      key: gender,
                    )
                  ])),
                  new Container(
                      margin: EdgeInsets.all(10),
                      child: Center(
                        child: new RaisedButton(
                          color: BasicColor.clr,
                          splashColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            AppLocalizations.of(context).apply,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          onPressed: () async{
                            if(!age.currentState.validate() || !location.currentState.validate() || numKids.currentState.validate() ){
                              return;
                            }
                            user.Age = age_controller.text == ''
                                ? 0
                                : int.parse(age_controller.text);
                            user.homePhone = homephone_controller.text;
                            user.numKids = age_controller.text == ''
                                ? 0
                                : int.parse(numKids_controller.text);
                            user.eduStatus = eduStatus_controller.text;
                            user.Status = status_controller.text;
                            user.Location = location_controller.text;
                            user.specialStatus = specialstatus_controller.text;
                            user.Rav7a = rev7a_controller.text;
                            DataBaseService().addUserInNeedToDataBase(user);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      )),
                ],
              ))),
    );
  }
}

class demo_bg extends StatelessWidget {
  Widget son;
  demo_bg(this.son);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.transparent,
          child: new Container(
            padding: EdgeInsets.only(bottom: 100),
            decoration: new BoxDecoration(
                color: BasicColor.clr,
                borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(150),
                  bottomRight: const Radius.circular(150),
                )),
            child: son,
          ),
        ),
      ],
    );
  }
}



class ChangeLangDialogue extends StatelessWidget {
  String genderStr;
  ChangeLangDialogue(this.genderStr);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Center(child: Text(AppLocalizations.of(context).gender, style: TextStyle(fontSize: 10),)),
      backgroundColor: BasicColor.backgroundClr,
      actions: [
        Container(
          child: Center(
            child: DropdownButton<String>(
              items: <String>[AppLocalizations.of(context).male, AppLocalizations.of(context).female]
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(child: new Text(value, style: TextStyle(fontSize: 18),)),
                );
              }).toList(),
              //value: MainApp.of(context).getLanguage(),
              onChanged: (String newLang) {
                 String male = AppLocalizations.of(context).male;
                 String female = AppLocalizations.of(context).female;
                switch (newLang) {
                  case "male":
                    genderStr = AppLocalizations.of(context).male;
                    break;
                  case "female":
                    genderStr = AppLocalizations.of(context).female;
                    break;
                  default:
                    genderStr = AppLocalizations.of(context).male;
                }


              },
            ),
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}