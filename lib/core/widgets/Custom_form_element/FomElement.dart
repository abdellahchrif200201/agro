import 'package:devti_agro/features/Etiquetage/presontation/widgets/LocalContainer.dart';
import 'package:flutter/material.dart';

class FormElement extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final Widget? child; // Add this parameter to allow custom children
  final TextEditingController? controller;
  final TextStyle? textStyle;

  const FormElement(
      {super.key,
      required this.hint,
      this.controller,
      required this.label,
      this.maxLines = 1,
      this.child, // Initialize the new parameter
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: maxLines > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              label,
              style: textStyle ?? Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: LocalContainer(
            child: child ??
                TextField(
                  controller: controller,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    hintText: hint,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    border: InputBorder.none,
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
