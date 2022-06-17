import 'package:bloc/bloc.dart';
import 'package:languages_project/data/models/get_category_model.dart';
import 'package:languages_project/data/web_services/get_all_category_web_services.dart';
import 'package:languages_project/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'get_all_category_event.dart';

part 'get_all_category_state.dart';

class GetAllCategoryBloc
    extends Bloc<GetAllCategoryEvent, GetAllCategoryState> {
  final GetAllCategoryWebServices getAllCategoryWebServices;

  GetAllCategoryBloc({required this.getAllCategoryWebServices})
      : super(GetAllCategoryInitial());
 late List<GetCategoryModel>  getAllCategories;
 late GetCategoryModel category;
  void getAllCategory() async {
    emit(GetAllCategoryProcessing());
    getAllCategories=[];
    GetAllCategoryWebServices.getAllCategories(
            url: '/categories/')
        .then((value) {

          for(int i=0;i<value.data.length;i++) {
            category=GetCategoryModel.fromJson(value.data[i]);

            getAllCategories.add(category);
          }
          emit(GetAllCategorySuccess(getAllCategories: getAllCategories));
    }).catchError((error){
      emit(GetAllCategoryFailedState(errorMessage:error.toString()));
    });
  }
}
