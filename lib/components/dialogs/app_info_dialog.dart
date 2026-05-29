import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/local_storage.dart';

class AppInfoDialog extends HookConsumerWidget {
  const AppInfoDialog({super.key});

  Widget _linkText(String txt, {double? size, VoidCallback? onTap}) => InkWell(
    onTap: onTap,
    child: Text(txt, style: TextStyle(
      fontSize: size, color: Colors.blue,
      decoration: TextDecoration.underline
    ))
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = ref.read(localStorageProvider.notifier);
    final checkAgree = useState<bool>(storage.initialized);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      titlePadding: const EdgeInsets.only(top: 12, bottom: 8),
      contentPadding: const EdgeInsets.all(0),
      actionsPadding: const EdgeInsets.only(bottom: 12),
      title: SizedBox(width: double.infinity, child: Stack(
        alignment: Alignment.center,
        children: [
          Center(child: Text(
            'ご利用にあたって',
            style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold)
          )),
          if (storage.initialized)  Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              visualDensity: VisualDensity.compact,
              tooltip: '閉じる',
              onPressed: () => Navigator.of(context).pop()
            )
          )
        ]
      )),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Flexible(child: Container(
          color: Colors.grey.shade100,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(child: const Text(
            '''【免責事項】
このアプリは、小田急電鉄株式会社や関連企業（以下「公式」）とは無関係な個人が
独自の調査を基に小田急ロマンスカーの列車毎の客席充電設備（コンセント）の有無を予測し、提供するアプリです。
本アプリについての問合せは必ず運営者個人宛にお送りください。公式に問合せることは固くお断りします。

情報の正確性には最善を期しておりますが、あくまで一個人による運営のため限度がありますことご容赦ください。
特に、独自提供情報である充電の可否についてはあくまで「予報」であり、なんら正確性を担保するものではありません。
また突発的なダイヤ乱れや運休にも対応しておりません。あくまでダイヤ通りだった場合の列車情報・充電可否予測になります。
リアルタイムの運行状況は公式提供の各種最新情報をご確認ください。

本アプリの利用にあたっては以上を了承の上で各利用者がその判断・責任の下で利用し、その結果生じた不利益・損害について提供者は一切の責任を負わないものとします。''',
          style: TextStyle(fontSize: 12.8),
        )))),
        const Gap(8),
        _linkText('利用規約・プライバシーポリシー', onTap: () async {
          await launchUrl(Uri.parse('https://example.com/terms'));
        })
      ]),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Column(mainAxisSize: MainAxisSize.min, children: [
          if (storage.initialized) const Gap(8) else
            Row(mainAxisSize: MainAxisSize.min, children: [
              Checkbox(
                activeColor: const Color(0xFFF05322),
                value: checkAgree.value,
                onChanged: (v) => checkAgree.value = v ?? false
              ),
              Text('免責事項・利用規約に同意して', style: TextStyle(
                color: checkAgree.value ? null : Colors.grey, fontSize: 14
              ))
            ]),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFF05322),
            ),
            onPressed: checkAgree.value ? () async {
              if (!storage.initialized)  storage.setInit();
              if (context.mounted)  Navigator.of(context).pop();
            } : null,
            child: Text(
              storage.initialized ? 'OK' : '利用開始',
              style: TextStyle(fontSize: 16)
            )
          ),
          const Gap(16),
          Wrap(spacing: 12, children: [
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) => Text(
                'バージョン: ${snapshot.data?.version ?? ''}',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade700)
              )
            ),
            _linkText('リリース情報', size: 12, onTap: () async {
              await launchUrl(Uri.parse(switch(defaultTargetPlatform) {
                TargetPlatform.android => 'https://play.google.com/store/apps/details?id=com.k26yamauchi.power_suppliable_train_forecast',
                TargetPlatform.iOS => 'https://apps.apple.com/jp/app/id6788913050',
                _ => 'https://example.com/'
              }));
            }),
            _linkText('ライセンス', size: 12, onTap: () {
              showLicensePage(context: context);
            })
          ])
        ])
      ]
    );
  }
}
