import 'package:bloc/bloc.dart';
import 'package:languages_project/data/models/show_my_products.dart';
import 'package:languages_project/data/web_services/show_my_product_web_services.dart';
import 'package:meta/meta.dart';

part 'show_my_products_event.dart';

part 'show_my_products_state.dart';

class ShowMyProductsBloc
    extends Bloc<ShowMyProductsEvent, ShowMyProductsState> {
  late List<ShowMyProductsModel> showMyProductsModel;
  final ShowMyProductsWebServices showMyProductsWebServices;

  ShowMyProductsBloc({required this.showMyProductsWebServices})
      : super(ShowMyProductsInitial());

  void showMyProducts() {
    emit(ShowMyProductsProcessing());
    showMyProductsModel = [];
    ShowMyProductsWebServices.PostData(url: '/users/show').then((value) {
      if(value.data is List){
        for (int i = 0; i < value.data.length; i++) {
          showMyProductsModel.add(ShowMyProductsModel.fromJson(value.data[i]));
        }
      }else{
        print("Error occur");

      }

      emit(ShowMyProductsSuccess(showMyProductsModel: showMyProductsModel));
    }).catchError((error) {
      emit(ShowMyProductsFailedState(errorMessage: error.toString()));
    });
  }
}
