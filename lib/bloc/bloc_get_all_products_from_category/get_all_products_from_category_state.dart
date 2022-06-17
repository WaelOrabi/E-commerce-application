part of 'get_all_products_from_category_bloc.dart';

@immutable
abstract class GetAllProductsFromCategoryState {}

class GetAllProductsFromCategoryInitial extends GetAllProductsFromCategoryState {}
class GetAllProductsFromCategoryProcessing extends GetAllProductsFromCategoryState {}

class GetAllProductsFromCategorySuccess extends GetAllProductsFromCategoryState {
  final List<GetAllProductsFromCategoryModel> ? getAllProductsfromCategoryModel;

  GetAllProductsFromCategorySuccess({required this.getAllProductsfromCategoryModel});
}

class GetAllProductsFromCategoryFailedState extends GetAllProductsFromCategoryState {
  String errorMessage;
  GetAllProductsFromCategoryFailedState({required this.errorMessage});
}