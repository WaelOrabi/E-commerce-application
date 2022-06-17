import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:languages_project/modules/sign_in/components/base_widget.dart';
import 'package:languages_project/modules/sign_in/components/sign_in_form.dart';
import 'package:languages_project/modules/sign_up/sign_up_screen.dart';
import 'package:languages_project/shared/components/button.dart';
import 'package:languages_project/shared/components/icon_button.dart';


class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child:SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 90,
                  ),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Sign in with your email and password  \nor continue with social media",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF757575),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  // BlocConsumer<AuthBloc,AuthState>(listener:(context,state){
                  //   if(state is SignInSuccessed)
                  //   {
                  //     Get.offAllNamed('/login_success');
                  //   }else if(state is SignInFaildState)
                  //   {
                  //     Get.snackbar('error message', state.errorMessage);
                  //   }
                  //
                  // },
                  // builder: (context,state){
                  //   if(state is AuthInitial)
                  //     return  SignInForm();
                  //   else if (state is SignInProcessing) {
                  //     return CircularProgressIndicator();
                  //   } else if (state is SignInFaildState) {
                  //     return SignInForm();
                  //   } else {
                  //     return Image.asset('assets/appbar.jpg');
                  //   }
                  // },),
              SignInForm(),
                  const SizedBox(
                    height: 70,
                  ),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account ?',style: TextStyle(
                        fontSize: 16,
                      ),),
                      Button(width: 100,backColor: Colors.white,elevation: 0,color:const Color(0xFFFF7643),text: 'Sign Up',press: (){ Navigator.pushNamed(context,SignUpScreen.routeName);},isUpperCase: false,fontSize: 16 ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
