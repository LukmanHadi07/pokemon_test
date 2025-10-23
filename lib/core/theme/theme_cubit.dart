import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_test/core/theme/local_theme/local_theme.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggleTheme() {
    emit(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }

  AppLocalTheme get currentTheme {
    return (state == ThemeMode.dark)
        ? AppLocalTheme.dark()
        : AppLocalTheme.light();
  }
}
