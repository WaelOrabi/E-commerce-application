import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

Widget Icon_Button({required String  icon ,required Function press}){
return GestureDetector(
onTap: press as void Function(),
  child: Container(
    margin:const EdgeInsets.symmetric(horizontal: 10),
    padding:const EdgeInsets.all(12),
    height: 40,
    width:40,
    decoration: const BoxDecoration(
      color: Color(0xFFF5F6F9),
      shape: BoxShape.circle,
    ),
    child: SvgPicture.asset(icon),
  ),
);
}