import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HorizontalListView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final double height;

  const HorizontalListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return SizedBox(
      height: height,
      child: Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent) {
            controller.animateTo(
              controller.offset + event.scrollDelta.dy,
              duration: const Duration(milliseconds: 80),
              curve: Curves.easeOut,
            );
          }
        },
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
          ),
          child: ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: itemBuilder,
          ),
        ),
      ),
    );
  }
}
