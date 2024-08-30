part of 'theme_bloc.dart';

sealed class ThemeEvent {}

class ThemeChanged extends ThemeEvent{
  final bool isDark;
  ThemeChanged({required this.isDark});
}