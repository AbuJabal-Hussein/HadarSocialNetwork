
import 'dart:core';


import 'package:hadar/feeds/feed_items/category_scrol.dart';
import 'package:hadar/utils/HelpRequest.dart';
import 'package:hadar/utils/HelpRequestType.dart';

import 'Privilege.dart';
import 'RegisteredUser.dart';

class Volunteer extends RegisteredUser{
  List helpRequests = [];
  int count;
  String stars;
  String birthdate;
  String location;
  String status;
  String work ;
  String birthplace;
  String spokenlangs ;

  String mobility ;
  String firstaidcourse ;
  List<HelpRequestType> categories;
  List<MyListView> categoriesAsList = [];

  Volunteer(String name, String phoneNumber, String email, String id ,int lastNotifiedTime, this.stars , this.count
      , this.birthdate, this.location, this.status, this.work, this.birthplace
      , this.spokenlangs, this.mobility, this.firstaidcourse , this.categories )
      : super(name, phoneNumber, email, Privilege.Volunteer, id, lastNotifiedTime){

    if (categories == null){
      return;
    }
    for(var i = 0; i < this.categories.length; i++){
      this.categoriesAsList.add(MyListView( this.categories[i].description));
    }
  }

}