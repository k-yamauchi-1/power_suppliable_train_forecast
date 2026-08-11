import 'package:flutter/material.dart';
import '../../models/search_condition.dart';
import '../dialogs/saved_cond_dialog.dart';

class SavedCondListButton extends StatelessWidget {
  const SavedCondListButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async => await showDialog<SearchCond>(
        context: context, builder: (context) => const RecordsDialog()
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade300,
        foregroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.all(0),
        minimumSize: const Size(48, 40)
      ),
      child: const Icon(Icons.bookmarks, size: 14)
    );
  }
}
