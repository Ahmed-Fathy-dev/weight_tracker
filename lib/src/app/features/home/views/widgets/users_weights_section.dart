import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/src/app/features/home/logic/blocs/crud_weight_bloc/crud_weight_bloc.dart';
import 'package:weight_tracker/src/core/Routers/routes.dart';
import 'package:weight_tracker/src/core/utils/extensions_methods/widget_ext.dart';
import 'package:weight_tracker/src/core/utils/logger_util.dart';

import '../../../../../core/constants/strings.dart';
import '../../../../../core/services/network/response_status.dart';
import '../../../../components/animations/shimmer_loading.dart';
import '../../../../components/widgets/alerts_dialogs.dart';

import '../../../../components/widgets/empty_data_w.dart';
import '../../logic/blocs/get_user_info_cubit/get_user_info_cubit.dart';
import '../widgets/actions_popup.dart';
import '../widgets/edite_weight_widget.dart';
import '../widgets/weight_item.dart';

class UsersWeightsList extends StatelessWidget {
  const UsersWeightsList({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((GetUserInfoCubit value) => value.state);

    logD('$user from builder');
    return BlocConsumer<CrudWeightBloc, CrudWeightState>(
      listenWhen: (previous, current) =>
          previous.deleteStatus != current.deleteStatus,
      listener: (context, state) {
        if (state.deleteStatus == const ResponseStatus.success()) {
          context.read<CrudWeightBloc>().add(CanCreate(true));
          state.message.toastAlert(success: true);
        }
      },
      builder: (context, state) {
        return state.users.isEmpty
            ? SliverToBoxAdapter(
                child: ZoomIn(
                child: const EmptyW(
                  text: 'Empty List',
                ),
              ))
            : SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  state.users.length.logD('users length');
                  return index >= state.users.length
                      ? const CupertinoActivityIndicator()
                      : BounceInUp(
                          child: WeightItem(
                            popupMenu: user?.id != state.users[index].id
                                ? null
                                : ActionsPopupMenu(
                                    onDelete: () {
                                      showCupertinoDialog(
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return AlertsDialogActions(
                                            title:
                                                AppStrings.confirmDeleteString,
                                            description:
                                                AppStrings.deleteDescString(
                                                    'value'),
                                            onYes: () {
                                              context
                                                  .read<CrudWeightBloc>()
                                                  .add(DeleteMyWeight(
                                                      state.users[index]));
                                              context.pop();
                                            },
                                          );
                                        },
                                      );
                                    },
                                    onEdite: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return EditeWeightWidget(
                                            user: state.users[index],
                                          );
                                        },
                                      );
                                    },
                                  ),
                            user: state.users[index],
                          ),
                        );
                }, childCount: state.users.length),
              );
      },
    );
  }
}
