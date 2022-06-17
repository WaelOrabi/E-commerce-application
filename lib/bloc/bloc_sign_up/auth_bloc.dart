import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages_project/data/models/sign_up.dart';
import 'package:languages_project/data/web_services/sign_up_web_services.dart';
import 'package:languages_project/end_points.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  SignUpWepServices signUpWepServices;
  var sign_up_status = false;
  late SignUp signUpModel;
  static String  error_state="";
  AuthBloc({required this.signUpWepServices}) : super(AuthInitial());

 // AuthBloc get(context) => BlocProvider.of(context);

  void userLogin(
      {var name,
      var password,
      var email,
      var password_confirmation,
      var phone_number}) {
    emit(SignUpProcessing());
    SignUpWepServices.postData(url:'/', data: {
      'name': name,
      'password': password,
      'email': email,
      'password_confirmation': password_confirmation,
      'phone_number': phone_number,
    }).then((value) {
      print("result = ${value.data}");
      signUpModel=SignUp.fromJson(value.data);
      if(signUpModel.dataUser!=null) {
        print('signInModel_dataUser_id=${signUpModel.dataUser!.id}');
      }
      emit(SignUpSuccessed(signUpModel));
    }).catchError((error){
      if(error.toString().contains('422') && password!=password_confirmation) {
        error_state="The password confirmation does not match.";
        print("error_state=${error_state}");
        emit(SignUpFaildState(errorMessage:error_state));
      } else if(error.toString().contains('422') ) {
        error_state='The given data was invalid.\nThe email has already been taken.';
        print("error_state=${error_state}");
        emit(SignUpFaildState(errorMessage:error_state));
      }

    });
  }
  IconData icon=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    icon=isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SignUpChangePasswordVisibilityState());
  }
}
