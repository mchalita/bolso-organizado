import 'package:bolso_organizado/models/user_model.dart';
import 'package:bolso_organizado/repositories/transaction_repository.dart';
import 'package:bolso_organizado/services/auth_service.dart';
import 'package:bolso_organizado/services/secure_storage.dart';
import 'package:bolso_organizado/services/transaction_service.dart';
import 'package:mocktail/mocktail.dart';

class MockUser extends Mock implements UserModel {}

class MockFirebaseAuthService extends Mock implements AuthService {}
class MockTransactionService extends Mock implements TransactionService {}
class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockTransactionRepository extends Mock implements TransactionRepository {}
