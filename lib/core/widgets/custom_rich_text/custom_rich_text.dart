import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String text;
  final String spanText;
  final VoidCallback onPressed;

  const CustomRichText({super.key, required this.text, required this.spanText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        children: [
          TextSpan(
            text: spanText,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = onPressed
          ),
        ],
      ),
    );
  }
}
