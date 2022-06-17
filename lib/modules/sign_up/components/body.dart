
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:languages_project/modules/sign_up/components/sign_up_form.dart';
import 'package:languages_project/shared/components/button.dart';
import 'package:languages_project/shared/components/icon_button.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: double.infinity,
      padding:const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
           const SizedBox(height: 90,),
            const Text(
              "Register Account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.black,
                height: 1.5,
              ),
            ),
            const Text(
              'Enter your details for register account',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF757575),
              ),
            ),
            const SizedBox(
              height: 50,
            ),

          SignUpForm(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon_Button(
                  icon: "assets/icons/google.svg",
                  press: () {},
                ),
                Icon_Button(
                  icon: "assets/icons/facebook.svg",
                  press: () {},
                ),
                Icon_Button(
                  icon: "assets/icons/twitter.svg",
                  press: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'By continuing your confirm that you agree \nwith our Condition',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    ));
  }
}
