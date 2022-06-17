part of 'add_product_bloc.dart';

@immutable
abstract class AddProductState {}

class AddProductInitial extends AddProductState {}

class AddProductProcessing extends AddProductState {}

class AddProductSuccess extends AddProductState {
  final AddProduct addProductModel;

  AddProductSuccess(this.addProductModel);
}

class AddProductFailedState extends AddProductState {
  String errorMessage;
  AddProductFailedState({required this.errorMessage});
}


