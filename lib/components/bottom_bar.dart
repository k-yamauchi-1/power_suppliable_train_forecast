import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/search_condition.dart';
import 'dialogs/app_info_dialog.dart';
import 'dialogs/saved_cond_dialog.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) => NavigationBarTheme(
    data: NavigationBarThemeData(labelPadding: const EdgeInsets.only(top: 0)),
    child: NavigationBar(
      height: 64,
      indicatorColor: Colors.transparent,
      onDestinationSelected: (idx) async => switch (idx) {
        0 => await showDialog<SearchCond>(
          context: context, builder: (context) => const AppInfoDialog()
        ),
        1 => await showDialog<SearchCond>(
          context: context, builder: (context) => const RecordsDialog(),
        ),
        2 => launchUrl(Uri.parse('https://x.com/pwrSupplyTrnApp')),
        _ => null
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.help, size: 28), label: '本アプリについて'
        ),
        NavigationDestination(
          icon: Icon(Icons.bookmarks, size: 28), label: '保存した検索条件'
        ),
        NavigationDestination(
          icon: FaIcon(FontAwesomeIcons.xTwitter, size: 28),
          label: '更新情報\nお問合せ'
        )
      ]
    )
  );
}
