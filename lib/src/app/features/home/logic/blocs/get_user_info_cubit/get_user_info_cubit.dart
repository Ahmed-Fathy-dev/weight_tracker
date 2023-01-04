import 'package:bloc/bloc.dart';
import 'package:weight_tracker/src/core/utils/extensions_methods/app_extensions_m.dart';

import '../../../../../../core/services/local_storage/box_storage.dart';
import '../../../../auth/logic/model/user_model.dart';
import '../../model/weight_model.dart';

class GetUserInfoCubit extends Cubit<UserModel?> {
  GetUserInfoCubit() : super(null);
  final userBox = Boxes.getCashedUserModel();

  void getUserInfo(UserModel user) {
    final userModel = UserModel(
      id: user.id,
      name: user.name,
      token: user.token,
      weightModel: user.weightModel,
    );
    final userMConvert = user.saveUserModel();
    userBox.put(userMKey, userMConvert);
    emit(userModel);
  }

  void getFromCach() {
    final userM = userBox.get(userMKey);
    emit(
      UserModel(
        id: userM!.id,
        name: userM.name,
        token: userM.token,
        weightModel: WeightModel(
            id: userM.weightId!,
            weight: userM.weight,
            time: DateTime.now()),
      ),
    );
  }
}
