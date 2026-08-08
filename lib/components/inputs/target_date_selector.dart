import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../models/search_condition.dart';
import '../../providers/app_locale.dart';

class TargetDateSelector extends ConsumerWidget {
  const TargetDateSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appLocaleProvider);

    return RadioGroup<TargetDate>(
      groupValue: ref.watch(condProvider).target,
      onChanged: (v) => ref.read(condProvider.notifier).updateProp(target: v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: TargetDate.values.map((v) => InkWell(
          onTap: () => ref.read(condProvider.notifier).updateProp(target: v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                Radio<TargetDate>(value: v, visualDensity: VisualDensity.compact),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(v.label, style: const TextStyle(fontSize: 13)),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      v.note,
                      style: const TextStyle(fontSize: 10, color: Colors.grey)
                    ),
                    if (v.complement.isNotEmpty) ...[
                      const Gap(2),
                      Tooltip(
                        message: v.complement,
                        triggerMode: TooltipTriggerMode.tap,
                        child: const Icon(
                          Icons.info_outline, size: 12, color: Colors.grey
                        )
                      )
                    ]
                  ])
                ])
              ]),
              const Gap(4)
            ]
          )
        )).toList()
      )
    );
  }
}
