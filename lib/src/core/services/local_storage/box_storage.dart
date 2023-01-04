import 'package:hive/hive.dart';

import '../../../app/features/auth/logic/model/local_user_model.dart';


const authKey = 'authKey';
const userMKey = 'UserModel';
const tokenKey = 'TOKEN';
const userMTypeId = 0;

class Boxes {
  static Box<bool> getAuthState() => Hive.box<bool>(authKey);
  static Box<String> getTokenState() => Hive.box<String>(tokenKey);
  static Box<CashedUserModel> getCashedUserModel() =>
      Hive.box<CashedUserModel>(userMKey);

  static Future<void> openBoxes() async {
    await Hive.openBox<bool>(authKey);
    await Hive.openBox<String>(tokenKey);
    await Hive.openBox<CashedUserModel>(userMKey);
  }
}
