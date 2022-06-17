part of 'add_category_bloc.dart';

@immutable
abstract class AddCategoryState {}

class AddCategoryInitial extends AddCategoryState {}

class AddCategoryProcessing extends AddCategoryState {}

class AddCategorySuccess extends AddCategoryState {
  final AddCategory ? addCategoryModel;

  AddCategorySuccess({this.addCategoryModel});
}

class AddCategoryFailedState extends AddCategoryState {
  String errorMessage;
  AddCategoryFailedState({required this.errorMessage});
}

