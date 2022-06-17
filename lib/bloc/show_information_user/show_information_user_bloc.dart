import 'package:bloc/bloc.dart';
import 'package:languages_project/data/models/show_information_user.dart';
import 'package:languages_project/data/web_services/show_information_user_web_services.dart';
import 'package:meta/meta.dart';

part 'show_information_user_event.dart';
part 'show_information_user_state.dart';

class ShowInformationUserBloc extends Bloc<ShowInformationUserEvent, ShowInformationUserState> {
  final ShowInformationUserWebServices showInformationUserWebServices;
  late ShowInformationUserModel showInformationUserModel;
  ShowInformationUserBloc({required this.showInformationUserWebServices}) : super(ShowInformationUserInitial());
  void showInformation(){
    emit(ShowInformationUserProcessing());
    ShowInformationUserWebServices.showInformationUser(url:'/users/').then((value) {
      showInformationUserModel=ShowInformationUserModel.fromJson(value.data);
      emit(ShowInformationUserSuccess(showInformationUserModel:showInformationUserModel));
    }).catchError((error){
      emit(ShowInformationUserFailedState(errorMessage:error.toString()));
    });
  }
}
