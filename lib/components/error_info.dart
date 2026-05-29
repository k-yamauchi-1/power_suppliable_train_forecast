import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

const prodMessage = 'ただいまサービスの提供を停止しております。\n'
'メンテナンス情報は下方「更新情報」をご確認下さい。';

class ErrInfoWidget extends StatelessWidget {
  final String? message;
  final String? detail;

  const ErrInfoWidget({super.key, this.message, this.detail});

  @override
  Widget build(BuildContext context) => ListView(children: [
    const Icon(Icons.error, size: 48, color: Colors.red),
    const Gap(4),
    Text(
      message != null ? 'エラー: $message' : prodMessage,
      textAlign: TextAlign.center
    ),
    if ((detail ?? '').isNotEmpty)  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SelectableText(detail!, style: const TextStyle(
        fontSize: 11.5, color: Colors.grey
      ))
    )
  ]);
}
