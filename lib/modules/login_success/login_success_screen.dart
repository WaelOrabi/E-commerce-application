import 'package:flutter/material.dart';
import 'package:languages_project/modules/login_success/body.dart';
class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";
  const LoginSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );

  }
}
