import 'package:flutter/material.dart';

class TextFieldUserWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;
  const TextFieldUserWidget({super.key , required this.controller ,required this.hint , required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}