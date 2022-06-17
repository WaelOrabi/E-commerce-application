import 'package:bloc/bloc.dart';
import 'package:languages_project/data/web_services/log_out_web_services.dart';
import 'package:meta/meta.dart';

part 'log_out_event.dart';
part 'log_out_state.dart';

class LogOutBloc extends Bloc<LogOutEvent, LogOutState> {
  final LogOutWebServices logOutWebServices;
  LogOutBloc({required this.logOutWebServices}) : super(LogOutInitial());

  void LogOut(){
    emit(LogOutProcessing());
    LogOutWebServices.LogOutUser(url:'/users/logout').then((value) {
      emit(LogOutSuccess(LogOutMessage:value.data));
    }).catchError((error){
      if(error.toString().contains('401')) {
        emit(LogOutFailedState(errorMessage:'This account has already been logged out' ));
      }
    });
  }
}
