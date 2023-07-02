import 'package:bolso_organizado/commons/data/data.dart';
import 'package:bolso_organizado/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  FirebaseAuthService() : _auth = FirebaseAuth.instance;

  final FirebaseAuth _auth;

  @override
  Future<DataResult<UserModel>> signIn({ required String email, required String password,}) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password,);

      if (result.user != null) {
        return DataResult.success(_createUserModelFromAuthUser(result.user!));
      }

      return DataResult.failure(const GeneralException());
    } on FirebaseAuthException catch (e) {
      return DataResult.failure(AuthException(code: e.code));
    }
  }

  @override
  Future<DataResult<UserModel>> signUp({
    String? name,
    required String email,
    required String password,
  }) async {
    try {
      // await _functions.httpsCallable('registerUser').call({
      //   "email": email,
      //   "password": password,
      //   "displayName": name,
      // });

      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        return DataResult.success(_createUserModelFromAuthUser(result.user!));
      }

      return DataResult.failure(const GeneralException());
    } on FirebaseAuthException catch (e) {
      return DataResult.failure(AuthException(code: e.code));
    } on Exception catch (e) {
      return DataResult.failure(AuthException(code: ""));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DataResult<String>> userToken() async {
    try {
      final token = await _auth.currentUser?.getIdToken();

      return DataResult.success(token ?? '');
    } catch (e) {
      return DataResult.success('');
    }
  }

  UserModel _createUserModelFromAuthUser(User user) {
    return UserModel(
      name: user.displayName,
      email: user.email,
      id: user.uid,
    );
  }
}
