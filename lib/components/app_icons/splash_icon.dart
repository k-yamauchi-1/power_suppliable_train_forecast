import 'package:flutter/material.dart';

import 'app_icon_base.dart';

class SplashIcon extends StatelessWidget {
  const SplashIcon({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) => AppIconBase(
    size: size,
    bgColor: const Color(0xFFF05322),
    boltIconDouble: true,
    child: Positioned(
      right: size * 0.018,
      bottom: size * 0.18,
      child: CustomPaint(
        size: Size(size * 0.9, size * 0.4),
        painter: _TrainSideViewPainter(),
      ),
    ),
  );
}

class _TrainSideViewPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width, 0);
    canvas.scale(-1, 1);

    final paintBody = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.fill;
    final paintShadow = Paint()
      ..color = Colors.black26
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height * 0.08;
    final paintWindow = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;

    // 車体
    final bodyPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.25)
      ..lineTo(size.width * 0.55, size.height * 0.25)
      ..quadraticBezierTo(
        size.width * 0.85,
        size.height * 0.28,
        size.width,
        size.height * 0.82,
      )
      ..quadraticBezierTo(
        size.width * 0.95,
        size.height * 1.0,
        size.width * 0.8,
        size.height * 1.0,
      )
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(bodyPath, paintShadow);
    canvas.drawPath(bodyPath, paintBody);

    // 展望席窓
    final observationPath = Path()
      ..moveTo(size.width * 0.78, size.height * 0.52)
      ..lineTo(size.width * 0.885, size.height * 0.52)
      ..quadraticBezierTo(
        size.width * 0.935, size.height * 0.56,
        size.width * 0.97, size.height * 0.72,
      )
      ..lineTo(size.width * 0.87, size.height * 0.72)
      ..close();
    canvas.drawPath(observationPath, paintWindow);

    // 運転席窓
    final cockpitPath = Path()
      ..moveTo(size.width * 0.7, size.height * 0.34)
      ..lineTo(size.width * 0.75, size.height * 0.34)
      ..quadraticBezierTo(
        size.width * 0.81, size.height * 0.37,
        size.width * 0.82, size.height * 0.42,
      )
      ..lineTo(size.width * 0.74, size.height * 0.42)
      ..close();
    canvas.drawPath(cockpitPath, paintWindow);

    // 側窓（横長2つ）
    for (int i = 0; i < 2; i++) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width * (0.03 + i * 0.32),
            size.height * 0.48,
            size.width * 0.27, // 幅
            size.height * 0.175, // 高さ
          ),
          Radius.circular(size.height * 0.03),
        ),
        paintWindow
      );
    }

    // 窓下帯
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        size.height * 0.7,
        size.width * 0.64,
        size.height * 0.05,
      ),
      Paint()
        ..color = const Color(0xFFF05322)
        ..style = PaintingStyle.fill,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
