import 'package:bloc_unit_test_example/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc(this._loginRepository) : super(LoginInitialState()) {
    on<EditedEmail>((event, emit) {
      emit(LoginDataState(email: event.email, password: state.passwordStr));
    });

    on<EditedPassword>((event, emit) {
      emit(LoginDataState(email: state.emailStr, password: event.password));
    });

    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoadingState(
        email: state.emailStr,
        password: state.passwordStr,
      ));
      if (state.emailStr?.isNotEmpty == false ||
          state.emailStr?.isNotEmpty == false) {
        emit(LoginErrorState(
          email: state.emailStr,
          password: state.passwordStr,
          errorToShow: 'Email or password is empty',
        ));
        return;
      }

      try {
        await _loginRepository.login(
          email: state.emailStr,
          password: state.passwordStr,
        );
        emit(LoginSuccessState());
      } catch (_) {
        emit(LoginErrorState(
          email: state.emailStr,
          password: state.passwordStr,
          errorToShow: 'Server error',
        ));
      }
    });
  }
}
