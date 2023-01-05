import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracker/src/app/features/auth/logic/repo/auth_repo.dart';
import 'package:weight_tracker/src/app/features/home/logic/model/weight_model.dart';

import '../../../../../../core/services/network/response_status.dart';
import '../../model/user_model.dart';
import '../../../../../../core/enum/enums.dart';
import '../../../../../../core/services/firebase/firebase_auth_service.dart';
import '../../../../../../core/services/local_storage/box_storage.dart';
import 'package:weight_tracker/src/core/utils/logger_util.dart';

part 'authorized_state.dart';

class AuthorizedCubit extends Cubit<AuthorizedState> {
  AuthorizedCubit(this._auth) : super(const AuthorizedState());

  final AuthRepo _auth;

  final tokenBox = Boxes.getTokenState();
  final userBox = Boxes.getCashedUserModel();

  void redirectUser() async {
    final token = tokenBox.get(tokenKey);
    final userCached = userBox.get(userMKey);

    if (token != null) {
      final response = await _auth.linkWithCredentialRepo();
      response.fold((error) {
        emit(state.copyWith(status: const ResponseStatus.error()));
      }, (success) async {
        logger.d(token, 'token from auth cubit');
        logger.d(success?.uid, 'success.uid from auth cubit');
        if (success != null && success.uid == userCached!.id) {
          final tokenM = await success.getIdToken();
          final user = UserModel(
            id: userCached.id,
            name: userCached.name,
            token: tokenM,
            weightModel: WeightModel(
              id: userCached.weightId!,
              weight: userCached.weight,
              time: DateTime.now(),
            ),
          );
          logger.d(user, 'user from auth cubit');
          logger.d(userCached.toString(), 'userCached from auth cubit');
          emit(
            state.copyWith(
              status: const ResponseStatus.success(),
              user: user,
            ),
          );
        }
      });
    }
  }
  // void getAuthStatus() async {
  //   final status = await _auth.isSignedIn();
  //   status.logWtf('from Cubit');
  //   if (status) {
  //     status.logWtf('from Cubit');
  //     emit(AuthStatus.auth);
  //   } else {
  //     status.logWtf('from Cubit');
  //     emit(AuthStatus.unAuth);
  //   }
  // }
}
