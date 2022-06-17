import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:languages_project/end_points.dart';
import 'package:languages_project/modules/profile/components/update_my_information.dart';

class ProfilePicture extends StatefulWidget {
  final String ? imgUrl;
  const ProfilePicture({Key? key,  this.imgUrl}) : super(key: key);

  @override
  State<ProfilePicture> createState() => _ProfilePictureState(imgUrl);
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? image;
final String ? imgUrl;
  final picker = ImagePicker();

  _ProfilePictureState(this.imgUrl);

  Future getImage(ImageSource src) async {
    final pickedFile = await picker.getImage(source: src);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          image == null
              ? CircleAvatar(
            backgroundColor: Colors.white,
                 child: Icon(Icons.person,size: 100,color: Colors.grey,),
            backgroundImage: NetworkImage('$baseUrl1/users/$imgUrl',scale: 2),
            radius: 150,
                )
              : CircleAvatar(
                  backgroundImage: FileImage(image!),
                  radius: 130,

                ),
        ],
      ),
    );
  }
}
