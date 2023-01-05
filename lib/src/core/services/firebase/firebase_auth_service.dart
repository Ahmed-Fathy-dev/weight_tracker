import 'package:firebase_auth/firebase_auth.dart';

import '../../../app/features/auth/logic/model/user_model.dart';
import '../../utils/logger_util.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService(this._firebaseAuth);

  Future<UserModel> firebaseLogin(String username) async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    final token = await userCredential.user!.getIdToken();
    final userModel = UserModel(
      id: userCredential.user!.uid,
      token: token,
      name: username,
    );
    userModel.logD('from service firebase');
    return userModel;
  }

  Future<bool> isSignedIn() async {
    bool authStatus = false;
    authStatus.logW('before stream');
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      logger.w('User is currently signed out!');
      authStatus = false;
    } else {
      logger.w('User is signed in!');
      authStatus = true;
    }
    // _firebaseAuth.idTokenChanges().listen((User? user) {
    //   if (user == null) {
    //     logger.w('User is currently signed out!');
    //     authStatus = false;
    //   } else {
    //     logger.w('User is signed in!');
    //     authStatus = true;
    //   }
    // });
    authStatus.logW('after stream');
    return authStatus;
  }

  Future<User?> linkWithCredential() async {
    final currentUser = _firebaseAuth.currentUser;

    return currentUser;
  }

  Future<void> firebaseLogout() async {
    await _firebaseAuth.signOut();
  }
}
