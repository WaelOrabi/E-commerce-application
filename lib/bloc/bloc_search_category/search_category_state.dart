part of 'search_category_bloc.dart';

@immutable
abstract class SearchCategoryState {}


class SearchCategoryInitial extends SearchCategoryState {}

class SearchCategoryProcessing extends SearchCategoryState {}

class SearchCategorySuccess extends SearchCategoryState {
  final SearchCategoryModel searchCategoryModel;

  SearchCategorySuccess({required this.searchCategoryModel});
}

class SearchCategoryFailedState extends SearchCategoryState {
  String errorMessage;
  SearchCategoryFailedState({required this.errorMessage});
}