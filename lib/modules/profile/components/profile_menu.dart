import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? press;

  const ProfileMenu(
      {Key? key, required this.text, required this.icon, this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        onPressed: press,
        style: TextButton.styleFrom(
          primary:const Color(0xFF545D68),
          padding:const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor:const Color(0xFFF5F6F9),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color:const Color(0xFFFF7643),
              size: 22,
            ),
           const SizedBox(width: 20),
            Expanded(child: Text(text,style: TextStyle(color: Color(0xFF545D68)),)),
           const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
