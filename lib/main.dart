import 'package:flutter/material.dart';
import 'package:languages_project/modules/splash/spalsh_screen.dart';
import 'package:languages_project/routes.dart';
import 'package:languages_project/shared_preferences.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  Widget  widget=SplashScreen();
  runApp(MyApp(startWidget: widget,));

}
class MyApp extends StatelessWidget {
  final Widget startWidget;
   MyApp({Key? key, required this.startWidget}) : super(key: key);
  static const primaryColor =  Color(0xFFF17532);

   static const Map<int, Color> color =
   {
     100:const Color(0xFFF17532),
   };

   MaterialColor ? colorCustom =const MaterialColor(0xFFF17532, color);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme:  const AppBarTheme(
          color: primaryColor,
        ),
       primarySwatch:Colors.deepOrange,
      primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme:InputDecorationTheme(

        labelStyle:const TextStyle(color:Color(0xFF757575) ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding:const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide:const BorderSide(color:Color(0xFF757575)),
          gapPadding: 10,
        ),
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide:const BorderSide(color: Color(0xFF757575)),
          gapPadding: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide:const BorderSide(color: Color(0xFF757575)),
          gapPadding: 10,
        ),
      ) ,

      ),
      debugShowCheckedModeBanner: false,
     home:startWidget,
      routes: routes,
    );
  }
}
