import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../i18n/strings.g.dart';
import '../../models/search_condition.dart';
import '../../models/service.dart';
import '../../models/station.dart';
import '../../providers/app_locale.dart';

class DirectionSelector extends ConsumerWidget {
  const DirectionSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appLocaleProvider);
    final destinations = ref.watch(serviceProvider).value
        ?.stations[ref.watch(condProvider).depID]?.lDestinations ?? {};

    return switch (destinations.length) {
      0 => const SizedBox.shrink(),
      1 => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          t.toward(s: destinations.values.first),
          style: const TextStyle(fontWeight: FontWeight.bold)
        )
      ),
      _ => DropdownButtonFormField<Direction>(
        value: ref.watch(condProvider).direction,
        items: destinations.entries.map(
          (e) => DropdownMenuItem(value: e.key, child: Text(e.value))
        ).toList(),
        onChanged: (v) => ref.read(condProvider.notifier)
            .updateProp(direction: v, arvIDs: []),
        decoration: InputDecoration(
          labelText: t.toward(s: ''), isDense: true,
          border: const OutlineInputBorder()
        )
      )
    };
  }
}
