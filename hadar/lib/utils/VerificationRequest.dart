import 'package:hadar/users/Privilege.dart';
import 'package:hadar/users/UnregisteredUser.dart';

import 'HelpRequestType.dart';

class VerificationRequest {
  UnregisteredUser sender;
  Privilege type;
  DateTime date;
  late bool accepted;
  late int time;
  String birthdate;
  String location;
  String status;
  String work;

  String birthplace;
  String spokenlangs;

  String firstaidcourse;
  String mobility;

  List<HelpRequestType> services;

  VerificationRequest(
      this.sender,
      this.type,
      this.date,
      this.birthdate,
      this.location,
      this.status,
      this.work,
      this.birthplace,
      this.spokenlangs,
      this.firstaidcourse,
      this.mobility,
      this.services){

    accepted = false;
    time = date.millisecondsSinceEpoch;
  }

}
