part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}
class SignInitial extends AuthState {}

class SignInProcessing extends AuthState {}

class SignInSuccess extends AuthState {
  final SignIn signInModel;

  SignInSuccess(this.signInModel);
}

class SignInFailedState extends AuthState {
  String errorMessage;
  SignInFailedState({required this.errorMessage});
}
class SignInChangePasswordVisibilityState extends AuthState{}
