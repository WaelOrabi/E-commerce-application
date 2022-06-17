part of 'get_all_category_bloc.dart';

@immutable
abstract class GetAllCategoryState {}

class GetAllCategoryInitial extends GetAllCategoryState {}
class GetAllCategoryProcessing extends GetAllCategoryState{}
class GetAllCategorySuccess extends GetAllCategoryState{
 final List<GetCategoryModel> getAllCategories;

  GetAllCategorySuccess({required this.getAllCategories});


}
class GetAllCategoryFailedState extends GetAllCategoryState{
  final String errorMessage;

  GetAllCategoryFailedState({required this.errorMessage});

}