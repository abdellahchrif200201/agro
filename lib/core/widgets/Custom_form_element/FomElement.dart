// import 'package:devti_agro/features/Etiquetage/presontation/widgets/LocalContainer.dart';
// import 'package:flutter/material.dart';

// class FormElement extends StatelessWidget {
//   final String label;
//   final String hint;
//   final int? maxLines;
//   final Widget? child; // Add this parameter to allow custom children
//   final TextEditingController? controller;
//   final TextStyle? textStyle;
//   final TextInputType? keyboardType;
//   const FormElement(
//       {super.key,
//       required this.hint,
//       this.controller,
//       required this.label,
//       this.maxLines,
//       this.child, // Initialize the new parameter
//       this.textStyle,
//       this.keyboardType});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       // crossAxisAlignment: maxLines != null ? maxLines! > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center :nll,
//       children: [
//         Expanded(
//           flex: 3,
//           child: Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: Text(
//               label,
//               style: textStyle ?? Theme.of(context).textTheme.titleSmall,
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 5,
//           child: LocalContainer(
//             child: child ??
//                 TextField(
//                   controller: controller,
//                   maxLines: 4,
//                   keyboardType: keyboardType,
//                   decoration: InputDecoration(
//                     hintText: hint,
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                     border: InputBorder.none,
//                   ),
//                 ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:devti_agro/features/Etiquetage/presontation/widgets/LocalContainer.dart';
import 'package:flutter/material.dart';

class FormElement extends StatelessWidget {
  final String label;
  final String hint;
  final int? maxLines; // The maxLines parameter is defined here
  final Widget? child; // Allow custom children
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;
  final double? height;

  const FormElement(
      {super.key,
      required this.hint,
      this.controller,
      required this.label,
      this.maxLines, // maxLines can be passed as an argument
      this.child, // Initialize the new parameter
      this.textStyle,
      this.keyboardType,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: height != null ? CrossAxisAlignment.start : CrossAxisAlignment.center,
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
            height: height,
            child: child ??
                TextField(
                  controller: controller,
                  maxLines: maxLines ?? 1, // Use the maxLines parameter here, with a default value of 1
                  keyboardType: keyboardType,
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
