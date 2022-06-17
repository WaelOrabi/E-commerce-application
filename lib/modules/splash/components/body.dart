import 'package:flutter/material.dart';
import 'package:languages_project/modules/sign_in/sign_in_screen.dart';
import 'package:languages_project/modules/splash/components/splash_content.dart';
import 'package:languages_project/shared/components/button.dart';
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Tokoto, Let’s shop!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
      "We help people conect with store \nSyria",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at all_categories with us",
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Container(
          margin: EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                    itemCount: splashData.length,
                    onPageChanged: (index){
              setState(() {
                currentPage=index;
              });
                    },
                    itemBuilder:(context,index)=>SplashContent(
                      text: splashData[index]['text'] ,
                      path: splashData[index]["image"] ,
                    )),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                  Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    splashData.length,
                        (index) => buildAnimationContainer(index: index),
                  ),
                ),
                    Spacer(flex: 3),
                    Button(
                      text: "Continue",
                      borderRadius: 20,
                      backColor:  Color(0xFFFF7643),
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
  AnimatedContainer buildAnimationContainer({int ?index})
  {
    return AnimatedContainer(
      duration:Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Color(0xFFFF7643) : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
