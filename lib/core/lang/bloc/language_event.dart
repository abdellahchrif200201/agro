part of 'language_bloc.dart';

abstract class LanguageEvent {}

class LoadSavedLocaleEvent extends LanguageEvent {}

class SetLocaleEvent extends LanguageEvent {
  final Locale locale;

  SetLocaleEvent(this.locale);
}
