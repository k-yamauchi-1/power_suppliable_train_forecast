import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/search_condition.dart';

class TimeSelector extends ConsumerWidget {
  const TimeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(condProvider.notifier);

    return DropdownButton<MapEntry<int, String>>(
      value: notifier.fromHours.firstWhere(
        (t) => t.key == ref.watch(condProvider).hourFrom,
        orElse: () => notifier.fromHours.first
      ),
      items: notifier.fromHours.map(
        (e) => DropdownMenuItem(value: e, child: Text(e.value))
      ).toList(),
      onChanged: (v) => notifier.updateProp(hourFrom: v?.key),
      isDense: true
    );
  }
}
