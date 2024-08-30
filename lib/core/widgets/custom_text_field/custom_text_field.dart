import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final String hintText;
  final bool obscureText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final TextInputType? keyboardType;

  const CustomTextField({super.key, required this.controller, this.labelText, required this.hintText, this.obscureText = false, this.prefixIcon, this.suffixIcon, this.keyboardType});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType ?? null,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                icon: widget.suffixIcon!,
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
