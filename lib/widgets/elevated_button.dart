import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class ReusableElevatedButton extends StatelessWidget {
  final void Function() onPressed;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final String text;
  final bool isLoading;

  const ReusableElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(
      vertical: 12,
    ),
    this.backgroundColor = blueColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: backgroundColor,
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                color: primaryColor,
                strokeWidth: 2,
              )
            : Text(text),
      ),
    );
  }
}
