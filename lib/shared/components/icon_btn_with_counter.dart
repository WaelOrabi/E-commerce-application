import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class IconBtnWithCounter extends StatelessWidget {
 final String svgSrc;
 final Function function;
 int ? counter=20;
   IconBtnWithCounter({Key? key, required this.svgSrc, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
   onTap: function as void Function(),
      borderRadius: BorderRadius.circular(100),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
         Container(

           child:SvgPicture.asset(svgSrc),
           padding: EdgeInsets.all(12),

           width:MediaQuery.of(context).size.width/7,
           height: MediaQuery.of(context).size.height/16,
           decoration: BoxDecoration(
              color: const Color(0xFF979797).withOpacity(0.1),
             shape:BoxShape.circle,
           ),
         ),
          if(counter!=0 && counter!=null)
           Positioned(
             top: -1,
             right: 5,
             child: Container(
               width: 18,
               height: 18,
               child: Center(
                 child: Text(
                   "$counter",
                   style:const TextStyle(
                     fontSize:10,
                     height: 1,
                     fontWeight: FontWeight.w600,
                     color: Colors.white,
                   ),
                 ),
               ),
               decoration: BoxDecoration(
                 color: Color(0xFFFF4848),
                 shape: BoxShape.circle,
                 border: Border.all(width: 1.5, color: Colors.white),
               ),
             ),
           ),
        ],
      ),
    );
  }
}
