import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../i18n/strings.g.dart';
import '../../providers/app_locale.dart';

class LanguageToggle extends ConsumerWidget {
  const LanguageToggle({super.key});

  ButtonSegment<AppLocale> _langBtnSegment(AppLocale locale, String label) =>
      ButtonSegment(value: locale, label: SizedBox(width: 36, child: Center(
        child: Text(label, style: const TextStyle(fontSize: 10))
      )));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(appLocaleProvider);

    return SegmentedButton<AppLocale>(
      segments: [
        _langBtnSegment(AppLocale.en, 'English'),
        _langBtnSegment(AppLocale.ja, '日本語')
      ],
      selected: {currentLocale},
      showSelectedIcon: false,
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 4, vertical: 2)
        )
      ),
      onSelectionChanged: (s) async {
        if (s.isNotEmpty) {
          await LocaleSettings.setLocale(s.first);
          ref.read(appLocaleProvider.notifier).setLocale(s.first);
        }
      }
    );
  }
}

