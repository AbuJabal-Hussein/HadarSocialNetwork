import 'package:flutter/material.dart';

class Custom_Text_feild extends StatefulWidget {
  Icon icon;
  String hint;
  Color border_color;
  Color on_tap_color;
  var Validtor;
  var Controller;
  Custom_Text_feild(this.hint,this.icon,this.border_color,this.on_tap_color,this.Validtor,this.Controller);
  @override
  _Custom_Text_feildState createState() => _Custom_Text_feildState(hint,icon,border_color,on_tap_color,Validtor,Controller);
}

class _Custom_Text_feildState extends State<Custom_Text_feild> {

  Icon icon;
  String hint;
  Color border_color;
  Color on_tap_color;
  var Validtor;
  var Controller;
  _Custom_Text_feildState(this.hint,this.icon,this.border_color,this.on_tap_color,this.Validtor,this.Controller);


  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: TextFormField(
        controller: Controller,
        validator: Validtor,
        textAlign:TextAlign.right,
        decoration: InputDecoration(
//          enabledBorder: OutlineInputBorder(
//            borderRadius: BorderRadius.circular(30),
//            borderSide: BorderSide(color: border_color),
//          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: on_tap_color),
          ),
          suffixIcon: icon,
          hintText: hint,
        ),
      ),
    );
  }

}