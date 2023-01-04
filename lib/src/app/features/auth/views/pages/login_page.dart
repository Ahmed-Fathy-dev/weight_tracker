import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weight_tracker/src/app/features/home/logic/blocs/get_user_info_cubit/get_user_info_cubit.dart';
import 'package:weight_tracker/src/app/features/home/views/pages/homepage.dart';
import 'package:weight_tracker/src/core/Routers/routes.dart';
import 'package:weight_tracker/src/core/utils/extensions_methods/app_extensions_m.dart';
import 'package:weight_tracker/src/core/utils/extensions_methods/widget_ext.dart';
import 'package:weight_tracker/src/injection/injection_container.dart';

import '../../../../../core/constants/strings.dart';
import '../../../../../core/services/network/response_status.dart';
import '../../../../../core/utils/logger_util.dart';
import '../../../../components/animations/animation_cotainers.dart';
import '../../../../components/widgets/custom_text_field.dart';
import '../../../home/logic/blocs/crud_weight_bloc/crud_weight_bloc.dart';
import '../../logic/blocs/login_cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => injector<LoginCubit>(),
      child: const Scaffold(
        body: SafeArea(
          child: LoginBody(),
        ),
      ),
    );
  }
}

class LoginBody extends HookWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    // final usernameController = useTextEditingController();
    return FormBuilder(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              AppStrings.welcomeString,
              style: context.txtTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const CustomTextField(
              // controller: usernameController,
              fieldKey: 'name',
              name: AppStrings.usernameString,
            ),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.status == const ResponseStatus.success()) {
                  if (state.user != null) {
                    context.read<GetUserInfoCubit>().getUserInfo(state.user!);
                    context.read<CrudWeightBloc>().add(FetchAllWeight());
                  }
                  context.pushAndRemoveStack(const Homepage());
                  state.message.toastAlert(success: true);
                } else if (state.status == const ResponseStatus.error()) {
                  state.message.toastAlert();
                }
              },
              builder: (context, state) {
                return BtnAnimationStatus(
                  context: context,
                  status: state.status,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: context.txtTheme.titleLarge,
                      minimumSize: const Size(
                        double.infinity,
                        55,
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        context
                            .read<LoginCubit>()
                            .login(formKey.currentState?.value['name']);
                      } else {
                        logger.d('inValid');
                      }
                    },
                    child: state.status == const ResponseStatus.loading()
                        ? const CircularProgressIndicator()
                        : const Text(
                            AppStrings.loginString,
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
