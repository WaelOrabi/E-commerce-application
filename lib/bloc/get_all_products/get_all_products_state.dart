part of 'get_all_products_bloc.dart';

@immutable
abstract class GetAllProductsState {}

class GetAllProductsInitial extends GetAllProductsState {}
class GetAllProductsProcessing extends GetAllProductsState {}

class GetAllProductsSuccess extends GetAllProductsState {
  final List<GetAllProductsModel> ? getAllProductsModel;

  GetAllProductsSuccess({required this.getAllProductsModel});
}

class GetAllProductsFailedState extends GetAllProductsState {
  String errorMessage;
  GetAllProductsFailedState({required this.errorMessage});
}
