import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'scrollable_text.dart';

import '../models/facility.dart';
import '../models/service.dart';
import '../models/train.dart';
import 'app_icons/probability_icon.dart';

class TrainListTile extends ConsumerWidget {
  const TrainListTile({super.key, required this.train});

  final Train train;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(serviceProvider).value;
    final stopsNameList =
        train.stops.map((s) => service?.stations[s.id]?.name ?? '').toList();

    final facility = service?.facilities[train.facilityId]
        ?? Facility(carType: CarType.unfixed, probabilities: {});
    final probabilities = facility.probabilities;

    return train.stops.isEmpty ? const SizedBox.shrink() : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: facility.carType.bgColor,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade400)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 8, right: 7, bottom: 10),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'assets/icon_${facility.carType.iconFileName}.jpg',
                width: 48, height: 48,
                errorBuilder: (_, __, ___) => SizedBox(
                  width: 48, height: 36,
                  child: Stack(clipBehavior: Clip.none, children: const [
                    Center(child: Icon(
                      Icons.train, size: 32, color: Colors.black54
                    )),
                    Positioned(right: -1, top: -2, child: Icon(
                      Icons.question_mark, size: 18, color: Colors.black54
                    ))
                  ])
                )
              ),
              const Gap(4),
              Text(facility.carType.dispName, style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, height: 1.2
              ))
            ]),
            const Gap(6),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(train.stops.first.dispTime, style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18
                  )),
                  const Gap(8),
                  Expanded(child: ScrollableText(
                    train.dispName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14
                    ),
                    velocity: const Velocity(pixelsPerSecond: Offset(40, 0)),
                    delayBefore: const Duration(milliseconds: 800),
                    pauseBetween: const Duration(milliseconds: 480)
                  ))
                ]),
                Text('${stopsNameList.last} 行', style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold
                )),
                if (stopsNameList.length >= 3)  Text(
                  '${(stopsNameList.sublist(1)..removeLast()).join('・')} に停車',
                  style: const TextStyle(fontSize: 12),
                  maxLines: 2, overflow: TextOverflow.ellipsis
                )
              ]
            )),
            const Gap(4),
            if (probabilities.length < 2 || train.internalTozanLine)
              ProbabilityIcon(probability: probabilities.values.firstOrNull)
            else  Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: probabilities.entries.map((entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    '${entry.key}\n号車', textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, height: 1.2)
                  ),
                  const Gap(3),
                  ProbabilityIcon(probability: entry.value, size: 28)
                ])
              )).toList()
            )
          ])
        )
      )
    );
  }
}
