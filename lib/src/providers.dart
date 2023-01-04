import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/features/auth/logic/blocs/authorized_cubit/authorized_cubit.dart';
import 'app/features/home/logic/blocs/crud_weight_bloc/crud_weight_bloc.dart';
import 'app/features/home/logic/blocs/get_user_info_cubit/get_user_info_cubit.dart';
import 'injection/injection_container.dart';

// import 'injection/injection_container.dart';

List<BlocProvider> providers = [
  BlocProvider<AuthorizedCubit>(
    create: (context) => injector<AuthorizedCubit>()..getAuthStatus(),
  ),
  BlocProvider<GetUserInfoCubit>(
    create: (_) => injector<GetUserInfoCubit>(),
  ),
  BlocProvider<CrudWeightBloc>(
    create: (context) => injector<CrudWeightBloc>(),
  ),
//   BlocProvider(
//     create: (_) => injector<_____>()..add(_____()),
//   )
];
