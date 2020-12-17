import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class Email_Validator{

  static String Validate(String value){
    if(value.isEmpty){
      return 'האימיל לא יכול להיות ריק';
    }
    if(!isEmail(value)){
      return 'האימיל לא חוקי';
    }
    else{
      return null;
    }
  }

}

class password_Validator{

  // ignore: non_constant_identifier_names
  static String Validate(String value){
    if(value.isEmpty){
      return 'הסיסמה לא יכולה להיות ריקה';
    }
    else{
      return null;
    }
  }

}

class Id_Validator{

  static String Validate(String value){
    if(value.isEmpty){
      return 'תעודת זהות לא יכול להיות ריק';
    }
    if(value.length != 9){
      return 'תעודת זהות לא חוקית';
    }
    if(!isNumeric(value)){
      return 'תעודת זהות לא חוקית';
    }
      return null;

  }

}

class name_Validator{

  static String Validate(String value){
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

}

class number_Validator{

  static String Validate(String value){
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

}

class second_pw_Validator{

  static String First_pw;
  static String Validate(String value){
    if(First_pw != value){
      return 'הסיסמה לא תואמת';
    }else{
      return null;
    }
  }

}