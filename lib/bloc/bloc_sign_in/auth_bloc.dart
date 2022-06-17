
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages_project/data/models/sign_in.dart';
import 'package:languages_project/data/web_services/sign_in_web_services.dart';
import 'package:languages_project/end_points.dart';
import 'package:meta/meta.dart';


part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  SignInWebServices authService;
  late SignIn signInModel;
  static String  error_state="";
  AuthBloc({required this.authService}) : super(SignInitial());

  //static AuthBloc get(context) => BlocProvider.of(context);

 void userLogin({required String email, required String password}) {
     emit(SignInProcessing());
    SignInWebServices.postData(url:signIn,data: {
      'email': email,
      'password': password,
    }).then((value) {
      print("result = ${value.data}");
      signInModel=SignIn.fromJson(value.data);
      if(signInModel.dataUser!=null)
      print('signInModel_dataUser_id=${signInModel.dataUser!.id}');


      emit(SignInSuccess(signInModel));

    }).catchError((error){
        if(error.toString().contains('401')) {
          error_state="error email or password";
          print("error_state=${error_state}");
          emit(SignInFailedState(errorMessage:error_state));
        }
    });
  }
  IconData icon=Icons.visibility_outlined;
 bool isPassword=true;
 void changePasswordVisibility(){
   isPassword=!isPassword;
   icon=isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
   emit(SignInChangePasswordVisibilityState());
 }
}
