import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weight_tracker/src/app/features/auth/logic/repo/auth_repo.dart';

import '../../../../../../core/constants/strings.dart';
import '../../../../../../core/services/network/response_status.dart';
import '../../model/user_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._repo) : super(const LoginState());

  final AuthRepo _repo;

  void login(String username) async {
    emit(
      state.copyWith(
        status: const ResponseStatus.loading(),
      ),
    );

    final response = await _repo.loginRepo(username);

    response.fold((failed) {
      emit(state.copyWith(
        status: const ResponseStatus.error(),
        message: failed.message,
      ));
    }, (success) {
      emit(
        state.copyWith(
            status: const ResponseStatus.success(),
            user: success,
            message: AppStrings.loginSuccesString),
      );
    });
  }
}
