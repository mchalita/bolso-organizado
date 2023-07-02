abstract class OnboardingState {}

class OnboardingStateInitial extends OnboardingState {}

class AuthenticatedUser extends OnboardingState {
  final String message;
  final bool isReady;

  AuthenticatedUser({
    this.message = '',
    this.isReady = false,
  });
}

class UnauthenticatedUser extends OnboardingState {}
