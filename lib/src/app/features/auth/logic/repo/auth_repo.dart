import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/constants/strings.dart';
import '../../../../../core/services/firebase/firebase_auth_service.dart';
import '../../../../../core/services/network/exception_dio_message.dart';
import '../model/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> loginRepo(String username);
  Future<Either<Failure, String>> logout();
}

class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl(this._auth);

  final FirebaseAuthService _auth;

  @override
  Future<Either<Failure, UserModel>> loginRepo(String username) async {
    try {
      final response = await _auth.firebaseLogin(username);
      return Right(response);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.fromCode(e));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      await _auth.firebaseLogout();
      return const Right(AppStrings.logoutSuccesString);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.fromCode(e));
    }
  }
}
