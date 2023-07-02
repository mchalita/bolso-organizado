import 'package:bolso_organizado/features/balance/balance.dart';
import 'package:bolso_organizado/features/home/home_controller.dart';
import 'package:bolso_organizado/features/sign_in/sign_in_controller.dart';
import 'package:bolso_organizado/features/sign_up/sign_up_controller.dart';
import 'package:bolso_organizado/features/transaction/transaction.dart';
import 'package:bolso_organizado/repositories/repositories.dart';
import 'package:bolso_organizado/repositories/transaction_repository.dart';
import 'package:bolso_organizado/services/auth_service.dart';
import 'package:bolso_organizado/services/firebase_auth_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependencies() {
  //Register Services
  locator.registerFactory<AuthService>(
    () => FirebaseAuthService(),
  );

  //Register Repositories

  locator.registerFactory<TransactionRepository>(
    () => TransactionRepositoryImpl(),
  );

  //Register Controllers

  locator.registerFactory<SignInController>(
    () => SignInController(
      authService: locator.get<AuthService>(),
    ),
  );

  locator.registerFactory<SignUpController>(
    () => SignUpController(
      authService: locator.get<AuthService>(),
    ),
  );

  locator.registerLazySingleton<HomeController>(
    () => HomeController(
      transactionRepository: locator.get<TransactionRepository>(),
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
      transactionRepository: locator.get<TransactionRepository>(),
    ),
  );
}
