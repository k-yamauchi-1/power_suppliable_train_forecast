import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    final destMap = stationsMap?[record.value.depID]?.destinations;

    return ListTile(
      minTileHeight: 40,
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      title: Text([
        '${stationsMap?[record.value.depID]?.name ?? ''}発',
        record.value.target.name,
        '${record.value.hourFrom == -1 ? (
          record.value.target == TargetDate.today ? '現在' : '始発'
        ) : '${record.value.hourFrom}時'}以降',
      ].join(' ')),
      titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold
      ),
      subtitle: Text('${
        destMap?.values.singleOrNull ?? destMap?[record.value.direction] ?? ''
      }方面${record.value.arvIDs.isEmpty ? '' : '\n下車駅：${
        record.value.arvIDs.map((id) => stationsMap?[id]?.name ?? '').join(' or ')
      }'}'),
      subtitleTextStyle: TextStyle(
        color: Colors.black, fontSize: 12
      ),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
          onPressed: () => notifier.setInit(isInitCond ? 0 : record.key),
          icon: Icon(isInitCond ? Icons.push_pin_outlined : Icons.push_pin),
          tooltip: '起動時の条件に設定',
          padding: const EdgeInsets.all(5),
          constraints: const BoxConstraints()
        ),
        IconButton(
          // onPressed: () async => await showDialog(
          //   context: context, builder: (_) => RecordDestroyDialog(record: record)
          // ),
          onPressed: () => notifier.deleteCond(record.key),
          icon: const Icon(Icons.delete), tooltip: '削除',
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
          const Text('保存した検索条件', style: TextStyle(fontSize: 16)),
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
