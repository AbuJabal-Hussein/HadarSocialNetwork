import 'package:flutter/material.dart';
import 'package:hadar/Design/basicTools.dart';
import 'package:hadar/Design/text_feilds/custom_text_feild.dart';
import 'package:hadar/users/Privilege.dart';
import 'package:hadar/users/UnregisteredUser.dart';

import 'package:hadar/users/Volunteer.dart';
import 'package:hadar/utils/VerificationRequest.dart';

import '../../DataBaseServices.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VolunteerRegisterPage extends StatefulWidget {
  final Volunteer user;
  VolunteerRegisterPage(this.user);
  @override
  _VolunteerRegisterPageState createState() =>
      _VolunteerRegisterPageState(this.user);
}

class _VolunteerRegisterPageState extends State<VolunteerRegisterPage> {
  final birthDate = GlobalKey<FormState>();
  final location = GlobalKey<FormState>();
  final status = GlobalKey<FormState>();
  final work = GlobalKey<FormState>();
  final birthplace = GlobalKey<FormState>();
  final spokenLangs = GlobalKey<FormState>();

  final mobility = GlobalKey<FormState>();
  final firstAidCourse = GlobalKey<FormState>();

  final Volunteer user;
  _VolunteerRegisterPageState(this.user);

  final birthDateController = TextEditingController();
  final locationController = TextEditingController();
  final statusController = TextEditingController();
  final workController = TextEditingController();
  final birthPlaceController = TextEditingController();
  final spokenLangsController = TextEditingController();

  final mobilityController = TextEditingController();
  final firstAidCourseController = TextEditingController();


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
    return new Scaffold(
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  demo_bg(Column(children: [
                    SizedBox(height: 60),
                    Form(
                      child: Custom_Text_feild(
                          AppLocalizations.of(context)!.dateOfBirth,
                          Icon(Icons.account_circle_rounded,
                              color: Colors.white),
                          Colors.white,
                          Colors.white,
                          null,
                          birthDateController,
                          false,
                          Colors.white),
                      key: birthDate,
                    ),
                    Form(
                      child: Custom_Text_feild(
                          AppLocalizations.of(context)!.address,
                          Icon(Icons.account_circle_rounded,
                              color: Colors.white),
                          Colors.white,
                          Colors.white,
                          null,
                          locationController,
                          false,
                          Colors.white),
                      key: location,
                    ),
                    Form(
                      child: Custom_Text_feild(
                          AppLocalizations.of(context)!.familyStatus,
                          Icon(Icons.account_circle_rounded,
                              color: Colors.white),
                          Colors.white,
                          Colors.white,
                          null,
                          statusController,
                          false,
                          Colors.white),
                      key: status,
                    ),
                    Form(
                      child: Custom_Text_feild(
                          AppLocalizations.of(context)!.job,
                          Icon(Icons.account_circle_rounded,
                              color: Colors.white),
                          Colors.white,
                          Colors.white,
                          null,
                          workController,
                          false,
                          Colors.white),
                      key: work,
                    ),
                    Form(
                      child: Custom_Text_feild(
                          AppLocalizations.of(context)!.birthLocation,
                          Icon(Icons.account_circle_rounded,
                              color: Colors.white),
                          Colors.white,
                          Colors.white,
                          null,
                          birthPlaceController,
                          false,
                          Colors.white),
                      key: birthplace,
                    ),
                    Form(
                      child: Custom_Text_feild(
                          AppLocalizations.of(context)!.spokenLanguages,
                          Icon(Icons.account_circle_rounded,
                              color: Colors.white),
                          Colors.white,
                          Colors.white,
                          null,
                          spokenLangsController,
                          false,
                          Colors.white),
                      key: spokenLangs,
                    ),

                    Form(
                      child: Custom_Text_feild(
                          AppLocalizations.of(context)!.mobility,
                          Icon(Icons.account_circle_rounded,
                              color: Colors.white),
                          Colors.white,
                          Colors.white,
                          null,
                          mobilityController,
                          false,
                          Colors.white),
                      key: mobility,
                    ),
                    Form(
                      child: Custom_Text_feild(
                          AppLocalizations.of(context)!.firstAid,
                          Icon(Icons.account_circle_rounded,
                              color: Colors.white),
                          Colors.white,
                          Colors.white,
                          null,
                          firstAidCourseController,
                          false,
                          Colors.white),
                      key: firstAidCourse,
                    ),

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
                            AppLocalizations.of(context)!.apply,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          onPressed: () {
                            user.firstaidcourse = firstAidCourseController.text;
                            user.mobility = mobilityController.text;
                            user.spokenlangs = spokenLangsController.text;
                            user.location = locationController.text;
                            user.birthdate = birthDateController.text;
                            user.birthplace = birthPlaceController.text;
                            user.status = statusController.text;
                            user.work = workController.text;
                            UnregisteredUser sender = UnregisteredUser(user.name, user.phoneNumber, user.email, user.id);

                            DataBaseService().addVerficationRequestToDb(VerificationRequest(sender, Privilege.Volunteer, DateTime.now()
                            ,user.birthdate , user.location , user.status , user.work , user.birthplace , user.spokenlangs , user.mobility ,user.firstaidcourse,[]));
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
