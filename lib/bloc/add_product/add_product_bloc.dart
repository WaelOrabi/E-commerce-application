import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:languages_project/data/models/add_product.dart';
import 'package:languages_project/data/web_services/add_product_web_services.dart';
import 'package:meta/meta.dart';

part 'add_product_event.dart';

part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  ProductsWebServices productsWebServices;
  late AddProduct addProductModel;
  AddProductBloc({required this.productsWebServices}) : super(AddProductInitial());

  void addProduct(
      {
        required File ? image,
        required var dateinput_first,
        required var dateinput_seconde,
        required var dateinput_third,
        required var price1,
        required var price2,
        required var price3,
        required String name,
      required var expirationDate,
      required var price,
        required var category_id,
      required var quantity})async {
    emit(AddProductProcessing());
    String imageName=image!.path.split('/').last;
   FormData formData=FormData.fromMap({
      'image':await MultipartFile.fromFile(image.path,filename: imageName),
      'name':name,
      'price':price,
      'exp_date':expirationDate,
      'category_id':category_id,
      'sale_date1':dateinput_first,
      'sale_date2':dateinput_seconde,
      'sale_date3':dateinput_third,
      'price1':price1,
      'price2':price2,
      'price3':price3,
     'quantity':quantity,
    });

    ProductsWebServices.PostData(url:'/products',
      data:formData, ).then((value) {
        print('rooooooooosssbloc=${value.data}');
      addProductModel=AddProduct.fromJson(value.data);
      emit(AddProductSuccess(addProductModel));
    }).catchError((error){
      if(error.toString().contains('400')) {
        emit(AddProductFailedState(errorMessage:error.toString()));
      }
      emit(AddProductFailedState(errorMessage:error.toString()));
    });

  }
}
