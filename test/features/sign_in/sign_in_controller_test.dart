import 'package:bolso_organizado/commons/data/data.dart';
import 'package:bolso_organizado/features/sign_in/sign_in_controller.dart';
import 'package:bolso_organizado/features/sign_in/sign_in_state.dart';
import 'package:bolso_organizado/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/mock_classes.dart';

void main() {
  late SignInController sut;
  late MockFirebaseAuthService mockAuthService;
  late MockSecureStorageService mockSecureStorageService;

  setUp(() {
    mockAuthService = MockFirebaseAuthService();
    mockSecureStorageService = MockSecureStorageService();

    sut = SignInController(
      authService: mockAuthService,
      secureStorageService: mockSecureStorageService,
    );
  });

  test('Test signIn success', () async {
    const email = 'test@example.com';
    const password = 'password';
    const userId = 'user123';

    when(() => mockAuthService.signIn(email: any(named: 'email'), password: any(named: 'password')))
        .thenAnswer((_) async => DataResult.success(UserModel(id: userId)));

    when(() => mockSecureStorageService.write(key: any(named: 'key'), value: any(named: 'value')))
        .thenAnswer((_) async => true);

    expect(sut.state, isInstanceOf<SignInStateInitial>());

    await sut.signIn(email: email, password: password);

    expect(sut.state, isInstanceOf<SignInStateLoading>());
  });

  test('Test signIn failure', () async {
    const email = 'test@example.com';
    const password = 'password';

    when(() => mockAuthService.signIn(email: any(named: 'email'), password: any(named: 'password')))
        .thenAnswer((_) async => DataResult.failure(const GeneralException()));

    expect(sut.state, isInstanceOf<SignInStateInitial>());

    await sut.signIn(email: email, password: password);

    expect(sut.state, isInstanceOf<SignInStateError>());
    verify(() => mockAuthService.signIn(email: email, password: password)).called(1);
    verifyNever(() => mockSecureStorageService.write(key: any(named: 'key'), value: any(named: 'value')));
  });
}
