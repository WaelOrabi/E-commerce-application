// import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages_project/bloc/bloc_sign_up/auth_bloc.dart';
import 'package:languages_project/modules/login_success/login_success_screen.dart';
import 'package:languages_project/modules/sign_up/components/base_widget.dart';
import 'package:languages_project/shared/components/button.dart';
import 'package:languages_project/shared/components/icon_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(builder:(context,state){
      return Form(
        key: BaseWidget.of(context)!.formKey,
        child: Column(
          children: [
            buildNameFormField(),
            const SizedBox(height: 30),
            buildPhoneFormField(),
            const SizedBox(height: 30),
            buildEmailFormField(),
            const SizedBox(height: 30),
            buildPasswordFormField(),
            const SizedBox(height: 40),
            BlocBuilder<AuthBloc, AuthState>(builder: (context, state){
              if(state is SignUpProcessing) {
                return const CircularProgressIndicator();
              }
              return Button(
                  press: () {
                    if (BaseWidget.of(context)!.formKey.currentState!.validate()) {
                      BaseWidget.of(context)!.authBloc!.userLogin(
                          password_confirmation: BaseWidget
                              .of(context)!
                              .passwordController!
                              .text,
                          name: BaseWidget
                              .of(context)!
                              .nameController!
                              .text,
                          phone_number: BaseWidget
                              .of(context)!
                              .phoneController!
                              .text,
                          email: BaseWidget
                              .of(context)!
                              .emailController!
                              .text,
                          password: BaseWidget
                              .of(context)!
                              .passwordController!
                              .text);
                    }
                    //   BaseWidget.of(context)!.authBloc.add(
                    //       SignUpEvent(password_confirmation: BaseWidget
                    //           .of(context)!
                    //           .passwordController
                    //           .text,
                    //           name: BaseWidget
                    //               .of(context)!
                    //               .nameController
                    //               .text,
                    //           phone_number: BaseWidget
                    //               .of(context)!
                    //               .phoneController
                    //               .text,
                    //           email: BaseWidget
                    //               .of(context)!
                    //               .emailController
                    //               .text,
                    //           password: BaseWidget
                    //               .of(context)!
                    //               .passwordController
                    //               .text));
                    // }
                    // if (BaseWidget.of(context)!.formKey.currentState!.validate()) {
                    //   BaseWidget.of(context)!.formKey.currentState!.save();
                    //   print('name=${BaseWidget.of(context)!.name}');
                    //   print('phone=${BaseWidget.of(context)!.phone}');
                    //   print('email=${BaseWidget.of(context)!.email}');
                    //   print('password=${BaseWidget.of(context)!.password}');
                    //   BaseWidget.of(context)!.authBloc.add(  SignUpEvent(
                    //       name: BaseWidget.of(context)!.nameController.text,
                    //       phone_number: BaseWidget.of(context)!.phoneController.text,
                    //       email: BaseWidget.of(context)!.emailController.text,
                    //       password: BaseWidget.of(context)!.passwordController.text, password_confirmation:BaseWidget.of(context)!.passwordController.text));
                    //   Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                    // }
                  },
                  text: "Continue",
                  backColor: const Color(0xFFFF7643),
                  isUpperCase: false,
                  borderRadius: 20);
            }),

            // ConditionalBuilder(
            //   condition:state is! SignUpProcessing ,
            //   builder: (context){
            //     return ConditionalBuilder(
            //       condition:state is! SignUpProcessing,
            //       builder: (context)=>Button(
            //           press: () {
            //             if (BaseWidget.of(context)!.formKey.currentState!.validate()) {
            //               BaseWidget.of(context)!.authBloc!.userLogin(
            //                   password_confirmation: BaseWidget
            //                       .of(context)!
            //                       .passwordController!
            //                       .text,
            //                   name: BaseWidget
            //                       .of(context)!
            //                       .nameController!
            //                       .text,
            //                   phone_number: BaseWidget
            //                       .of(context)!
            //                       .phoneController!
            //                       .text,
            //                   email: BaseWidget
            //                       .of(context)!
            //                       .emailController!
            //                       .text,
            //                   password: BaseWidget
            //                       .of(context)!
            //                       .passwordController!
            //                       .text);
            //             }
            //             //   BaseWidget.of(context)!.authBloc.add(
            //             //       SignUpEvent(password_confirmation: BaseWidget
            //             //           .of(context)!
            //             //           .passwordController
            //             //           .text,
            //             //           name: BaseWidget
            //             //               .of(context)!
            //             //               .nameController
            //             //               .text,
            //             //           phone_number: BaseWidget
            //             //               .of(context)!
            //             //               .phoneController
            //             //               .text,
            //             //           email: BaseWidget
            //             //               .of(context)!
            //             //               .emailController
            //             //               .text,
            //             //           password: BaseWidget
            //             //               .of(context)!
            //             //               .passwordController
            //             //               .text));
            //             // }
            //             // if (BaseWidget.of(context)!.formKey.currentState!.validate()) {
            //             //   BaseWidget.of(context)!.formKey.currentState!.save();
            //             //   print('name=${BaseWidget.of(context)!.name}');
            //             //   print('phone=${BaseWidget.of(context)!.phone}');
            //             //   print('email=${BaseWidget.of(context)!.email}');
            //             //   print('password=${BaseWidget.of(context)!.password}');
            //             //   BaseWidget.of(context)!.authBloc.add(  SignUpEvent(
            //             //       name: BaseWidget.of(context)!.nameController.text,
            //             //       phone_number: BaseWidget.of(context)!.phoneController.text,
            //             //       email: BaseWidget.of(context)!.emailController.text,
            //             //       password: BaseWidget.of(context)!.passwordController.text, password_confirmation:BaseWidget.of(context)!.passwordController.text));
            //             //   Navigator.pushNamed(context, LoginSuccessScreen.routeName);
            //             // }
            //           },
            //           text: "Continue",
            //           backColor: const Color(0xFFFF7643),
            //           isUpperCase: false,
            //           borderRadius: 20),
            //       fallback: (context)=>CircularProgressIndicator(),
            //     );
            //   },
            //   fallback: (context)=>CircularProgressIndicator(),
            // ),
          ],
        ),
      );
    }, listener: (context,state){

    });
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: BaseWidget.of(context)!.nameController,
      onSaved: (newValue) => BaseWidget.of(context)!.name = newValue,
      validator: (value) {
        print(BaseWidget.of(context)!.name);
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
      controller:BaseWidget.of(context)!.passwordController ,
      obscureText :BaseWidget.of(context)!.invisible == true ? true : false,//This will obscure text dynamically
      onSaved: (newValue) => BaseWidget.of(context)!.password = newValue,
      validator: (value) {
        if(value!.isEmpty)
          return 'Please enter password';
        if (!isPasswordCompliant(BaseWidget.of(context)!.passwordController!.text)) {
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
            BaseWidget.of(context)!.invisible == true ? Icons.visibility : Icons.visibility_off,
            //color: Colors.grey
          ),
          onPressed: () {
            setState(() {
              BaseWidget.of(context)!.invisible = !BaseWidget.of(context)!.invisible;
            });
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
      controller: BaseWidget.of(context)!.emailController,
      onSaved: (newValue) => BaseWidget.of(context)!.email = newValue,
      validator: (value) {
        bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(BaseWidget.of(context)!.emailController!.text);
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
      controller: BaseWidget.of(context)!.phoneController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => BaseWidget.of(context)!.phone = newValue,
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
