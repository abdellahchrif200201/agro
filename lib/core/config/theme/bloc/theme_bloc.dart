import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc(bool isDark) : super(isDark ? ThemeMode.dark : ThemeMode.light) {
    on<ThemeChanged>((event, emit) async {
      emit(event.isDark ? ThemeMode.dark : ThemeMode.light);

      // Save the theme preference in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDark', event.isDark);
    });
  }
}
