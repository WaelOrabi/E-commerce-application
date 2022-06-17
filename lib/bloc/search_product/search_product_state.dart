part of 'search_product_bloc.dart';

@immutable
abstract class SearchProductState {}

class SearchProductInitial extends SearchProductState {}

class SearchProductProcessing extends SearchProductState {}

class SearchProductSuccess extends SearchProductState {
  final List<SearchProductModel> searchProductModel;

  SearchProductSuccess({required this.searchProductModel});
}

class SearchProductFailedState extends SearchProductState {
  String errorMessage;
  SearchProductFailedState({required this.errorMessage});
}