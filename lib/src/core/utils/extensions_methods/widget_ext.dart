import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension FromStringExt on String {
  void toastAlert({String? message, bool success = false}) {
    Fluttertoast.showToast(
      msg: message ?? this,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      // timeInSecForIosWeb: 1,
      backgroundColor: success ? Colors.green : Colors.red.withOpacity(.7),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
