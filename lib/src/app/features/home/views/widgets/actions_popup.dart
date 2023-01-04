import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weight_tracker/src/core/Routers/routes.dart';
import 'package:weight_tracker/src/core/utils/logger_util.dart';

import '../../../../../core/constants/strings.dart';
import '../../../../../core/enum/enums.dart';

class ActionsPopupMenu extends HookWidget {
  const ActionsPopupMenu({
    super.key,
    required this.onEdite,
    required this.onDelete,
  });
  final void Function() onEdite;
  final void Function() onDelete;
  @override
  Widget build(BuildContext context) {
    final selectedMenu = useState<ActionsMenu?>(null);
    return PopupMenuButton<ActionsMenu>(
      initialValue: selectedMenu.value,
      // Callback that sets the selected popup menu item.
      onSelected: (ActionsMenu item) {
        logger.logWtf(item.name);
        selectedMenu.value = item;
        if (selectedMenu.value == ActionsMenu.edite) {
          onEdite();
        } else {
          onDelete();
        }

        logger.logWtf(selectedMenu.value!.name);
      },
      elevation: 8,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<ActionsMenu>>[
        PopupMenuItem<ActionsMenu>(
          value: ActionsMenu.edite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.edit),
              Text(AppStrings.editeString),
            ],
          ),
        ),
        PopupMenuItem<ActionsMenu>(
          value: ActionsMenu.delete,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.delete_forever_outlined),
              Text(AppStrings.deleteString),
            ],
          ),
        ),
      ],
    );
  }
}
