import 'package:string_validator/string_validator.dart';


class Validators{

  static String ValidateName(String value){
    if(value.isEmpty){
      return 'השם לא יכול להיות ריק';
    }
    if (value.length > 60){
      return 'השם שלך ארוך מדי';
    }
    else{
      return null;
    }
  }


  static String ValidateEmail(String value){
    if(value.isEmpty){
      return 'האימייל לא יכול להיות ריק';
    }
    if(!isEmail(value)){
      return 'האימייל לא חוקי';
    }
    else{
      return null;
    }
  }

  static String ValidatePhone(String value){
    if(value.isEmpty){
      return 'מספר טלפון לא יכול להיות ריק';
    }
    if(value.length != 10 ){
      return'מספר טלפון אינו חוקי';
    }
    if(!isNumeric(value)){
      return'מספר טלפון אינו חוקי';
    }
    else{
      return null;
    }
  }

  static String ValidateLocation(String value){
    if(value.isEmpty){
      return 'מיקום לא יכול להיות ריק';
    }
    if (value.length > 60){
      return 'המיקום שלך ארוך מדי';
    }
    else{
      return null;
    }
  }
}




// class second_pw_Validator{
//
//   static String First_pw;
//   static String Validate(String value){
//     if(First_pw != value){
//       return 'הסיסמה לא תואמת';
//     }else{
//       return null;
//     }
//   }
//
// }



