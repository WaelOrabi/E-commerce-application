import 'package:flutter/material.dart';
import 'package:languages_project/bloc/bloc_sign_in/auth_bloc.dart';
import 'package:languages_project/modules/all_categories/all_categories_screen.dart';
import 'package:languages_project/modules/login_success/login_success_screen.dart';
import 'package:languages_project/modules/sign_in/components/base_widget.dart';
import 'package:languages_project/modules/sign_up/sign_up_screen.dart';
import 'package:languages_project/shared/components/button.dart';
import 'package:languages_project/shared/components/icon_button.dart';

class SignInForm extends StatefulWidget {

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: BaseWidget.of(context)!.formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(//height: 70,
                child: buildEmailFormField()),
            const SizedBox(height: 30),
            SizedBox(//height: 70,
                child: buildPasswordFormField()),
            const SizedBox(height: 30),
            Row(
              children: [
                Checkbox(
                  value: BaseWidget.of(context)!.remember,
                  activeColor:const  Color(0xFFFF7643),
                  checkColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      BaseWidget.of(context)!.remember = value!;
                    });
                  },
                ),
               const Text("Remember me"),
               const Spacer(),
                GestureDetector(
                  onTap: (){},
                  child:const Text(
                    "Forgot Password",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Button(
                press: () {
                  if (BaseWidget.of(context)!.formKey.currentState!.validate()) {
                    BaseWidget.of(context)!.formKey.currentState!.save();
                    print('BaseWidget.of(context)!.emailController=${BaseWidget.of(context)!.emailController.text}');
                    print('BaseWidget.of(context)!.passwordController=${BaseWidget.of(context)!.passwordController.text}');
                    print('email=${BaseWidget.of(context)!.email}');
                    print('password=${BaseWidget.of(context)!.password}');
                    BaseWidget.of(context)!.authBloc.add(SignInEvent(
                        PasswordVal: BaseWidget.of(context)!.passwordController.text,
                        EmailVal: BaseWidget.of(context)!.emailController.text));
                    Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                  }
                },
                text: "Continue",
                backColor: const Color(0xFFFF7643),
                isUpperCase: false,
                borderRadius: 20),
          ],
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
        if (!isPasswordCompliant(BaseWidget.of(context)!.passwordController.text)) {
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
        bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(BaseWidget.of(context)!.emailController.text);
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
}
