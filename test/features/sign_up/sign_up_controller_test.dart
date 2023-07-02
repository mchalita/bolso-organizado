import 'package:bolso_organizado/commons/data/data.dart';
import 'package:bolso_organizado/features/sign_up/sign_up_controller.dart';
import 'package:bolso_organizado/features/sign_up/sign_up_state.dart';
import 'package:bolso_organizado/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/mock_classes.dart';

void main() {
  late SignUpController sut;
  late MockFirebaseAuthService mockAuthService;
  late MockSecureStorageService mockSecureStorageService;

  setUp(() {
    mockAuthService = MockFirebaseAuthService();
    mockSecureStorageService = MockSecureStorageService();

    sut = SignUpController(
      authService: mockAuthService,
      secureStorageService: mockSecureStorageService,
    );
  });

  test('Test signUp success', () async {
    const name = 'John Doe';
    const email = 'test@example.com';
    const password = 'password';
    const userId = 'user123';

    when(() => mockAuthService.signUp(name: any(named: 'name'), email: any(named: 'email'), password: any(named: 'password')))
        .thenAnswer((_) async => DataResult.success(UserModel(id: userId)));

    when(() => mockSecureStorageService.write(key: any(named: 'key'), value: any(named: 'value')))
        .thenAnswer((_) async => true);

    expect(sut.state, isInstanceOf<SignUpStateInitial>());

    await sut.signUp(name: name, email: email, password: password);

    expect(sut.state, isInstanceOf<SignUpStateLoading>());
  });

  test('Test signUp failure', () async {
    const name = 'John Doe';
    const email = 'test@example.com';
    const password = 'password';
    const errorMessage = 'Invalid credentials';

    when(() => mockAuthService.signUp(name: any(named: 'name'), email: any(named: 'email'), password: any(named: 'password')))
        .thenAnswer((_) async => DataResult.failure(const GeneralException()));

    expect(sut.state, isInstanceOf<SignUpStateInitial>());

    await sut.signUp(name: name, email: email, password: password);

    expect(sut.state, isInstanceOf<SignUpStateError>());
    verify(() => mockAuthService.signUp(name: name, email: email, password: password)).called(1);
    verifyNever(() => mockSecureStorageService.write(key: any(named: 'key'), value: any(named: 'value')));
  });
}
