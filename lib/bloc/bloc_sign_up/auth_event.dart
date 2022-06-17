part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}
class SignUpEvent extends AuthEvent{
  String name='';
  String phone_number='';
  String email='';
  String password='';
  String password_confirmation='';

  SignUpEvent({required this.password_confirmation,required this.name, required this.phone_number, required this.email, required this.password});


}