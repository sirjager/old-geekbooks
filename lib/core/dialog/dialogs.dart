import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Kui {
  void toast(BuildContext context, String msg,
      {Color? backgroundColor, Color? textColor, double? fontSize}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: backgroundColor ?? Colors.black,
      textColor: textColor ?? Colors.white,
      fontSize: fontSize ?? 16.0,
    );
  }
}
