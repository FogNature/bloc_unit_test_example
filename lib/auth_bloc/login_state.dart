part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginDataState extends LoginState {
  final String? email;
  final String? password;

  LoginDataState({
    required this.email,
    required this.password,
  });
}

class LoginLoadingState extends LoginState {
  final String? email;
  final String? password;

  LoginLoadingState({
    required this.email,
    required this.password,
  });
}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String? email;
  final String? password;
  final String? errorToShow;

  LoginErrorState({
    required this.email,
    required this.password,
    required this.errorToShow,
  });
}

extension LoginStateX on LoginState {
  String? get emailStr {
    if (this is LoginInitialState || this is LoginSuccessState) {
      return null;
    } else if (this is LoginDataState) {
      return (this as LoginDataState).email;
    } else if (this is LoginLoadingState) {
      return (this as LoginLoadingState).email;
    } else if (this is LoginErrorState) {
      return (this as LoginErrorState).email;
    }
    return null;
  }

  String? get passwordStr {
    if (this is LoginInitialState || this is LoginSuccessState) {
      return null;
    } else if (this is LoginDataState) {
      return (this as LoginDataState).password;
    } else if (this is LoginLoadingState) {
      return (this as LoginLoadingState).password;
    } else if (this is LoginErrorState) {
      return (this as LoginErrorState).password;
    }
    return null;
  }
}
