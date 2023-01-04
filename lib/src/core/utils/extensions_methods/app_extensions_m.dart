import 'package:flutter/material.dart';
import 'package:weight_tracker/src/core/enum/enums.dart';
import 'package:weight_tracker/src/core/utils/logger_util.dart';

import '../../Routers/route_name.dart';

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
