import 'dart:math';
import 'package:flutter/material.dart';

class AppIconBase extends StatelessWidget {
  const AppIconBase({
    super.key, this.size = 48,
    this.bgColor = Colors.grey, this.overlayOpacity = 0.0,
    this.boltIconDouble = false, this.child
  });

  final double size;
  final Color bgColor;
  final double overlayOpacity;
  final bool boltIconDouble;
  final Widget? child;

  Icon get _boltIcon =>
      Icon(Icons.bolt, color: Colors.yellowAccent, size: size * 0.4);

  @override
  Widget build(BuildContext context) => Container(
    width: size, height: size, decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(size * 0.2),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.8), width: size * 0.03
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: size * 0.04,
          offset: Offset(size * 0.02, size * 0.02)
        )
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0.5),
          bgColor,
          bgColor.withValues(alpha: 0.8),
          Colors.black.withValues(alpha: 0.2)
        ],
        stops: const [0.0, 0.3, 0.7, 1.0]
      )
    ),
    child: Stack(children: [
      Positioned(right: size * 0.035, top: size * 0.02, child: Transform.rotate(
        angle: pi, // 回転角度（ラジアン。マイナスで反時計回り）
        child: Icon(
          Icons.electrical_services, size: size * 0.48,
          color: Colors.white.withValues(alpha: 0.4)
        )
      )),
      Positioned(
        top: size * 0.05, left: size * 0.05,
        child: boltIconDouble ? Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.translate(offset: Offset(-size * 0.08, 0), child: _boltIcon),
            Transform.translate(offset: Offset(-size * 0.28, 0), child: _boltIcon)
          ]
        ) : _boltIcon
      ),
      child ?? const SizedBox.shrink(),
      Positioned.fill(child: Container(decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: overlayOpacity),
        borderRadius: BorderRadius.circular(size * 0.15),
      )))
    ])
  );
}
