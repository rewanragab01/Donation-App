import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? shadowColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final String buttonText;
  final TextStyle textStyle;
  final VoidCallback onPressed;
  const AppTextButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonHeight,
    this.buttonWidth,
    required this.buttonText,
    required this.textStyle,
    required this.onPressed,
    this.borderColor,
    this.icon,
    this.iconColor,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
            // side: BorderSide(color: borderColor ?? Colors.white)
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(
          backgroundColor ?? Colors.black,
        ),
        // padding: MaterialStateProperty.all<EdgeInsets>(
        //   EdgeInsets.symmetric(
        //     horizontal: horizontalPadding ?? 12,
        //     vertical: verticalPadding ?? 0,
        //   ),
        // ),
        fixedSize: MaterialStateProperty.all(
          Size(buttonWidth ?? double.maxFinite, buttonHeight ?? 60),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center the text horizontally
        children: [
          if (icon != null) Icon(icon, color: iconColor),
          Text(
            buttonText,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
