import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../i18n/strings.g.dart';
import '../../models/search_condition.dart';
import '../../models/service.dart';
import '../../models/station.dart';
import '../../providers/app_locale.dart';

class StationInput extends ConsumerWidget {
  const StationInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appLocaleProvider);
    final service = ref.watch(serviceProvider).value;
    final stationName =
        service?.stations[ref.watch(condProvider).depID]?.lName ?? '';

    return Autocomplete<MapEntry<String, Station>>(
      key: ValueKey(stationName),
      initialValue: TextEditingValue(text: stationName),
      optionsBuilder: (v) => (service?.stations.entries ?? [])
          .where((s) => s.value.matches(v.text)),
      displayStringForOption: (s) => s.value.lName,
      onSelected: (s) => ref.read(condProvider.notifier).updateProp(
        depID: service?.stations.containsKey(s.key) == true ? s.key : null,
        arvIDs: []
      ),
      fieldViewBuilder: (ctx, ctrl, fcs, _) => ListenableBuilder(
        listenable: Listenable.merge([ctrl, fcs]),
        builder: (context, _) => PopScope(
          canPop: !fcs.hasFocus,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop)  fcs.unfocus();
          },
          child: Focus(
            onFocusChange: (hasFcs) {  // フォーカスが外れた際 空なら元の駅名に戻す
              if (!hasFcs && ctrl.text.trim().isEmpty)  ctrl.text = stationName;
            },
            child: TextField(
              controller: ctrl, focusNode: fcs, decoration: InputDecoration(
                labelText: t.departureStation,
                isDense: true,
                border: const OutlineInputBorder(),
                suffixIcon: ctrl.text.isEmpty ? null : IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    ctrl.clear();
                    fcs.requestFocus();
                  }
                )
              )
            )
          )
        )
      )
    );
  }
}
