part of 'show_information_user_bloc.dart';

@immutable
abstract class ShowInformationUserState {}
class ShowInformationUserInitial extends ShowInformationUserState {}

class ShowInformationUserProcessing extends ShowInformationUserState {}

class ShowInformationUserSuccess extends ShowInformationUserState {
  final ShowInformationUserModel showInformationUserModel;

  ShowInformationUserSuccess({required this.showInformationUserModel});
}

class ShowInformationUserFailedState extends ShowInformationUserState {
  String errorMessage;
  ShowInformationUserFailedState({required this.errorMessage});
}
