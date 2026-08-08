import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/search_condition.dart';
import '../../providers/app_locale.dart';

class TimeSelector extends ConsumerWidget {
  const TimeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appLocaleProvider);
    final timeOptions = ref.watch(condProvider).timeOptions;

    return DropdownButton<int>(
      value: timeOptions.firstWhere(
        (h) => h.key == ref.read(condProvider).hourFrom,
        orElse: () => timeOptions.first
      ).key,
      items: timeOptions.map(
        (e) => DropdownMenuItem<int>(value: e.key, child: Text(e.value))
      ).toList(),
      onChanged: (v) => ref.read(condProvider.notifier).updateProp(hourFrom: v),
      isDense: true
    );
  }
}
