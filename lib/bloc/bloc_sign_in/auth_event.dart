part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}
class SignInEvent extends AuthEvent{
  String EmailVal;
  String PasswordVal;
  String get Email  {
    return EmailVal;}
  String get Password {
   return  PasswordVal;
  }
  SignInEvent({ required this.EmailVal,required this.PasswordVal});
}