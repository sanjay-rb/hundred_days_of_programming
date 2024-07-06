import 'package:flutter/material.dart';

class UiButtonWidget extends StatelessWidget {
  const UiButtonWidget({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.color,
    required this.onTap,
  });

  final Widget text;
  final double width, height;
  final Color color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: width,
        height: height,
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: text,
          ),
        ),
      ),
    );
  }
}
