

import 'package:flutter/foundation.dart';
import 'dart:async';

class Debouncer{
    final int ? milisecound;
    Timer ? _timer;
  Debouncer(this.milisecound);

  run(VoidCallback action){
    if(_timer!=null){
      _timer!.cancel();
    }
    _timer=Timer(Duration(milliseconds: milisecound!),action);
  }
}