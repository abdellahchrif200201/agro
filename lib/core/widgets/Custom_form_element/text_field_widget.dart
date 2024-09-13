import 'package:devti_agro/core/config/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const TextFieldWidget({super.key, required this.controller, required this.hintText, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context).state.isDarkMode;

    return Container(
      decoration: BoxDecoration(border: Border.all(color: themeBloc ? Colors.white.withOpacity(0.4) : Colors.black.withOpacity(0.1)), borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        maxLines: maxLines,
      ),
    );
  }
}
