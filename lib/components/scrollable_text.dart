import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

/// [TextScroll] のラッパーウィジェット。
///
/// テキストが表示領域に収まる場合は通常の [Text] を表示し、
/// はみ出る場合のみ [TextScroll] でスクロールさせる。
/// これにより [TextScroll] 内部のレイアウト確定前に短いテキストが
/// 一時的にスクロール扱いされる問題を回避する。
class ScrollableText extends StatelessWidget {
  const ScrollableText(
    this.text, {
    super.key,
    this.style,
    this.velocity = const Velocity(pixelsPerSecond: Offset(80, 0)),
    this.delayBefore,
    this.pauseBetween,
  });

  final String text;
  final TextStyle? style;
  final Velocity velocity;
  final Duration? delayBefore;
  final Duration? pauseBetween;

  @override
  Widget build(context) => LayoutBuilder(builder: (context, constraints) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.of(context).textScaler,
      maxLines: 1,
    )..layout();

    // 僅かな計算誤差やフォントのパディングによりギリギリの幅で「…」表示のまま
    // スクロールしない現象を防ぐため、2ピクセルのバッファを引いた幅で判定
    return textPainter.width > (constraints.maxWidth - 2) ? TextScroll(
      text, style: style, velocity: velocity,
      delayBefore: delayBefore, pauseBetween: pauseBetween
    ) : Text(text, style: style, maxLines: 1, overflow: TextOverflow.ellipsis);
  });
}
