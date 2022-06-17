import 'package:flutter/material.dart';
class SplashContent extends StatelessWidget {
  final   text;
  final  path;

  const SplashContent({Key? key, required this.text, required this.path}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        const Text(
          "Welcome",
          style: TextStyle(
            fontSize:36,
            color: Color(0xFFFF7643),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        Image.asset(
          path,
          height:265, //getProportionateScreenHeight(265),
          width: 235,//getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
