import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleDarkMode extends ThemeEvent {
  final bool isDarkMode;

  const ToggleDarkMode({required this.isDarkMode});

  @override
  List<Object> get props => [isDarkMode];
}

class UpdateTimeZone extends ThemeEvent {
  final String timeZone;

  const UpdateTimeZone({required this.timeZone});

  @override
  List<Object> get props => [timeZone];
}

class LoadThemeSettings extends ThemeEvent {}
