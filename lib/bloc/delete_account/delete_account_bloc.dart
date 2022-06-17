import 'package:bloc/bloc.dart';
import 'package:languages_project/data/web_services/delete_account_web_services.dart';
import 'package:languages_project/data/web_services/delete_account_web_services.dart';
import 'package:languages_project/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final DeleteAccountWebServices deleteAccountWebServices;
  DeleteAccountBloc({required this.deleteAccountWebServices}) : super(DeleteAccountInitial()) ;

  void DeleteAccount(){
    emit(DeleteAccountProcessing());
    print('ssssss=${SharedPref.getData(key:'token')}');
    DeleteAccountWebServices.DeleteAccount(url:'/users/').then((value) {
      print('vvvvvv=${value}');
      print('vvvvvv=${value.data}');
      emit(DeleteAccountSuccess(DeleteAccountMessage: value.data));

    }).catchError((error){
      if(error.toString().contains('401')) {
        emit(DeleteAccountFailedState(errorMessage:'This account does not exist to be deleted' ));
      }

    });
  }
}
