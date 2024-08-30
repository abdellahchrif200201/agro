import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Widget? child;
  final Color? textColor;
  final bool border;
  final Color? borderColor;

  const CustomButton({super.key, required this.text, required this.onPressed, this.backgroundColor, this.child, this.textColor = Colors.white, this.border = false, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.green,
          borderRadius: BorderRadius.circular(10),
          border: border
              ? Border.all(color: borderColor ?? Colors.black) // Define color or other properties if needed
              : Border.all(color: Colors.transparent), // No border or set transparent if not needed
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: textColor,
                  ),
            ),
            if (child != null)
              const SizedBox(
                width: 10,
              ),
            if (child != null) child!
          ],
        ),
      ),
    );
  }
}
