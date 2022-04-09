
import 'package:flutter/cupertino.dart';

class DummyWidget{
  static Widget _dummy = Center(child: Text('loading..'),);
  static Widget get(){
    return _dummy;
  }
}