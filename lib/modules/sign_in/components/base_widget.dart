import 'package:flutter/material.dart';
import 'package:languages_project/bloc/bloc_sign_in/auth_bloc.dart';
import 'package:languages_project/data/web_services/sign_in_web_services.dart';
class BaseWidget extends InheritedWidget{
  BaseWidget({Key? key, required this.child}) : super(key: key, child: child);
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool invisible = true;
  bool remember = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthBloc authBloc = AuthBloc(authService:SignInWebServices(),);
  final Widget child;
  static BaseWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BaseWidget>();
  }
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
   return true;
  }

}