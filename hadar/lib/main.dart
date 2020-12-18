import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hadar/Design/Buttons/RoundedWeightedButtons.dart';
import 'package:hadar/Design/basicTools.dart';

import 'package:hadar/services/DataBaseServices.dart';
import 'package:hadar/feeds/helper_feed.dart';
import 'package:hadar/services/authentication/LogInPage.dart';
import 'package:hadar/user_inneed_feed.dart';
import 'package:hadar/users/RegisteredUser.dart';
import 'package:hadar/users/User.dart';


import 'package:firebase_core/firebase_core.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print( FirebaseAuth.instance.currentUser);


  runApp(MaterialApp(
    home: LogInPage(),
  ));
}

class weork_right extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('sssssssssssssssssssssssssssssss'),
    );
  }
}



