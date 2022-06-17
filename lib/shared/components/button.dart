import 'package:flutter/material.dart';

Widget Button( {
  double width = double.infinity,
  double height = 50,
  double borderRadius = 0.0,
  double elevation=2,
  Color color = Colors.white,
  Color backColor = Colors.blue,
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.normal,
  bool isUpperCase = true,
  required Function press,
  required String text,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius), color: backColor),
    child: MaterialButton(
      elevation: elevation,
      onPressed: press as void Function(),
      textColor: color,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    ),
  );
}
