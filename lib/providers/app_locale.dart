import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../i18n/strings.g.dart';

part 'app_locale.g.dart';

@riverpod
class AppLocaleNotifier extends _$AppLocaleNotifier {
  @override
  AppLocale build() => LocaleSettings.currentLocale;

  void setLocale(AppLocale locale) => state = locale;
}
