// import 'package:conditional_builder/conditional_builder.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languages_project/bloc/bloc_sign_up/auth_bloc.dart';
import 'package:languages_project/bloc/update_information_user/update_information_user_bloc.dart';
import 'package:languages_project/data/web_services/sign_up_web_services.dart';
import 'package:languages_project/data/web_services/update_information_user_web_services.dart';
import 'package:languages_project/enums.dart';
import 'package:languages_project/modules/login_success/login_success_screen.dart';
import 'package:languages_project/shared/components/button.dart';
import 'package:languages_project/shared/components/icon_button.dart';
import 'package:languages_project/shared/components/show_toast.dart';
import 'package:languages_project/shared_preferences.dart';
class UpdateMyInformationScreen extends StatefulWidget {
  static String routeName = "/sign_up";
  final File ? image;
  const UpdateMyInformationScreen({Key? key,  this.image}) : super(key: key);

  @override
  State<UpdateMyInformationScreen> createState() => _UpdateMyInformationScreenState(this.image);
}

class _UpdateMyInformationScreenState extends State<UpdateMyInformationScreen> {
  final File ? image;
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
  TextEditingController ?whatsapp_urlController=TextEditingController();
  TextEditingController ?facebook_urlController=TextEditingController();
 late UpdateInformationUserBloc updateInformationUserBloc;

  _UpdateMyInformationScreenState(this.image);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateInformationUserBloc=UpdateInformationUserBloc(updateInformationUserWebServices: UpdateInformationUserWebServices());
  }
  @override
  Widget build(BuildContext context) {
    String routeName="/sign_up";
    return BlocProvider<UpdateInformationUserBloc>(
      create:(context){
        return updateInformationUserBloc;
      },
      child:  BlocConsumer<UpdateInformationUserBloc,UpdateInformationUserState>(
        listener: (context,state){
          if (state is UpdateInformationUserSuccess) {

          }
          if (state is UpdateInformationUserFailedState) {
            showToast(text: state.errorMessage, state: ToastStates.ERROR);
          }
        },
        builder:(context,state){
          return Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8,top: 15),
                        child: IconButton(icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.grey,),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding:const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 50,),

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
                                    buildFacebookUrlFormField(),
                                    const SizedBox(height: 30),
                                    buildWhatsappUrlFormField(),

                                    const SizedBox(height: 40),
                                    BlocBuilder<UpdateInformationUserBloc, UpdateInformationUserState>(builder: (context, state){
                                      if(state is UpdateInformationUserProcessing) {
                                        return const CircularProgressIndicator();
                                      }
                                      return Button(
                                          press: () {
                                            updateInformationUserBloc.updatInformationUser(
                                              name: nameController!.text.isEmpty? null:nameController!.text,
                                              email: emailController!.text.isEmpty?null: emailController!.text,
                                              password: passwordController!.text.isEmpty?null: passwordController!.text,
                                              image:image,
                                              phone_number: phoneController!.text.isEmpty?null:phoneController!.text,
                                              whatsapp_url: whatsapp_urlController!.text.isEmpty?null:whatsapp_urlController!.text,
                                              facebook_url: facebook_urlController!.text.isEmpty?null:facebook_urlController!.text,
                                            );
                                          },
                                          text: "Update",
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
                            ],
                          ),
                        ),
                      ),
                    ],
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
  TextFormField buildWhatsappUrlFormField() {
    return TextFormField(
      keyboardType: TextInputType.url,
      controller:whatsapp_urlController,
      validator: (value) {
        bool _validURL = Uri.parse(whatsapp_urlController!.text).isAbsolute;
        if (_validURL==false) {
          return "Please re-enter whatsapp url";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Whatsapp Url",
        hintText: "Enter your Whatsapp Url",
        suffixIcon: Icon(
          Icons.link_outlined, //color: Colors.grey,
        ),
      ),
    );
  }
  TextFormField buildFacebookUrlFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller:facebook_urlController,
      validator: (value) {
        bool _validURL = Uri.parse(facebook_urlController!.text).isAbsolute;
        if (_validURL==false) {
          return "Please re-enter facebook url";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Facebook Url",
        hintText: "Enter your Facebook Url",
        suffixIcon: Icon(
           Icons.link_outlined, //color: Colors.grey,
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      cursorColor: Colors.blue,
      keyboardType: TextInputType.text,
      controller:passwordController ,
      obscureText :updateInformationUserBloc.isPassword,//This will obscure text dynamically
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
           updateInformationUserBloc.icon,
            //color: Colors.grey
          ),
          onPressed: () {
            updateInformationUserBloc.changePasswordVisibility();
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
