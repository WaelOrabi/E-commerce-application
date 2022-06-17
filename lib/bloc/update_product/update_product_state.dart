part of 'update_product_bloc.dart';

@immutable
abstract class UpdateProductState {}

class UpdateProductInitial extends UpdateProductState {}

class UpdateProductProcessing extends UpdateProductState {}

class UpdateProductSuccess extends UpdateProductState {
  final UpdateProductModel UpdateProductsModel;

  UpdateProductSuccess(this.UpdateProductsModel);
}

class UpdateProductFailedState extends UpdateProductState {
  String errorMessage;
  UpdateProductFailedState({required this.errorMessage});
}

