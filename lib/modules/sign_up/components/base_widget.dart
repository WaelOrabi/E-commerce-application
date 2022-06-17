import 'package:flutter/material.dart';
import 'package:languages_project/bloc/bloc_sign_up/auth_bloc.dart';
import 'package:languages_project/data/web_services/sign_up_web_services.dart';
class BaseWidget extends InheritedWidget{
  BaseWidget({Key? key, required this.child}) : super(key: key, child: child);
  final formKey = GlobalKey<FormState>();
  bool invisible = true;
  bool remember = false;
  String ? name;
  String ? phone;
  String ? email;
  String ? password;
TextEditingController? nameController=TextEditingController();
TextEditingController ?phoneController=TextEditingController();
TextEditingController ?emailController=TextEditingController();
TextEditingController ?passwordController=TextEditingController();
  AuthBloc ? authBloc=AuthBloc(signUpWepServices:SignUpWepServices());
  final Widget child;
  static BaseWidget? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<BaseWidget>();
  }
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
   return true;
  }

}