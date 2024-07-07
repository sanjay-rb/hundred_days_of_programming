import 'package:flutter/material.dart';

class UiBarWidget extends StatelessWidget {
  const UiBarWidget(
      {super.key, this.isHorizontal = true, required this.length});

  final bool isHorizontal;
  final double length;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isHorizontal ? length : 2,
      height: isHorizontal ? 2 : length,
      child: ColoredBox(
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}
