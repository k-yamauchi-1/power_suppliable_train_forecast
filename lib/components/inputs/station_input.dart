import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/search_condition.dart';
import '../../models/service.dart';
import '../../models/station.dart';

class StationInput extends ConsumerWidget {
  const StationInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(serviceProvider).value;
    final stationName =
        service?.stations[ref.watch(condProvider).depID]?.name ?? '';

    return Autocomplete<MapEntry<String, Station>>(
      key: ValueKey(stationName),
      initialValue: TextEditingValue(text: stationName),
      optionsBuilder: (v) => (service?.stations.entries ?? [])
          .where((s) => s.value.matches(v.text)),
      displayStringForOption: (s) => s.value.name,
      onSelected: (s) => ref.read(condProvider.notifier).updateProp(
        depID: service?.stations.containsKey(s.key) == true ? s.key : null,
        arvIDs: []
      ),
      fieldViewBuilder: (ctx, ctrl, fcs, _) => TextField(
        controller: ctrl, focusNode: fcs, decoration: const InputDecoration(
          labelText: '発駅', isDense: true, border: OutlineInputBorder()
        )
      )
    );
  }
}
