import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:languages_project/data/models/add_category.dart';
import 'package:languages_project/data/web_services/add_category_web_services.dart';
import 'package:languages_project/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'add_category_event.dart';

part 'add_category_state.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  late String error_state;
  AddCategoryWebServices addCategoryWebServices;
  late AddCategory addCategoryModel;

  AddCategoryBloc({required this.addCategoryWebServices})
      : super(AddCategoryInitial());

  void addCategory(
      {required File? image,
      required String name,
      required String description}) async {
    emit(AddCategoryProcessing());
    String imageName = image!.path.split('/').last;
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path, filename: imageName),
      'name': name,
      'description': description,
    });
    AddCategoryWebServices.PostData(
            url: '/categories/',
            data: formData,
            token: SharedPref.getData(key: 'token'))
        .then((value) {
         // print("resssssssultbloc1=${value}");
          print("resssssssultbloc2=${value.data}");
          if(value!=null) {
            addCategoryModel = AddCategory.fromJson(value.data);
            emit(AddCategorySuccess(addCategoryModel: addCategoryModel));
          }
          emit(AddCategorySuccess());
      print('hello');
    }).catchError((error) {
      if ((addCategoryModel.description == null ||
              addCategoryModel.name == null ||
              addCategoryModel.id == null) &&
          error.toString().contains('422')) {
        if (addCategoryModel.name == null) {
          error_state =
              'The given data was invalid.\nThe name field is required.';
          emit(AddCategoryFailedState(errorMessage: error_state));
        }
        if (addCategoryModel.id == null) {
          error_state =
              'The given data was invalid.\nThe id field is required.';
          emit(AddCategoryFailedState(errorMessage: error_state));
        }
        if (addCategoryModel.description == null) {
          error_state =
              'The given data was invalid.\nThe description field is required.';
          emit(AddCategoryFailedState(errorMessage: error_state));
        }
      }
      if (error.toString().contains('422')) {
        error_state =
            'The given data was invalid.\nThe email has already been taken.';
        emit(AddCategoryFailedState(errorMessage: error_state));
      }
      emit(AddCategoryFailedState(errorMessage: error.toString()));
    });
  }
}
