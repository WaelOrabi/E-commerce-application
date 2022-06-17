import 'package:bloc/bloc.dart';
import 'package:languages_project/data/models/search_category.dart';
import 'package:languages_project/data/models/search_category.dart';
import 'package:languages_project/data/models/search_category.dart';
import 'package:languages_project/data/models/search_category.dart';
import 'package:languages_project/data/web_services/search_category_web_services.dart';
import 'package:languages_project/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'search_category_event.dart';

part 'search_category_state.dart';

class SearchCategoryBloc
    extends Bloc<SearchCategoryEvent, SearchCategoryState> {
  final SearchCategoryWebServices searchCategoryWebServices;
  late SearchCategoryModel searchCategoryModel;

  SearchCategoryBloc({required this.searchCategoryWebServices})
      : super(SearchCategoryInitial());

  void searchCategoryname({
    required String name_category,
  }) async {
    emit(SearchCategoryProcessing());
    SearchCategoryWebServices.GetData(
        url: '/categories/search/',
        name_category: name_category,
        token: SharedPref.getData(key: 'token')).then((value) {
          searchCategoryModel=SearchCategoryModel.fromJson(value.data[0]);
          print(searchCategoryModel);
          emit(SearchCategorySuccess(searchCategoryModel: searchCategoryModel));
    }).catchError((error){
      emit(SearchCategoryFailedState(errorMessage:error.toString()));
    });
  }

}
