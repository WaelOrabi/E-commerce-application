import 'package:bloc/bloc.dart';
import 'package:languages_project/data/models/get_all_products.dart';
import 'package:languages_project/data/web_services/get_all_products_web_services.dart';
import 'package:meta/meta.dart';

part 'get_all_products_event.dart';
part 'get_all_products_state.dart';

class GetAllProductsBloc extends Bloc<GetAllProductsEvent, GetAllProductsState> {
  final GetAllProductsWebServices getAllProductsWebServices;
  late List<GetAllProductsModel> getAllProductsModel;
  GetAllProductsBloc({required this.getAllProductsWebServices}) : super(GetAllProductsInitial());
  void getAllProducts(){
    emit(GetAllProductsProcessing());
    getAllProductsModel=[];
    GetAllProductsWebServices.GetData(url:'/products').then((value) {
      print('delete_product=${value.data}');

      for(int i=0;i<value.data['products'].length;i++) {
        print (value.data['products'][i]);
        getAllProductsModel.add(
            GetAllProductsModel.fromJson(value.data['products'][i]));
      }
      emit(GetAllProductsSuccess(getAllProductsModel: getAllProductsModel));
    }).catchError((error){
      print('delete_product=${error.toString()}');
      print('this error=${error}');
      emit(GetAllProductsFailedState(
          errorMessage: error.toString()));
    });
  }
}
