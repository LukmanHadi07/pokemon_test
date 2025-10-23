import 'package:pokemon_test/core/theme/local_theme/font_theme.dart'
    show FontLocalTheme;

class AppLocalTheme {
  final FontLocalTheme fontLocalTheme;

  AppLocalTheme._({required this.fontLocalTheme});

  static light() {
    return AppLocalTheme._(fontLocalTheme: FontLocalTheme.light());
  }

  static dark() {
    return AppLocalTheme._(fontLocalTheme: FontLocalTheme.dark());
  }
}
