import 'package:bolso_organizado/services/auth_service.dart';

import 'package:flutter/foundation.dart';

import 'sign_in_state.dart';

class SignInController extends ChangeNotifier {
  SignInController({
    required this.authService,
  });

  final AuthService authService;

  SignInState _state = SignInStateInitial();

  SignInState get state => _state;

  void _changeState(SignInState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    _changeState(SignInStateLoading());

    final result = await authService.signIn(
      email: email,
      password: password,
    );

    result.fold(
      (error) => _changeState(SignInStateError(error.message)),
      (data) => _changeState(SignInStateSuccess()),
    );
  }
}
