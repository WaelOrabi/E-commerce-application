import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:languages_project/enums.dart';
void showToast({required String  text,required ToastStates state})=>  Fluttertoast.showToast(
    msg:text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,

    backgroundColor:chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
Color chooseToastColor(ToastStates state)
{
  switch(state)
  {
    case ToastStates.SUCCESS:return Colors.green;break;
    case ToastStates.ERROR:return Colors.red;break;
    case ToastStates.WARNING:return Colors.yellow;break;
  }
}