import 'package:flutter/material.dart';
import 'package:languages_project/modules/add_product/add_product_screen.dart';
import 'package:languages_project/modules/add_category/add_category.dart';
import 'package:languages_project/modules/home/home_screen.dart';
import 'package:languages_project/modules/profile/profile_screen.dart';
import 'package:languages_project/modules/sign_in/sign_in_screen.dart';
import 'package:languages_project/modules/sign_up/sign_up_screen.dart';
import 'package:languages_project/shared/components/comment.dart';

import 'modules/all_categories/components/search_category.dart';
import 'modules/all_categories/all_categories_screen.dart';
import 'modules/login_success/login_success_screen.dart';
import 'modules/splash/spalsh_screen.dart';

final Map<String,WidgetBuilder> routes={
  AddCategory.routeName:(context)=>const AddCategory(),
  SplashScreen.routeName :(context)=> const SplashScreen(),
  SignInScreen.routeName :(context)=>const SignInScreen(),
  SignUpScreen.routeName :(context)=>const SignUpScreen(),
  AllCategories.routeName:(context)=>const AllCategories(getAllCategories: [],),
  HomeScreen.routeName:(context)=>const HomeScreen(getAllProductsModel: [],),
  LoginSuccessScreen.routeName :(context)=>const LoginSuccessScreen(),
  AddProductScreen.routeName:(context)=>const AddProductScreen(),
 ProfileScreen.routeName:(context)=>const ProfileScreen(),
  Search.routeName:(context)=>const ProfileScreen(),
  CommentScreen.routeName:(context)=>const CommentScreen(),
  AddCategory.routeName:(context)=>const AddCategory(),
};