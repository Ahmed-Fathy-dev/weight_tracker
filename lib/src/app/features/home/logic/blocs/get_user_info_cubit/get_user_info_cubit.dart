import 'package:bloc/bloc.dart';

import '../../../../auth/logic/model/user_model.dart';


class GetUserInfoCubit extends Cubit<UserModel?> {
  GetUserInfoCubit() : super(null);

  void getUserInfo(UserModel user) {
    final userModel = UserModel(
      id: user.id,
      name: user.name,
      token: user.token,
      weightModel: user.weightModel,
    );
    emit(userModel);
  }
}
