import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../i18n/strings.g.dart';
import '../../models/facility.dart';
import '../../models/train.dart';
import '../../providers/facility_forecast.dart';
import '../app_icons/probability_icon.dart';

class StopListDialog extends ConsumerWidget {
  const StopListDialog({
    super.key, required this.train, required this.stopsNameList, required this.facility
  });

  final Train train;
  final List<String> stopsNameList;
  final Facility? facility;

  Map<String, Probability> get _probabilities => facility?.probabilities ?? {};

  SizedBox _timeHeader(String text) => SizedBox(width: 60, child: Text(
    text, textAlign: TextAlign.center,
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
  ));

  SizedBox _timeCell(String? text, {bool strong = false}) => SizedBox(
    width: 60,
    child: Text(text ?? '―', textAlign: TextAlign.center, style: TextStyle(
      fontSize: 14,
      color: text == null ? Colors.grey : (
        strong ? Colors.red : Colors.black87
      ),
      fontWeight: strong ? FontWeight.bold : FontWeight.normal
    ))
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) => Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    clipBehavior: Clip.antiAlias,
    child: Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // タイトル部（背景色あり）
          Container(
            color: (facility?.carType ?? CarType.unfixed).bgColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(train.dispName, style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold
                      )),
                      const Gap(2),
                      Text(
                        t.destination(s: stopsNameList.lastOrNull ?? ''),
                        style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800
                        )
                      )
                    ]
                  )),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.of(context).pop()
                  )]
                ),
                const Gap(8),
                if (ref.watch(forecastProvider) is AsyncData)
                  (_probabilities.length == 1 || train.internalTozanLine) ? Row(
                    children: [
                      ProbabilityIcon(
                        probability: _probabilities.values.firstOrNull, size: 28
                      ),
                      const Gap(8),
                      Expanded(child: Text(
                        _probabilities.values.firstOrNull?.explanation ?? '',
                        style: const TextStyle(fontSize: 12)
                      ))
                    ]
                  ) : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _probabilities.entries.map((entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(children: [
                        Text(
                          t.carNo(n: entry.key), textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 11.5, height: 1.2)
                        ),
                        const Gap(4),
                        ProbabilityIcon(probability: entry.value, size: 24),
                        const Gap(6),
                        Expanded(child: Text(
                          entry.value.explanation,
                          style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500
                          )
                        ))
                      ])
                    )).toList()
                  )
              ]
            )
          ),
          const Divider(height: 1, thickness: 1),

          // 時刻表リスト部
          Flexible(child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              // ヘッダー行
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                color: Colors.grey.shade200,
                child: Row(children: [
                  Expanded(child: Text(t.stopsName, style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 13
                  ))),
                  _timeHeader(t.arv),
                  _timeHeader(t.dep)
                ])
              ),
              const Divider(height: 1),

              // リスト表示 (ListView.separated)
              Flexible(child: ListView.separated(
                shrinkWrap: true,
                itemCount: train.stops.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, thickness: 0.5),
                itemBuilder: (context, idx) => Container(
                  color: idx % 2 == 1 ? Colors.grey.shade50 : Colors.white,
                  padding: const EdgeInsets
                      .symmetric(horizontal: 16, vertical: 8),
                  child: Row(children: [
                    Expanded(child: Text(stopsNameList[idx], style: TextStyle(
                      fontSize: 14,
                      color: idx == train.depIdx ? Colors.red : null,
                      fontWeight: idx == train.depIdx ?
                          FontWeight.bold : FontWeight.w500
                    ))),
                    _timeCell(idx == 0 ? null : (idx == train.stops.length - 1
                      ? train.stops[idx].dispTime
                      : train.stops[idx].dispArvTime
                    )),
                    _timeCell(
                      idx == train.stops.length - 1 ?
                          null : train.stops[idx].dispTime,
                      strong: idx == train.depIdx
                    )
                  ])
                )
              ))
            ])
          ))
        ]
      )
    )
  );
}
