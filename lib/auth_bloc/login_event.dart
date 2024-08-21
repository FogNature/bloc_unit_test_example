part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class EditedEmail extends LoginEvent {
  final String email;
  EditedEmail(this.email);
}

class EditedPassword extends LoginEvent {
  final String password;
  EditedPassword(this.password);
}

class LoginButtonPressed extends LoginEvent {}
