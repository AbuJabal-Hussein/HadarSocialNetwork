
import 'package:hadar/users/RegisteredUser.dart';

import 'Privilege.dart';

class Admin extends RegisteredUser{
  List users = [];


  Admin(String name, String phoneNumber, String email, String id, int lastNotifiedTime)
      : super(name, phoneNumber, email, Privilege.Admin, id, lastNotifiedTime);

}