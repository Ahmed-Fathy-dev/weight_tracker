import 'package:flutter/material.dart';
import 'package:weight_tracker/src/core/enum/enums.dart';
import 'package:weight_tracker/src/core/utils/logger_util.dart';

import '../../../app/features/auth/logic/model/local_user_model.dart';
import '../../../app/features/auth/logic/model/user_model.dart';
import '../../Routers/route_name.dart';
import '../../services/local_storage/box_storage.dart';

extension ContextUtils on BuildContext {
  ColorScheme get colorSchemes {
    return Theme.of(this).colorScheme;
  }

  TextTheme get txtTheme {
    return Theme.of(this).textTheme;
  }

  Size get mediaQSize {
    return MediaQuery.of(this).size;
  }
}

extension InitRoutFromAuthStatus on AuthStatus? {
  String initialRoute() {
    final authStatus = this;
    authStatus?.name.logWtf('from ext');
    if (authStatus == AuthStatus.auth && authStatus != null) {
      return '/${RouteName.homePage}';
    } else {
      return '/${RouteName.loginPage}';
    }
  }
}

extension CashedUserM on UserModel {
  CashedUserModel saveUserModel() {
    final userM = this;
    final userMConvert = CashedUserModel()
      ..id = userM.id
      ..name = userM.name
      ..token = userM.token!
      ..weightId = userM.weightModel?.id ?? ''
      ..weight = userM.weightModel?.weight ?? ''
      ..time = userM.weightModel?.time.toIso8601String() ?? '';
    logger.d(userMConvert);
    return userMConvert;
  }
}
