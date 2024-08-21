import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_unit_test_example/auth_bloc/login_bloc.dart';
import 'package:bloc_unit_test_example/login_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late LoginRepository repository;
  late LoginBloc bloc;

  setUpAll(() {
    repository = MockLoginRepository();
  });

  setUp(() {
    bloc = LoginBloc(repository);
  });

  test('LoginBloc should be initialized with LoginInitialState', () {
    // act
    final state = bloc.state;

    // assert
    expect(state, isA<LoginInitialState>());
  });

  blocTest(
    'emits [LoginDataState] after adding email',
    build: () => bloc,
    act: (_bloc) => _bloc.add(EditedEmail('example@sample.com')),
    expect: () => [
      isA<LoginDataState>(),
    ],
  );

  blocTest(
    'emits [LoginDataState] after adding password',
    build: () => bloc,
    act: (_bloc) => _bloc.add(EditedPassword('myPass123')),
    expect: () => [
      isA<LoginDataState>(),
    ],
  );

  group('LoginButtonPressed', () {
    blocTest(
      'emits [LoginErrorState] if email is null',
      build: () => bloc,
      seed: () =>
          LoginDataState(email: null, password: 'myPass123') as LoginState,
      act: (_bloc) => _bloc.add(LoginButtonPressed()),
      expect: () => [
        isA<LoginLoadingState>(),
        isA<LoginErrorState>(),
      ],
    );

    blocTest(
      'emits [LoginErrorState] if email is null',
      build: () => bloc,
      act: (_bloc) {
        _bloc.add(EditedPassword('myPass123'));
        _bloc.add(LoginButtonPressed());
      },
      expect: () => [
        isA<LoginDataState>(),
        isA<LoginLoadingState>(),
        isA<LoginErrorState>(),
      ],
    );

    blocTest('emits [LoginSuccessState]',
        build: () {
          when(() => repository.login(
                  email: any(named: 'email'), password: any(named: 'password')))
              .thenAnswer((_) => Future.value(true));
          return bloc;
        },
        seed: () =>
            LoginDataState(email: 'example@sample.com', password: 'myPass123')
                as LoginState,
        act: (_bloc) => _bloc.add(LoginButtonPressed()),
        expect: () => [
              isA<LoginLoadingState>(),
              isA<LoginSuccessState>(),
            ],
        verify: (_) {
          verify(() => repository.login(
                email: any(named: 'email'),
                password: any(named: 'password'),
              )).called(1);
        });
  });
}
