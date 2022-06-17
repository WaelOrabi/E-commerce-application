// import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages_project/bloc/bloc_sign_up/auth_bloc.dart';
import 'package:languages_project/data/web_services/sign_up_web_services.dart';
import 'package:languages_project/enums.dart';
import 'package:languages_project/modules/login_success/login_success_screen.dart';
import 'package:languages_project/shared/components/button.dart';
import 'package:languages_project/shared/components/icon_button.dart';
import 'package:languages_project/shared/components/show_toast.dart';
import 'package:languages_project/shared_preferences.dart';

import '../home/home_screen.dart';
import 'components/body.dart';
class SignUpScreen extends StatefulWidget {
  static String routeName = "/sign_up";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool invisible = true;
  bool remember = false;
  String ? name;
  String ? phone;
  String ? email;
  String ? password;
  String ? passwordConfirmaton;
  final formKey = GlobalKey<FormState>();
  TextEditingController? nameController=TextEditingController();
  TextEditingController ?phoneController=TextEditingController();
  TextEditingController ?emailController=TextEditingController();
  TextEditingController ?passwordController=TextEditingController();
  TextEditingController ?passwordConfirmationController=TextEditingController();
  late AuthBloc authBloc;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
   authBloc=AuthBloc(signUpWepServices:SignUpWepServices());
  }
  @override
  Widget build(BuildContext context) {
    String routeName="/sign_up";
    return BlocProvider<AuthBloc>(
          create:(context){
          return authBloc;
          },
      child:  BlocConsumer<AuthBloc,AuthState>(
        listener: (context,state){
          if (state is SignUpSuccessed) {
            print(state.signUpModel.token_type);
            print(state.signUpModel.access_token);

            SharedPref.saveData(
                key: 'token',
                value: state.signUpModel.token_type! +
                    ' ' +
                    state.signUpModel.access_token!).then((value) {
              SharedPref.saveData(key:'name_user', value:name);
              SharedPref.saveData(key:'email_user', value:email);
              print('ttozzzzzzzzzzzz${SharedPref.getData(key:'name_user')}');
              print('ttozzzzzzzzzzzz${SharedPref.getData(key:'email_user')}');

              Navigator.of(context)
                  .pushReplacementNamed(HomeScreen.routeName);
            });

          }
          if (state is SignUpFaildState) {
            showToast(text: state.errorMessage, state: ToastStates.ERROR);
          }
        },
        builder:(context,state){
        return Scaffold(
               body: SafeArea(
                   child: Container(
                     width: double.infinity,
                     padding:const EdgeInsets.symmetric(horizontal: 20),
                     child: SingleChildScrollView(
                       child: Column(
                         children: [
                           const SizedBox(height: 50,),
                           const Text(
                             "Register Account",
                             style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 35,
                               color: Colors.black,
                               height: 1.5,
                             ),
                           ),
                           // const Text(
                           //   'Enter your details for register account',
                           //   textAlign: TextAlign.center,
                           //   style: TextStyle(
                           //     color: Color(0xFF757575),
                           //   ),
                           // ),
                           const SizedBox(
                             height: 50,
                           ),
                           // BlocConsumer<AuthBloc,AuthState>(
                           //  listener: (context,state){
                           // if(state is SignUpSuccessed)
                           //   Get.offAllNamed('/login_success');
                           // else if(state is SignUpFaildState)
                           //   Get.snackbar('error message', state.errorMessage);
                           //  },
                           //     builder: (context,state){
                           //    if(state is AuthInitial) {
                           //     return SignUpForm();
                           //   } else if(state is SignUpProcessing) {
                           //     return CircularProgressIndicator();
                           //   } else if (state is SignUpFaildState) {
                           //      return SignUpForm();
                           //    } else {
                           //      return Image.asset('assets/appbar.jpg');
                           //    }
                           //     }),
                         Form(
                             key:formKey,
                             child: Column(
                               children: [
                                 buildNameFormField(),
                                 const SizedBox(height: 30),
                                 buildPhoneFormField(),
                                 const SizedBox(height: 30),
                                 buildEmailFormField(),
                                 const SizedBox(height: 30),
                                 buildPasswordFormField(),
                                 const SizedBox(height: 30),
                                 buildpassword_confirmationFormField(),
                                 const SizedBox(height: 40),
                                 BlocBuilder<AuthBloc, AuthState>(builder: (context, state){
                                   if(state is SignUpProcessing) {
                                     return const CircularProgressIndicator();
                                   }
                                   return Button(
                                       press: () {
                                         if (formKey.currentState!.validate()) {
                                           formKey.currentState!.save();
                                           authBloc.userLogin(
                                               password_confirmation: passwordConfirmationController!
                                                   .text,
                                               name: nameController!
                                                   .text,
                                               phone_number: phoneController!
                                                   .text,
                                               email:emailController!
                                                   .text,
                                               password: passwordController!
                                                   .text);
                                         }
                                       },
                                       text: "Continue",
                                       backColor: const Color(0xFFFF7643),
                                       isUpperCase: false,
                                       borderRadius: 20);
                                 }),
                               ],
                             ),
                           ),
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
                   )),
            );},

      ),
      );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller:nameController,
      onSaved: (newValue) => name = newValue,
      validator: (value) {
        print(name);
        if (value!.isEmpty) {
          return "Please Enter your Name";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Name",
        hintText: "Enter your Name",
        suffixIcon: Icon(
          Icons.person_add_alt, //color: Colors.grey,
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      cursorColor: Colors.blue,
      keyboardType: TextInputType.text,
      controller:passwordController ,
      obscureText :authBloc.isPassword,//This will obscure text dynamically
      onSaved: (newValue) =>password = newValue,
      validator: (value) {
        if(value!.isEmpty)
          return 'Please enter password';
        if (!isPasswordCompliant(passwordController!.text)) {
          return 'Please re-enter password';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        // Here is key idea
        suffixIcon: IconButton(
          icon: Icon(
        authBloc.icon,
            //color: Colors.grey
          ),
          onPressed: () {
           authBloc.changePasswordVisibility();
          },
        ),
      ),
    );
  }
  TextFormField buildpassword_confirmationFormField() {
    return TextFormField(
      cursorColor: Colors.blue,
      keyboardType: TextInputType.text,
      controller:passwordConfirmationController ,
      obscureText :authBloc.isPassword,//This will obscure text dynamically
      onSaved: (newValue) =>passwordConfirmaton = newValue,
      validator: (value) {
        if(value!.isEmpty)
          return 'Please enter password confirmaton';
        if (!isPasswordCompliant(passwordController!.text)) {
          return 'Please re-enter password confirmaton';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Password Confirmaton',
        hintText: 'Enter your password confirmation',
        // Here is key idea
        suffixIcon: IconButton(
          icon: Icon(
            authBloc.icon,
            //color: Colors.grey
          ),
          onPressed: () {
            authBloc.changePasswordVisibility();
          },
        ),
      ),
    );
  }

  bool isPasswordCompliant(String password, [int minLength =8]) {
    if (password == null || password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > minLength;

    return (hasDigits || hasUppercase || hasLowercase || hasSpecialCharacters) && hasMinLength;
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      onSaved: (newValue) => email = newValue,
      validator: (value) {
        bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController!.text);
        if (!emailValid) {
          return "Please re-enter your email";
        }
        if(value!.isEmpty)
          return "Please enter your email";
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        suffixIcon:Icon(Icons.email_outlined,//color: Colors.grey,
        ),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      controller:phoneController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phone = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter your phone";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone",
        hintText: "Enter your phone",
        suffixIcon: Icon(
          Icons.phone, //color: Colors.grey,
        ),
      ),
    );
  }
}
