import 'package:bolso_organizado/features/onboarding/onboarding_state.dart';
import 'package:bolso_organizado/services/secure_storage.dart';
import 'package:flutter/foundation.dart';

class OnboardingController extends ChangeNotifier {
  OnboardingController({required this.secureStorageService,});

  final SecureStorageService secureStorageService;

  OnboardingState _state = OnboardingStateInitial();

  OnboardingState get state => _state;

  void _changeState(OnboardingState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> isUserLogged() async {
    final result = await secureStorageService.readOne(key: "CURRENT_USER");

    if (result != null) {
      _changeState(AuthenticatedUser(isReady: true));
    } else {
      _changeState(UnauthenticatedUser());
    }
  }
}
