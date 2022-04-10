
import 'package:hadar/utils/HelpRequestType.dart';

import 'HelpRequestType.dart';

enum Status {AVAILABLE , UNVERFIED , APPROVED , REJECTED}

class HelpRequest{

  HelpRequestType category;
  String description;
  DateTime date;
  String sender_id;
  String handler_id;
  late int time;
  Status status;
  String reject_reason = '';
  String location;
  HelpRequest( this.category, this.description, this.date , this.sender_id, this.handler_id,this.status, this.location,[String rejext_reason = '']){
    time = date.millisecondsSinceEpoch;
    reject_reason = rejext_reason;
  }

  //copy constructor.. but change the date to DateTime.now()
  HelpRequest.copy(HelpRequest other):
      category = other.category,
      description = other.description,
      date = DateTime.now(),
      sender_id = other.sender_id,
      handler_id = other.handler_id,
      status = other.status,
      reject_reason = other.reject_reason,
      location = other.location{
    time = date.millisecondsSinceEpoch;
  }

}