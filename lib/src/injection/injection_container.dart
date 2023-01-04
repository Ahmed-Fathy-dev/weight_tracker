import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:weight_tracker/src/app/features/auth/logic/blocs/authorized_cubit/authorized_cubit.dart';
import 'package:weight_tracker/src/app/features/auth/logic/blocs/logout_cubit/logout_cubit.dart';
import 'package:weight_tracker/src/app/features/auth/logic/repo/auth_repo.dart';

import '../app/features/auth/logic/blocs/login_cubit/login_cubit.dart';
import '../app/features/home/logic/blocs/crud_weight_bloc/crud_weight_bloc.dart';
import '../app/features/home/logic/blocs/get_user_info_cubit/get_user_info_cubit.dart';
import '../core/services/firebase/firebase_auth_service.dart';

final injector = GetIt.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class InjectorFile {
  Future<void> injectorFile() async {
    _coreService;
    _authService;
    _weightService;
  }
}

//Core Service
void get _coreService async {
  injector.registerSingleton<FirebaseAuth>(_auth);
  injector.registerSingleton<FirebaseAuthService>(
    FirebaseAuthService(
      injector<FirebaseAuth>(),
    ),
  );
  // injector.registerSingleton<______>(__);
  // injector.registerSingleton<______>(__);
  // injector.registerSingleton<______>(__);
}

// Auth Service
void get _authService {
  injector.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(injector<FirebaseAuthService>()),
  );
  injector.registerFactory<LoginCubit>(
    () => LoginCubit(
      injector<AuthRepo>(),
    ),
  );
  injector.registerFactory<LogoutCubit>(
    () => LogoutCubit(
      injector<AuthRepo>(),
    ),
  );
  injector.registerFactory<AuthorizedCubit>(
    () => AuthorizedCubit(
      injector<FirebaseAuthService>(),
    ),
  );
}

// weight Service
void get _weightService {
  injector.registerFactory<GetUserInfoCubit>(
    () => GetUserInfoCubit(),
  );
  injector.registerFactory<CrudWeightBloc>(
    () => CrudWeightBloc(),
  );
}
