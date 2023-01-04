import 'package:flutter/material.dart';

import 'actions_popup.dart';

class WeightItem extends StatelessWidget {
  const WeightItem({
    super.key,
    required this.popupMenu,
  });
  final ActionsPopupMenu popupMenu;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('name'),
      subtitle: Text('65'),
      trailing: popupMenu,
    );
  }
}
