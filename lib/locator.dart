import 'package:bolso_organizado/features/balance/balance.dart';
import 'package:bolso_organizado/features/home/home_controller.dart';
import 'package:bolso_organizado/features/onboarding/onboarding_controller.dart';
import 'package:bolso_organizado/features/sign_in/sign_in_controller.dart';
import 'package:bolso_organizado/features/sign_up/sign_up_controller.dart';
import 'package:bolso_organizado/features/transaction/transaction.dart';
import 'package:bolso_organizado/repositories/transaction_repository.dart';
import 'package:bolso_organizado/services/auth_service.dart';
import 'package:bolso_organizado/services/firebase_auth_service.dart';
import 'package:bolso_organizado/services/secure_storage.dart';
import 'package:bolso_organizado/services/transaction_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependencies() {
  //Register Services
  locator.registerFactory<AuthService>(
    () => FirebaseAuthService(),
  );

  //Register Repositories

  locator.registerFactory<TransactionRepository>(
    () => TransactionRepository(),
  );

  //Register Service

  locator.registerFactory<TransactionService>(
        () => TransactionService(),
  );

  //Register Controllers

  locator.registerFactory<OnboardingController>(
        () => OnboardingController(
      secureStorageService: const SecureStorageService(),
    ),
  );

  locator.registerFactory<SignInController>(
    () => SignInController(
      authService: locator.get<AuthService>(),
      secureStorageService: const SecureStorageService(),
    ),
  );

  locator.registerFactory<SignUpController>(
    () => SignUpController(
      authService: locator.get<AuthService>(),
      secureStorageService: const SecureStorageService(),
    ),
  );

  locator.registerLazySingleton<HomeController>(
    () => HomeController(
      transactionService: locator.get<TransactionService>(),
    ),
  );
  //
  // locator.registerLazySingleton<WalletController>(
  //   () => WalletController(
  //     transactionRepository: locator.get<TransactionRepository>(),
  //   ),
  // );
  //
  locator.registerLazySingleton<BalanceController>(
    () => BalanceController(
      transactionRepository: locator.get<TransactionRepository>(),
    ),
  );

  locator.registerLazySingleton<TransactionController>(
    () => TransactionController(
      transactionService: locator.get<TransactionService>(),
      storage: const SecureStorageService(),
    ),
  );
}
