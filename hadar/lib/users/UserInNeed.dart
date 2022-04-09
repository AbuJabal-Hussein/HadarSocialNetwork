
import 'Privilege.dart';
import 'RegisteredUser.dart';

class UserInNeed extends RegisteredUser{

  int age;
  String location;
  String status;
  int numKids;
  String eduStatus;
  String homePhone;
  String specialStatus;
  String rav7a;

  UserInNeed(Privilege privilege , String name, String phoneNumber, String email,
      String id, int lastNotifiedTime, this.age , this.location, this.status, this.numKids,
      this.eduStatus, this.homePhone, this.specialStatus, this.rav7a)
      : super(name, phoneNumber, email, privilege, id, lastNotifiedTime);

}