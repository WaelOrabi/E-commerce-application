import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:languages_project/data/models/update_product.dart';
import 'package:languages_project/data/web_services/update_product_web_services.dart';
import 'package:meta/meta.dart';

part 'update_product_event.dart';

part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final UpdateProductWebServices updateProductWebServices;
  late UpdateProductModel updateProductModel;

  UpdateProductBloc({required this.updateProductWebServices})
      : super(UpdateProductInitial());

  void updateProduct(
      {required String? name,
      required int? price,
      required int? category_id,
      required int? quantity,
      required int? price1,
      required int? price2,
      required int? price3,
      required int id_product,
      required File? image}) async {
    emit(UpdateProductProcessing());
    if (image != null) {
      String imageName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(image.path, filename: imageName),
        'name': name,
        'price': price,
        'price1': price1,
        'price2': price2,
        'price3': price3,
        '_method': 'PUT',
        'category_id': category_id,
        'quantity': quantity,
      });

      UpdateProductWebServices.PostData(
              url: '/products/$id_product', data: formData)
          .then((value) {
        updateProductModel = UpdateProductModel.fromJson(value.data);
        emit(UpdateProductSuccess(updateProductModel));
      }).catchError((error) {
        emit(UpdateProductFailedState(errorMessage: error.toString()));
      });
    } else if (image == null) {
      UpdateProductWebServices.PostData(url: '/products/${updateProductModel.product!.id}', data:
      FormData.fromMap({
      'name': name,
      'price': price,
      'price1': price1,
      'price2': price2,
      'price3': price3,
      '_method': 'PUT',
      'category_id': category_id,
      'quantity': quantity,
      })).then((value) {
        updateProductModel = UpdateProductModel.fromJson(value.data);
        emit(UpdateProductSuccess(updateProductModel));
      }).catchError((error) {
        emit(UpdateProductFailedState(errorMessage: error.toString()));
      });
    }
  }
}
