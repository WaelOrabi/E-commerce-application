import 'package:bloc/bloc.dart';
import 'package:languages_project/data/models/get_all_products_from_category.dart';
import 'package:languages_project/data/web_services/get_all_products_from_category_web_services.dart';
import 'package:meta/meta.dart';

part 'get_all_products_from_category_event.dart';

part 'get_all_products_from_category_state.dart';

class GetAllProductsFromCategoryBloc extends Bloc<
    GetAllProductsFromCategoryEvent, GetAllProductsFromCategoryState> {
  final GetAllProductsFromCategoryWebServices
      getAllProductsFromCategoryWebServices;
  late List<GetAllProductsFromCategoryModel> getAllProductsFromCategoryModel;

  GetAllProductsFromCategoryBloc(
      {required this.getAllProductsFromCategoryWebServices})
      : super(GetAllProductsFromCategoryInitial());

  void getAllProductsFromCategory({required int id_category}) {
    emit(GetAllProductsFromCategoryProcessing());
    getAllProductsFromCategoryModel=[];
    GetAllProductsFromCategoryWebServices.GetData(
            url: '/categories/', id_category: id_category)
        .then((value) {
for(int i=0;i<value.data['products'].length;i++) {
  getAllProductsFromCategoryModel.add(
      GetAllProductsFromCategoryModel.fromJson(value.data['products'][i]));
}
      emit(GetAllProductsFromCategorySuccess(
          getAllProductsfromCategoryModel: getAllProductsFromCategoryModel));
    }).catchError((error) {
      print('this error=${error}');
      emit(GetAllProductsFromCategoryFailedState(
          errorMessage: error.toString()));
    });
  }
}
