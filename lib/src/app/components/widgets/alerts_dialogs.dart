import 'package:flutter/cupertino.dart';
import 'package:weight_tracker/src/core/Routers/routes.dart';

import '../../../core/constants/strings.dart';

class AlertsDialogActions extends StatelessWidget {
  const AlertsDialogActions({
    super.key,
    required this.title,
    required this.description,
    required this.onYes,
  });
  final String title;
  final String description;
  final void Function() onYes;
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(
        description,
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: onYes,
          child: const Text(AppStrings.yesString),
        ),
        CupertinoDialogAction(
          child: const Text(AppStrings.noString),
          onPressed: () {
            context.pop();
          },
        ),
      ],
    );
  }
}

// class CustomAlertsDialog extends StatelessWidget {
//   const CustomAlertsDialog({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.onYes,
//   });
//   final String title;
//   final String description;
//   final void Function() onYes;
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Column(
//         children: [
//           Text(title),
//           Text(
//             description,
//           ),
//           const Divider(),
//           Row(
//             children: [
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.done),
//               ),
//               const VerticalDivider(),
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.cancel_outlined),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
