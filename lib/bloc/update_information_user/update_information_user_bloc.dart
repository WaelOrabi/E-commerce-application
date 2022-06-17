import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:languages_project/data/models/update_information_user.dart';
import 'package:languages_project/data/web_services/update_information_user_web_services.dart';
import 'package:meta/meta.dart';

part 'update_information_user_event.dart';

part 'update_information_user_state.dart';

class UpdateInformationUserBloc
    extends Bloc<UpdateInformationUserEvent, UpdateInformationUserState> {
  final UpdateInformationUserWebServices updateInformationUserWebServices;

  UpdateInformationUserBloc({required this.updateInformationUserWebServices})
      : super(UpdateInformationUserInitial());
  late UpdateInformationUserModel updateInformationUserModel;
  void updatInformationUser(
      {dynamic name,
      dynamic email,
      dynamic password,
      File ? image,
      dynamic phone_number,
      dynamic whatsapp_url,
      dynamic facebook_url}) async{
    emit(UpdateInformationUserProcessing());
    String imageName=image!.path.split('/').last;
    FormData formData=FormData.fromMap({
      'image':await MultipartFile.fromFile(image.path,filename: imageName),
       'name':name,
      'email':email,
      'password':password,
      'phone_number':phone_number,
      'whatsapp_url':whatsapp_url,
      'facebook_url':facebook_url,
    });
      UpdateInformationUserWebServices.PostData(url:'/users/update', data: formData).then((value) {
       updateInformationUserModel= UpdateInformationUserModel.fromJson(value.data);
        emit(UpdateInformationUserSuccess(updateInformationUserModel));
      }).catchError((error){
        if(error.toString().contains('422')) {
          emit(UpdateInformationUserFailedState(errorMessage:"The email has already been taken."));
        }
        emit(UpdateInformationUserFailedState(errorMessage: error.toString()));
      });
    }
  IconData icon=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    icon=isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(updateInformationUserChangePasswordVisibilityState());
  }
  }

