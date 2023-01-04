import 'package:flutter/material.dart';

import '../../../core/services/network/response_status.dart';

class AnimatedContainerW extends StatelessWidget {
  const AnimatedContainerW({
    super.key,
    required this.child,
    this.height = 55,
    required this.status,
    required this.widthOut,
    required this.widthIn,
  });
  final Widget child;
  final double widthOut;
  final double widthIn;
  final double height;
  final bool status;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // alignment: Alignment.center,
      duration: const Duration(milliseconds: 500),
      curve: Curves.elasticInOut,
      width: status ? widthOut : widthIn,
      height: height,
      child: child,
    );
  }
}

class BtnAnimationStatus extends AnimatedContainerW {
  BtnAnimationStatus({
    super.key,
    required BuildContext context,
    required ResponseStatus status,
    required Widget child,
  }) : super(
          child: child,
          widthOut: MediaQuery.of(context).size.width * .2,
          widthIn: MediaQuery.of(context).size.width,
          status: status == const ResponseStatus.loading(),
        );
}
