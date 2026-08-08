import "package:flutter/material.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../i18n/strings.g.dart';
import '../../models/search_condition.dart';
import '../../providers/app_locale.dart';
import '../../providers/local_storage.dart';

class CondSaveButton extends ConsumerWidget {
  const CondSaveButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appLocaleProvider);

    return ElevatedButton.icon(
      onPressed: () async {
        ref.read(localStorageProvider.notifier).addCond(ref.read(condProvider));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(t.savedSuccesfully),
            duration: const Duration(seconds: 2),
          ));
        }
      },
      icon: const Icon(Icons.bookmark_add, size: 14),
      label: Text(t.saveSearch, style: const TextStyle(fontSize: 12)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        visualDensity: VisualDensity.compact
      )
    );
  }
}
