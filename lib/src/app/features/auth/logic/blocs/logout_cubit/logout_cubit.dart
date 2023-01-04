import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/services/network/response_status.dart';
import '../../repo/auth_repo.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this._repo) : super(const LogoutState());

  final AuthRepo _repo;

  void logout() async {
    emit(
      state.copyWith(
        status: const ResponseStatus.loading(),
      ),
    );

    final response = await _repo.logout();

    response.fold((failed) {
      emit(state.copyWith(
        status: const ResponseStatus.error(),
        message: failed.message,
      ));
    }, (success) {
      emit(
        state.copyWith(
            status: const ResponseStatus.success(), message: success),
      );
    });
  }
}
