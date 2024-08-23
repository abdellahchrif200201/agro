import 'package:devti_agro/features/Etiquetage/presontation/widgets/LocalContainer.dart';
import 'package:flutter/material.dart';



class FormElement extends StatelessWidget {
  final String label;
  final String hint;
  const FormElement({super.key , required this.hint , required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        LocalContainer(
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}