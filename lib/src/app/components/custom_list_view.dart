import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CustomListView<T> extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.getWidget,
    required this.data,
  });

  final Widget Function(int i) getWidget;
  final List<T> data;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(child: getWidget(index)),
          ),
        ),
        itemCount: data.length,
      ),
    );
  }
}
