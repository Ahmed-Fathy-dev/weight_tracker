import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/src/core/enum/enums.dart';
import 'package:weight_tracker/src/core/utils/extensions_methods/app_extensions_m.dart';
import 'package:weight_tracker/src/core/utils/logger_util.dart';
import '../app/features/auth/logic/blocs/authorized_cubit/authorized_cubit.dart';
import '../core/Routers/route_name.dart';
import '../core/Routers/router.dart';
import '../core/Theme/app_theming.dart';
import '../providers.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const AppRootView();
    return MultiBlocProvider(
      providers: providers,
      child: const AppRootView(),
    );
  }
}

class AppRootView extends StatelessWidget {
  const AppRootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizedCubit, AuthStatus?>(
      builder: (context, state) {
        state?.initialRoute().logWtf('from root');
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppThemeData.lightThemeData,
          themeMode: ThemeMode.light,
          darkTheme: AppThemeData.darkThemeData,
          initialRoute: '/${RouteName.loginPage}',
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
