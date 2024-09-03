import 'package:bloc/bloc.dart';
import 'package:devti_agro/core/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
          themeData: _buildTheme(false),
          isDarkMode: false,
        )) {
    on<ToggleDarkMode>(_onToggleDarkMode);
    on<LoadThemeSettings>(_onLoadThemeSettings);
  }

  static ThemeData _buildTheme(bool isDarkMode) {
    return AppTheme.getTheme(isDark: isDarkMode);
  }

  Future<void> _onToggleDarkMode(ToggleDarkMode event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', event.isDarkMode);
    emit(state.copyWith(
      themeData: _buildTheme(event.isDarkMode),
      isDarkMode: event.isDarkMode,
    ));
  }

  Future<void> _onLoadThemeSettings(LoadThemeSettings event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('darkMode') ?? false;
    emit(state.copyWith(
      themeData: _buildTheme(isDarkMode),
      isDarkMode: isDarkMode,
    ));
  }
}
