part of 'delete_account_bloc.dart';

@immutable
abstract class DeleteAccountState {}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountProcessing extends DeleteAccountState {}

class DeleteAccountSuccess extends DeleteAccountState {
  final dynamic DeleteAccountMessage;

  DeleteAccountSuccess({required this.DeleteAccountMessage});
}

class DeleteAccountFailedState extends DeleteAccountState {
  String errorMessage;
  DeleteAccountFailedState({required this.errorMessage});
}
