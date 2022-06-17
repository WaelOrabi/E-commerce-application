part of 'show_my_products_bloc.dart';

@immutable
abstract class ShowMyProductsState {}

class ShowMyProductsInitial extends ShowMyProductsState {}

class ShowMyProductsProcessing extends ShowMyProductsState {}

class ShowMyProductsSuccess extends ShowMyProductsState {
  final List<ShowMyProductsModel> ? showMyProductsModel;

  ShowMyProductsSuccess({required this.showMyProductsModel});
}

class ShowMyProductsFailedState extends ShowMyProductsState {
  String errorMessage;
  ShowMyProductsFailedState({required this.errorMessage});
}


