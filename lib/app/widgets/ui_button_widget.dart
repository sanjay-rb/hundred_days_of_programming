import 'package:flutter/material.dart';

class UiButtonWidget extends StatelessWidget {
  const UiButtonWidget({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.onTap,
  });

  final String text;
  final double width, height;
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
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
