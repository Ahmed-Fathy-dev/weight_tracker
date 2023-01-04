import 'package:flutter/material.dart';

import '../../app/features/auth/views/pages/login_page.dart';
import '../../app/features/home/views/pages/homepage.dart';
import 'route_name.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/${RouteName.loginPage}':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/${RouteName.homePage}':
        return MaterialPageRoute(builder: (_) => const Homepage());
      // case '/${RouteName.}':
      // return MaterialPageRoute(builder: (_) => const ());
      // case '/${}':
      // return MaterialPageRoute(builder: (_) =>const ());
      default:
        return MaterialPageRoute(
          builder: (_) => const ErrorScaffold(
            body: Text('Error Page Route'),
          ),
        );
    }
  }
}

class ErrorScaffold extends StatelessWidget {
  const ErrorScaffold({
    required this.body,
    Key? key,
  }) : super(key: key);

  final Widget body;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Page Not Found'),
        ),
        body: body,
      );
}
