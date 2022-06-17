/*import 'package:flutter/material.dart';
import 'package:languages_project/modules/splash/components/body.dart';
class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
*/
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:languages_project/modules/home/home_screen.dart';
import 'package:languages_project/modules/sign_in/sign_in_screen.dart';
import 'package:languages_project/modules/sign_up/sign_up_screen.dart';

import '../../shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({Key ? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> ? topCircleAnimation;
  Animation<double> ? bottomCircleAnimation;
  Animation<double> ? logoAnimation;
  AnimationController ? controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration:Duration(seconds: 3), vsync: this);
    topCircleAnimation = Tween<double>(begin: 0, end: 200).animate(controller!)
      ..addListener(() {
        setState(() {

        });
      });

    bottomCircleAnimation =
    Tween<double>(begin: 0, end: 350).animate(controller!)
      ..addListener(() {
        setState(() {

        });
      });

    logoAnimation = Tween<double>(begin: 0, end: 1).animate(controller!)
      ..addListener(() {
        setState(() {

        });
      });
    controller!.forward();

    Timer(Duration(seconds:5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) =>SharedPref.getData(key:'token')==null? SignInScreen():HomeScreen(getAllProductsModel: []),),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Opacity(
                opacity: logoAnimation!.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/img.png',fit: BoxFit.fitHeight,),
                    SizedBox(height: 20),
                    // Text('Market', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w600),),
                    // Text('Hello evryone', style: const TextStyle(letterSpacing: 3),),
                  ],
                ),
              ),
            ),
          )
          ,
          Positioned(
            top: -30,
            right: -100,
            child: Container(
              height: topCircleAnimation!.value,
              width: topCircleAnimation!.value,
              decoration:const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.orangeAccent,
                    //Theme.of(context).accentColor,
                    Colors.red,
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -150,
            child: Container(
              height: bottomCircleAnimation!.value,
              width: bottomCircleAnimation!.value,
              decoration:const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.orangeAccent,
                    //Theme.of(context).accentColor,
                    Colors.red,
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),

        ],
      ),
    );
  }
}