// language_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitialState(Locale('ar'))) {
    on<LoadSavedLocaleEvent>(_onLoadSavedLocale);
    on<SetLocaleEvent>(_onSetLocale);
  }

  Future<void> _onLoadSavedLocale(LoadSavedLocaleEvent event, Emitter<LanguageState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedLocaleCode = prefs.getString('selectedLocale');
    final locale = savedLocaleCode != null ? Locale(savedLocaleCode) : Locale('ar');
    emit(LanguageChangedState(locale));
  }

  Future<void> _onSetLocale(SetLocaleEvent event, Emitter<LanguageState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLocale', event.locale.languageCode);
    emit(LanguageChangedState(event.locale));
  }
}
