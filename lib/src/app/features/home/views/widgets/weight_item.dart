import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../auth/logic/model/user_model.dart';
import 'actions_popup.dart';

class WeightItem extends StatelessWidget {
  const WeightItem({
    super.key,
    required this.popupMenu,
    required this.user,
  });
  final ActionsPopupMenu? popupMenu;
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    final timeFormated =
        DateFormat.yMEd().add_jms().format(user.weightModel!.time);
    return ListTile(
      leading: Text(user.name),
      title: Text(user.weightModel!.weight),
      subtitle: Text(timeFormated),
      trailing: popupMenu ?? const SizedBox.shrink(),
    );
  }
}
