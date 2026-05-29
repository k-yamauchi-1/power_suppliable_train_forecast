import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/service.dart';
import '../../models/search_condition.dart';

class ArvStationsSelector extends ConsumerWidget {
  const ArvStationsSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arvIDs = ref.watch(condProvider).arvIDs;
    final service = ref.watch(serviceProvider).value;
    final reachables = service?.reachables(ref.watch(condProvider)) ?? [];

    final mediaQuery = MediaQuery.of(context);
    final safeAreaHeight = mediaQuery.size.height -
        (mediaQuery.padding.top + mediaQuery.padding.bottom);

    return reachables.isEmpty ? SizedBox.shrink() : ExpansionTile(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('停車駅で絞込み', style: TextStyle(fontSize: 14)),
          Text(
            '${arvIDs.isEmpty ? '選択した駅のいずれか' : arvIDs.map(
              (id) => service?.stations[id]?.name
            ).join(' または ')}に停車',
            style: TextStyle(fontSize: 10.5, color: Colors.grey.shade400)
          )
        ]
      ),
      dense: true,
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(bottom: 8.0),
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: safeAreaHeight * 0.2),
          child: SingleChildScrollView(
            child: Wrap(spacing: 6, runSpacing: 2, children: reachables.map(
              (rcbl) => FilterChip(
                showCheckmark: false,
                label: Row(mainAxisSize: MainAxisSize.min, children: [
                  if (arvIDs.contains(rcbl.id)) ...[
                    const Icon(Icons.check, size: 14),
                    const Gap(2)
                  ],
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: rcbl.name, style: const TextStyle(fontSize: 12)
                    ),
                    TextSpan(
                      text: ' ${rcbl.surcharge}円',
                      style: const TextStyle(fontSize: 10, color: Colors.grey)
                    )
                  ]))
                ]),
                selected: arvIDs.contains(rcbl.id),
                selectedColor: const Color(0xFFC4E4F9),
                onSelected: (chk) => ref.read(condProvider.notifier).updateProp(
                  arvIDs: chk ? [...arvIDs, rcbl.id] : arvIDs.where(
                    (id) => id != rcbl.id
                  ).toList()
                ),
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                labelPadding: const EdgeInsets.symmetric(horizontal: 8)
              )
            ).toList())
          )
        )
      ]
    );
  }
}
