import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import '../../../../../core/constants/strings.dart';
import '../../../../components/widgets/alerts_dialogs.dart';

import '../widgets/actions_popup.dart';
import '../widgets/edite_weight_widget.dart';
import '../widgets/weight_item.dart';

class UsersWeightsList extends StatelessWidget {
  const UsersWeightsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => BounceInUp(
          child: WeightItem(
            popupMenu: ActionsPopupMenu(
              onDelete: () {
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return AlertsDialogActions(
                      title: AppStrings.confirmDeleteString,
                      description: AppStrings.deleteDescString('value'),
                      onYes: () {},
                    );
                  },
                );
              },
              onEdite: () {
                showModalBottomSheet(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return const EditeWeightWidget();
                  },
                );
              },
            ),
          ),
        ),
        childCount: 10,
      ),
    );
  }
}
