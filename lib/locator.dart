import 'package:bolso_organizado/features/splash/splash_controller.dart';
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

  // locator.registerFactory<TransactionRepository>(
  //   () => TransactionRepositoryImpl(
  //     databaseService: locator.get<DatabaseService>(),
  //     syncService: locator.get<SyncService>(),
  //   ),
  // );

  //Register Controllers

  locator.registerFactory<SplashController>(
    () => SplashController(
      // secureStorageService: const SecureStorageService(),
      // syncService: locator.get<SyncService>(),
    ),
  );

  // locator.registerFactory<SignInController>(
  //   () => SignInController(
  //     authService: locator.get<AuthService>(),
  //     secureStorageService: const SecureStorageService(),
  //     syncService: locator.get<SyncService>(),
  //   ),
  // );
  //
  // locator.registerFactory<SignUpController>(
  //   () => SignUpController(
  //     authService: locator.get<AuthService>(),
  //     secureStorageService: const SecureStorageService(),
  //   ),
  // );
  //
  // locator.registerLazySingleton<HomeController>(
  //   () => HomeController(
  //     transactionRepository: locator.get<TransactionRepository>(),
  //     syncService: SyncService(
  //       connectionService: const ConnectionService(),
  //       databaseService: locator.get<DatabaseService>(),
  //       graphQLService: locator.get<GraphQLService>(),
  //       secureStorageService: const SecureStorageService(),
  //     ),
  //   ),
  // );
  //
  // locator.registerLazySingleton<WalletController>(
  //   () => WalletController(
  //     transactionRepository: locator.get<TransactionRepository>(),
  //   ),
  // );
  //
  // locator.registerLazySingleton<BalanceController>(
  //   () => BalanceController(
  //     transactionRepository: locator.get<TransactionRepository>(),
  //   ),
  // );
  //
  // locator.registerLazySingleton<TransactionController>(
  //   () => TransactionController(
  //     transactionRepository: locator.get<TransactionRepository>(),
  //     storage: const SecureStorageService(),
  //   ),
  // );
}
