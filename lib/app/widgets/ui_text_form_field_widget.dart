import 'package:flutter/material.dart';

class UiTextFormFieldWidget extends StatelessWidget {
  const UiTextFormFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.textColor,
    required this.bgColor,
    required this.icon,
    this.isPassword = false,
    this.isEditable = true,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final Color textColor;
  final Color bgColor;
  final IconData icon;
  final bool isPassword;
  final bool isEditable;
  final Function? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
      enabled: isEditable,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: label,
        hintStyle:
            Theme.of(context).textTheme.bodyLarge!.copyWith(color: textColor),
        filled: true,
        fillColor: bgColor.withOpacity(.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(
          icon,
          color: textColor,
        ),
      ),
      cursorColor: textColor,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: textColor),
    );
  }
}
