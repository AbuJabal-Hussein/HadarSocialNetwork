import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hadar/services/DataBaseServices.dart';

import 'package:hadar/services/authentication/LogInPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hadar/services/getters/GetCurrentUser.dart';

import 'package:hadar/utils/HelpRequest.dart';
import 'package:hadar/utils/HelpRequestType.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MainApp());
}

class MainApp extends StatefulWidget {

  @override
  _MainAppState createState() => _MainAppState();

  static _MainAppState of(BuildContext context) => context.findAncestorStateOfType<_MainAppState>();

}

class _MainAppState extends State<MainApp> {
  Locale _locale = Locale.fromSubtags(languageCode: 'ar');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double marginSize = kIsWeb ? 0.0 : 0.0;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('he', ''), // Hebrew, no country code
        const Locale('ar', ''), // Arabic, no country code
        //const Locale('en', ''), // English, no country code
        //const Locale('ru', ''), // Russian, no country code
      ],
      locale: _locale,
      home: Container(
        margin: const EdgeInsets.only(left: marginSize, right: marginSize),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: GetCurrentUser(),
        ),
      ),
    );
  }
}

