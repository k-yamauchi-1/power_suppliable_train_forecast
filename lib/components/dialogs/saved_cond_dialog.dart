import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../i18n/strings.g.dart';
import '../../models/service.dart';
import '../../models/search_condition.dart';
import '../../providers/local_storage.dart';

class RecordListTile extends ConsumerWidget {
  const RecordListTile({super.key, required this.record});

  final MapEntry<int, SearchCond> record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitCond = ref.watch(localStorageProvider).initKey == record.key;
    final notifier = ref.read(localStorageProvider.notifier);
    final stationsMap = ref.read(serviceProvider).value?.stations;
    final destMap = stationsMap?[record.value.depID]?.lDestinations;

    return ListTile(
      minTileHeight: 40,
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      title: Text([
        t.departFrom(s: stationsMap?[record.value.depID]?.lName ?? ''),
        record.value.target.label,
        '${record.value.hourFrom == -1 ? (
          record.value.target == TargetDate.today ? t.fromNowOn : t.allDay
        ) : t.timeOption(h: record.value.hourFrom)}${
          t.$meta.locale == AppLocale.ja ? '以降' : ''
        }'
      ].join(' ')),
      titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold
      ),
      subtitle: Text('${t.toward(
        s: destMap?.values.singleOrNull ?? destMap?[record.value.direction] ?? ''
      )}${record.value.arvIDs.isEmpty ? '' : '\n${t.gettingOffAt}${
        record.value.arvIDs.map((id) => stationsMap?[id]?.lName ?? '').join(' or ')
      }'}'),
      subtitleTextStyle: TextStyle(
        color: Colors.black, fontSize: 12
      ),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
          onPressed: () => notifier.setInit(isInitCond ? 0 : record.key),
          icon: Icon(isInitCond ? Icons.push_pin_outlined : Icons.push_pin),
          tooltip: t.setAsStartupSearch,
          padding: const EdgeInsets.all(5),
          constraints: const BoxConstraints()
        ),
        IconButton(
          // onPressed: () async => await showDialog(
          //   context: context, builder: (_) => RecordDestroyDialog(record: record)
          // ),
          onPressed: () => notifier.deleteCond(record.key),
          icon: const Icon(Icons.delete), tooltip: t.delete,
          padding: const EdgeInsets.all(5), constraints: const BoxConstraints()
        )
      ]),
      onTap: () {
        ref.read(condProvider.notifier).update(record.value);
        Navigator.of(context).pop();
      }
    );
  }
}

class RecordsDialog extends HookConsumerWidget {
  const RecordsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reverseToggle = useState<bool>(false);
    final records = ref.watch(localStorageProvider).conds.entries;

    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: SizedBox(width: 400, child: Column(children: [
        Row(children: [
          Text(t.savedSearches, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          if (records.length > 1)  IconButton(
            onPressed: () => reverseToggle.value = !reverseToggle.value,
            icon: Icon(Icons.swap_vert),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints()
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints()
          )
        ])
      ])),
      titlePadding: const EdgeInsets.fromLTRB(16, 8, 12, 4),
      contentPadding: const EdgeInsets.only(bottom: 8),
      children: (reverseToggle.value ? records.toList().reversed : records)
          .map((r) => RecordListTile(record: r)).toList()
    );
  }
}
