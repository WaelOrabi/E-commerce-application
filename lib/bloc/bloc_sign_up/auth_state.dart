part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class SignUpProcessing extends AuthState{}
class SignUpSuccessed extends AuthState{
  final SignUp signUpModel;

  SignUpSuccessed(this.signUpModel);
}
class SignUpFaildState extends AuthState{
final String errorMessage ;

  SignUpFaildState({required this.errorMessage});
}
class SignUpChangePasswordVisibilityState extends AuthState{}