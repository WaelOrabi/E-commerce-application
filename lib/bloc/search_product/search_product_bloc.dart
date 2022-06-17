import 'package:bloc/bloc.dart';
import 'package:languages_project/data/models/search_products.dart';
import 'package:languages_project/data/web_services/search_products_web_services.dart';
import 'package:languages_project/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  final SearchProductsWebServices searchProductsWebServices;
  late List< SearchProductModel> searchProductModel;
  SearchProductBloc(this.searchProductsWebServices) : super(SearchProductInitial());
  void searchProduct({
    required String name_Product,
    required String category_name,
    required String date_from,
    required String date_to,
  }) async {
    emit(SearchProductProcessing());
    SearchProductsWebServices.GetData(
        url: '/products/search',
        name_Products: name_Product,

        token: SharedPref.getData(key: 'token'), data: {
'category_id':category_name,
      'name':name_Product,
      'date_from':date_from,
      'date_to':date_to,
    }).then((value) {
      for(int i=0;i<value.data.length;i++) {
        searchProductModel.add(SearchProductModel.fromJson(value.data[i]));
      }
      print(searchProductModel);
      emit(SearchProductSuccess(searchProductModel: searchProductModel));
    }).catchError((error){
      emit(SearchProductFailedState(errorMessage:error.toString()));
    });
  }
}
