

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hadar/services/DataBaseServices.dart';
import 'package:hadar/users/Admin.dart';
import 'package:hadar/users/CurrentUser.dart';
import 'package:hadar/users/Privilege.dart';
import 'package:hadar/users/User.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

class LocalNotifications{
  static FlutterLocalNotificationsPlugin instance = new FlutterLocalNotificationsPlugin();

  LocalNotifications();
}

Future initNotifications() async {
  //LocalNotifications.instance = new FlutterLocalNotificationsPlugin();
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  /*final IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  final MacOSInitializationSettings initializationSettingsMacOS =
  MacOSInitializationSettings();*/
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    /*iOS: initializationSettingsIOS,
    macOS: initializationSettingsMacOS*/);

  await LocalNotifications.instance.initialize(initializationSettings,
      onSelectNotification: selectNotification);

  tz.initializeTimeZones();
  return LocalNotifications.instance;
}


Future selectNotification(String payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
  //todo: fix the navigation.. this context is just a dummy.
  //todo: figure out what context should be used instead
  //todo: also change the page to which we redirect
  main();
  /*BuildContext buildContext;
  await Navigator.push(
    buildContext,
    MaterialPageRoute<void>(builder: (context) => main()),
  );*/
}


//Admin Notifications

Future sendJoinRequestNotification() async {
  //LocalNotifications.instance = new FlutterLocalNotificationsPlugin();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'join request',
      'new join request',
      'this channel is used to notify an Admin about new join requests'
  );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics
  );

  await LocalNotifications.instance.show(0, 'בקשות הצטרפות',
      'קיימות בקשות הצטרפות חדשות!', platformChannelSpecifics);
}

Future sendUnverifiedHelpReqNotification() async {
  //LocalNotifications.instance = new FlutterLocalNotificationsPlugin();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
      'unverified help request',
      'new unverified help request',
      'this channel is used to notify an Admin about new unverified help requests'
  );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics
  );

  await LocalNotifications.instance.show(1, 'בקשות עזרה',
      'קיימות בקשות עזרה חדשות שממתינות לאימות!', platformChannelSpecifics);
}

Future sendApprovedHelpReqNotification() async {
  //LocalNotifications.instance = new FlutterLocalNotificationsPlugin();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
      'approved help request',
      'new approved help request',
      'this channel is used to notify an Admin about help requests that a volunteer has offered to help with'
  );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics
  );

  await LocalNotifications.instance.show(2, 'בקשות עזרה',
      'מתנדב מציע לעזור באחת הבקשות וממתין לפרטים נוספים!', platformChannelSpecifics);
}


//Volunteer Notifications

Future sendVolHelpReqNotification() async {
  //LocalNotifications.instance = new FlutterLocalNotificationsPlugin();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
      'volunteer help request',
      'new volunteer help request',
      'this channel is used to notify a volunteer about new help requests'
  );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics
  );

  await LocalNotifications.instance.show(1, 'בקשות עזרה',
      'קיימות בקשות עזרה חדשות!', platformChannelSpecifics);
}


//User-InNeed Notifications


