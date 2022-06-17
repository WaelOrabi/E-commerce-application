import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages_project/bloc/bloc_sign_in/auth_bloc.dart';
import 'package:languages_project/data/web_services/sign_in_web_services.dart';
import 'package:languages_project/enums.dart';
import 'package:languages_project/modules/login_success/login_success_screen.dart';
import 'package:languages_project/modules/sign_in/components/base_widget.dart';
import 'package:languages_project/modules/sign_up/sign_up_screen.dart';
import 'package:languages_project/shared/components/button.dart';
import 'package:languages_project/shared/components/icon_button.dart';
import 'package:languages_project/shared/components/show_toast.dart';
import 'package:languages_project/shared_preferences.dart';

import '../home/home_screen.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/sign_in";

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  String? email;

  String? password;

  bool? invisible = true;

  bool? remember = false;

  TextEditingController? emailController = TextEditingController();

  TextEditingController? passwordController = TextEditingController();

  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = AuthBloc(
      authService: SignInWebServices(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (BuildContext context) {
        return authBloc;
      },
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            print(state.signInModel.token_type);
            print(state.signInModel.access_token);

            SharedPref.saveData(
                    key: 'token',
                    value: state.signInModel.token_type! +
                        ' ' +
                        state.signInModel.access_token!)
                .then((value) {
              print(
                  "Done save token =${state.signInModel.token_type! + ' ' + state.signInModel.access_token!}");
              print('token_sharedpref=${SharedPref.getData(key: 'token')}');
              Navigator.of(context)
                  .pushReplacementNamed(HomeScreen.routeName);
            });
          }
          if (state is SignInFailedState) {
            showToast(text: state.errorMessage, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
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
                      Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                  //height: 70,
                                  child: buildEmailFormField()),
                              const SizedBox(height: 30),
                              SizedBox(
                                  //height: 70,
                                  child: buildPasswordFormField()),
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  Checkbox(
                                    value: remember,
                                    activeColor: const Color(0xFFFF7643),
                                    checkColor: Colors.white,
                                    onChanged: (value) {
                                      setState(() {
                                        BaseWidget.of(context)!.remember =
                                            value!;
                                      });
                                    },
                                  ),
                                  const Text("Remember me"),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      "Forgot Password",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                if (state is SignInProcessing) {
                                  return const CircularProgressIndicator();
                                }
                                return Button(
                                    press: () {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        authBloc.userLogin(
                                            email: emailController!.text,
                                            password: passwordController!.text);
                                      }
                                    },
                                    text: "SignIn",
                                    backColor: const Color(0xFFFF7643),
                                    isUpperCase: false,
                                    borderRadius: 20);
                              }),
                              // ConditionalBuilder(
                              //   condition: state is! SignInProcessing,
                              //   builder: (context) => Button(
                              //       press: () {
                              //         if (formKey.currentState!.validate()) {
                              //           formKey.currentState!.save();
                              //           print(
                              //               'emailController=${emailController!.text}');
                              //           print(
                              //               'passwordController=${passwordController!.text}');
                              //           authBloc.userLogin(
                              //               email: emailController!.text,
                              //               password: passwordController!.text);
                              //            print('email=${email}');
                              //             print('password=${password}');
                              //           // BaseWidget.of(context)!.authBloc.add(SignInEvent(
                              //           //     PasswordVal: BaseWidget.of(context)!.passwordController.text,
                              //           //     EmailVal: BaseWidget.of(context)!.emailController.text));
                              //           // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                              //         }
                              //       },
                              //       text: "SignIn",
                              //       backColor: const Color(0xFFFF7643),
                              //       isUpperCase: false,
                              //       borderRadius: 20),
                              //   fallback: (context) =>
                              //       CircularProgressIndicator(),
                              // ),
                            ],
                          ),
                        ),
                      ),
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
                          const Text(
                            'Don\'t have an account ?',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Button(
                              width: 100,
                              backColor: Colors.white,
                              elevation: 0,
                              color: const Color(0xFFFF7643),
                              text: 'Sign Up',
                              press: () {
                                Navigator.pushNamed(
                                    context, SignUpScreen.routeName);
                              },
                              isUpperCase: false,
                              fontSize: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      cursorColor: Colors.blue,
      keyboardType: TextInputType.text,
      controller: passwordController,
      obscureText: authBloc.isPassword,
      //This will obscure text dynamically
      onSaved: (newValue) => password = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter password';
        }
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

  bool isPasswordCompliant(String password, [int minLength =6]) {
    if (password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length >= minLength;

    return (hasDigits ||
            hasUppercase ||
            hasLowercase ||
            hasSpecialCharacters) &&
        hasMinLength;
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      onSaved: (newValue) => email = newValue,
      validator: (value) {
        bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(emailController!.text);
        if (!emailValid) {
          return "Please re-enter your email";
        }
        if (value!.isEmpty) {
          return "Please enter your email";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        suffixIcon: Icon(
          Icons.email_outlined, //color: Colors.grey,
        ),
      ),
    );
  }
}
