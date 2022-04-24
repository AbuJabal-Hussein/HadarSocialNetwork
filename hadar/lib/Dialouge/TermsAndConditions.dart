
import 'package:flutter/material.dart';
import '../Design/basicTools.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsAndConditions extends StatelessWidget {
  final Size size;
  const TermsAndConditions({ required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: size.height * 0.6,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: BasicColor.backgroundClr,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Material(
                  color: Colors.transparent,
                  child: Center(child: Text("תנאי השימוש של האפליקציה", style: TextStyle(color: BasicColor.clr,fontSize: 20),))),
              SizedBox(height: 25,),
              Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25.0, left: 25.0),
                    child: Text('''ברוכים הבאים לרשת החברתית
                    
הרשת החברתית נותנת מענה לצרכים הקשורים בחיי היומיום בשכונת הדר, פועלת בתחומים גוונים ומייצרת סיוע בזמן אמת על ידי שכנים ותושבי שכונה הפעילים בה.
הרשת מרחיבה וגבה את פעולתה של המחלקה לשירותים חברתיים באמצעות רשת פעילים שכונתית ויצירת חיבורים בין התארגנויות ומוסדות בתוך השכונה.

הסכמה:
''',style: TextStyle(color: Colors.grey[800],fontSize: 15),),
                  )),
              Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25.0, left: 25.0, bottom: 15.0),
                    child: Text("1. אני מודע\\ת ומסכים\\מה כי בקשת העזרה שלי מפורסמת בפומבי ומנוהלת על ידי עובדות סוציאליות המתחזקות את האפליקציה המכונה \"רשת חברתית\" ",style: TextStyle(color: Colors.grey[800],fontSize: 15),),
                  )),
              SizedBox(height: 10,),
              Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25.0, left: 25.0, bottom: 15.0),
                    child: Text("2. אני מודע\\ת ומסכים\\מה כי האפליקציה מנטרת את המיקו שלי , המיקום חשוף רק לעובדות הסוציאליות המנווטות את המידע ולצוות ניהול הנתונים הטכניוני ולא לכלל הציבור.",style: TextStyle(color: Colors.grey[800],fontSize: 15),),
                  )),
              SizedBox(height: 10,),
              Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25.0, left: 250.0, bottom: 15.0),
                    child: Text("3. אני מודע\\ת ומסכים\\מה כי תיעוד הבקשות נשמר במחשבי הטכניון התומכים בפלטפורמה במטרה לשפר את רווחת התושבים בשכונת הדר ולתמוך במחקר התומך.",style: TextStyle(color: Colors.grey[800],fontSize: 15),),
                  )),
              SizedBox(height: 40,),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      if(Navigator.canPop(context)){
                        Navigator.pop(context);
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.confirm),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}