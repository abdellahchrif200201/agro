part of 'language_bloc.dart';



abstract class LanguageState {}

class LanguageInitialState extends LanguageState {
  final Locale locale;

  LanguageInitialState(this.locale);
}

class LanguageChangedState extends LanguageState {
  final Locale locale;

  LanguageChangedState(this.locale);
}
