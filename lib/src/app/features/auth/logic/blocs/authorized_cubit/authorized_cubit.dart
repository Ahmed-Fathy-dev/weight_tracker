import 'package:bloc/bloc.dart';
import 'package:weight_tracker/src/core/utils/logger_util.dart';

import '../../../../../../core/enum/enums.dart';
import '../../../../../../core/services/firebase/firebase_auth_service.dart';
import '../../../../../../core/services/local_storage/box_storage.dart';

class AuthorizedCubit extends Cubit<AuthStatus?> {
  AuthorizedCubit(this._auth) : super(null);

  final FirebaseAuthService _auth;

  void getAuthStatus() async {
    final status = await _auth.isSignedIn();
    status.logWtf('from Cubit');
    if (status) {
      status.logWtf('from Cubit');
      emit(AuthStatus.auth);
    } else {
      status.logWtf('from Cubit');
      emit(AuthStatus.unAuth);
    }
  }
  
}
