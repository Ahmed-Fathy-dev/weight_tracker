import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weight_tracker/src/app/components/animations/shimmer_loading.dart';
import 'package:weight_tracker/src/app/features/auth/logic/blocs/authorized_cubit/authorized_cubit.dart';
import 'package:weight_tracker/src/app/features/auth/logic/blocs/login_cubit/login_cubit.dart';
import 'package:weight_tracker/src/app/features/auth/logic/blocs/logout_cubit/logout_cubit.dart';
import 'package:weight_tracker/src/app/features/auth/views/pages/login_page.dart';
import 'package:weight_tracker/src/app/features/home/logic/blocs/crud_weight_bloc/crud_weight_bloc.dart';
import 'package:weight_tracker/src/app/features/home/logic/blocs/get_user_info_cubit/get_user_info_cubit.dart';
import 'package:weight_tracker/src/app/features/home/logic/model/weight_model.dart';
import 'package:weight_tracker/src/core/Routers/routes.dart';
import 'package:weight_tracker/src/core/utils/extensions_methods/app_extensions_m.dart';
import 'package:weight_tracker/src/core/utils/extensions_methods/widget_ext.dart';
import 'package:weight_tracker/src/core/utils/logger_util.dart';
import 'package:weight_tracker/src/injection/injection_container.dart';

import '../../../../../core/constants/strings.dart';
import '../../../../../core/services/local_storage/box_storage.dart';
import '../../../../../core/services/network/response_status.dart';
import '../../../../components/widgets/custom_text_field.dart';
import '../../../auth/logic/model/user_model.dart';
import '../widgets/users_weights_section.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(
    //       AppStrings.homeString,
    //       style: context.txtTheme.titleLarge,
    //     ),
    //   ),
    //   body:const HomeBody(),
    // );
    return MultiBlocProvider(
      providers: [
        BlocProvider<LogoutCubit>(
          create: (context) => injector<LogoutCubit>(),
        ),
        BlocProvider<LoginCubit>.value(
          value: injector<LoginCubit>(),
        ),
      ],
      child: const Scaffold(
        body: _HomeBody(),
      ),
    );
  }
}

class _HomeBody extends HookWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    useMemoized(
      () {
        context.read<CrudWeightBloc>().add(FetchAllWeight());
        context.read<AuthorizedCubit>().redirectUser();
      },
    );
    final user = context.select((GetUserInfoCubit value) => value.state);

    final stateStatus =
        context.select((CrudWeightBloc value) => value.state.status);
    final updateStatus =
        context.select((CrudWeightBloc value) => value.state.canCreate);
    final scrollController = useScrollController();
    // final canCreate = useState<bool>(user?.weightModel?.weight == null);

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          context.read<CrudWeightBloc>().onPagination();
          logV('from listener sc controller');
        }
      });
      return;
    }, [scrollController]);
    stateStatus.logWtf('from homepage builder');
    if (stateStatus == const ResponseStatus.loading()) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }
    return CustomScrollView(
      controller: scrollController,
      slivers: <Widget>[
        SliverAppBar(
          title: const Text(AppStrings.homeString),
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          snap: true,
          pinned: false,
          floating: true,
          expandedHeight: 150,
          actions: [
            BlocConsumer<LogoutCubit, LogoutState>(
              listener: (context, state) {
                if (state.status == const ResponseStatus.success()) {
                  state.message.toastAlert(success: true);
                  context.pushAndRemoveStack(const LoginPage());
                } else if (state.status == const ResponseStatus.error()) {
                  state.message.toastAlert();
                }
              },
              builder: (context, state) {
                return state.status == const ResponseStatus.loading()
                    ? const CupertinoActivityIndicator()
                    : IconButton(
                        onPressed: () {
                          context.read<LogoutCubit>().logout();
                        },
                        icon: const Icon(Icons.logout_outlined),
                      );
              },
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size(0, 115),
            child: Container(
              height: updateStatus ? 125 : 80,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${AppStrings.welcomeUserString}  ',
                          style: context.txtTheme.titleLarge,
                        ),
                        TextSpan(
                          text: user?.name ?? '',
                          style: context.txtTheme.titleMedium
                              ?.copyWith(color: context.colorSchemes.primary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Visibility(
                    visible: updateStatus,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.addWeightString,
                          style: context.txtTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const _AddWeightWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const UsersWeightsList()
      ],
    );
  }
}

class _AddWeightWidget extends HookWidget {
  const _AddWeightWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((GetUserInfoCubit value) => value.state);

    user?.logWtf('user from builder');
    user?.logWtf('user from builder');
    final weightTxtState = useState<String>('');
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            onChanged: (String? val) {
              if (val != null) {
                weightTxtState.value = val;
              }
            },
            fieldKey: 'weight',
            name: AppStrings.weightString,
            keyboardType: TextInputType.number,
          ),
        ),
        BlocConsumer<CrudWeightBloc, CrudWeightState>(
          listenWhen: (previous, current) =>
              previous.updateStatus != current.updateStatus,
          listener: (context, state) {
            if (state.updateStatus == const ResponseStatus.success()) {
              context.read<CrudWeightBloc>().add(CanCreate(false));
              state.message.toastAlert(success: true);
            }
          },
          builder: (context, state) {
            return state.updateStatus == const ResponseStatus.loading()
                ? const CupertinoActivityIndicator()
                : IconButton(
                    color: context.colorSchemes.primary,
                    onPressed: weightTxtState.value.isEmpty
                        ? null
                        : () {
                            context.read<CrudWeightBloc>().add(
                                  CreateNewWeight(
                                    UserModel(
                                      id: user!.id,
                                      name: user.name,
                                      token: user.token,
                                      weightModel: WeightModel(
                                        id: user.id,
                                        weight: weightTxtState.value,
                                        time: DateTime.now(),
                                      ),
                                    ),
                                  ),
                                );
                          },
                    icon: const Icon(Icons.send),
                  );
          },
        ),
      ],
    );
  }
}
