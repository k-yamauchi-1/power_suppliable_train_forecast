import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/facility.dart';
import 'app_icon_base.dart';

class ProbabilityIcon extends StatelessWidget {
  const ProbabilityIcon({super.key, required this.probability, this.size = 48});

  final Probability? probability;
  final double size;

  int get _percentage => probability?.percentage ?? 95;
  TextStyle get _iconTextStyle => GoogleFonts.roboto(
    fontSize: size * (0.25 + _percentage * 0.0025), letterSpacing: 0.5,
    fontWeight: FontWeight.w900, fontStyle: FontStyle.italic
  );

  @override
  Widget build(BuildContext context) => Tooltip(
    message: probability.explanation,
    triggerMode: TooltipTriggerMode.tap,
    child: AppIconBase(
      size: size, bgColor: probability.bgColor,
      overlayOpacity: (95 - _percentage) * 0.0075,
      boltIconDouble: probability.allSeats,
      child: Positioned(
        right: size * (0.1 + (95 - _percentage) * 0.0004),
        bottom: size * (-0.025 + (95 - _percentage) * 0.001),
        child: Stack(
          children: [
            // 数字 (白抜き縁あり太めの斜字)
            Text(probability.asStr, style: _iconTextStyle.copyWith(
              foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = size * 0.1
                  ..color = Colors.black54
            )),
            Text(
              probability.asStr,
              style: _iconTextStyle.copyWith(color: Colors.white)
            )
          ]
        )
      )
    )
  );
}
