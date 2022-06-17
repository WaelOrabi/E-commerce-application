part of 'update_information_user_bloc.dart';

@immutable
abstract class UpdateInformationUserState {}

class UpdateInformationUserInitial extends UpdateInformationUserState {}

class UpdateInformationUserProcessing extends UpdateInformationUserState {}

class UpdateInformationUserSuccess extends UpdateInformationUserState {
  final UpdateInformationUserModel updateInformationUserModel;

  UpdateInformationUserSuccess(this.updateInformationUserModel);
}

class UpdateInformationUserFailedState extends UpdateInformationUserState {
  String errorMessage;
  UpdateInformationUserFailedState({required this.errorMessage});
}

class updateInformationUserChangePasswordVisibilityState extends UpdateInformationUserState {}
