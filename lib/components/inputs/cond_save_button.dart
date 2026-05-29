import "package:flutter/material.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/search_condition.dart';
import '../../providers/local_storage.dart';

class CondSaveButton extends ConsumerWidget {
  const CondSaveButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => ElevatedButton.icon(
    onPressed: () async {
      ref.read(localStorageProvider.notifier).addCond(ref.read(condProvider));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('保存しました'),
          duration: Duration(seconds: 2),
        ));
      }
    },
    icon: const Icon(Icons.bookmark_add, size: 14),
    label: const Text('検索条件を保存', style: TextStyle(fontSize: 12)),
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      visualDensity: VisualDensity.compact
    )
  );
}
