import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokemon_test/core/router/app_router.dart';
import 'package:pokemon_test/core/theme/app_theme.dart';
import 'package:pokemon_test/core/theme/theme_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: lightThemeApp,
      darkTheme: darkThemeApp,
      themeMode: themeMode,
    );
  }
}
