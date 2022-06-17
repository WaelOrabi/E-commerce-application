part of 'log_out_bloc.dart';

@immutable
abstract class LogOutState {}

class LogOutInitial extends LogOutState {}

class LogOutProcessing extends LogOutState {}

class LogOutSuccess extends LogOutState {
  final dynamic LogOutMessage;

  LogOutSuccess({required this.LogOutMessage});
}

class LogOutFailedState extends LogOutState {
  String errorMessage;
  LogOutFailedState({required this.errorMessage});
}
