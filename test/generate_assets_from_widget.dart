import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:power_suppliable_train_forecast/models/facility.dart';
import 'package:power_suppliable_train_forecast/components/app_icons/probability_icon.dart';

void main() {
  testWidgets('Generate app icons and splash screens', (WidgetTester tester) async {
    // 画面サイズを十分に大きく設定
    await tester.binding.setSurfaceSize(const Size(2048, 2048));

    // 元の画像サイズを読み取るヘルパー (PNGバイナリのIHDRチャンクから安全に取得)
    Future<Size> getImageSize(File file) async {
      try {
        final bytes = await file.readAsBytes();
        if (bytes.length >= 24 &&
            bytes[0] == 137 &&
            bytes[1] == 80 &&
            bytes[2] == 78 &&
            bytes[3] == 71) {
          final width = (bytes[16] << 24) | (bytes[17] << 16) | (bytes[18] << 8) | bytes[19];
          final height = (bytes[20] << 24) | (bytes[21] << 16) | (bytes[22] << 8) | bytes[23];
          return Size(width.toDouble(), height.toDouble());
        }
        return const Size(192, 192);
      } catch (e) {
        print('Error getting size from ${file.path}: $e');
        return const Size(192, 192); // デフォルトサイズ
      }
    }

    // 指定されたサイズでPNGデータを生成する
    Future<Uint8List> renderIconToBytes(double size) async {
      final key = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: RepaintBoundary(
                key: key,
                child: Container(
                  width: size,
                  height: size,
                  color: Colors.transparent,
                  // Probability.a95 は allSeatsEquipped が true の probability
                  child: ProbabilityIcon(probability: Probability.a95, size: size),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      final bytes = await tester.runAsync<Uint8List>(() async {
        final boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
        final image = await boundary.toImage(pixelRatio: 1.0);
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        return byteData!.buffer.asUint8List();
      });
      return bytes!;
    }

    // PNGバイトを単一画像のICOバイトに変換する。
    // Windowsの app_icon.ico 向け
    List<int> convertPngToIco(List<int> pngBytes) {
      final icoBytes = <int>[];
      // ICO Header
      icoBytes.addAll([0, 0]); // Reserved
      icoBytes.addAll([1, 0]); // Resource Type (1 = Icon)
      icoBytes.addAll([1, 0]); // Number of Images (1)

      // Directory Entry
      icoBytes.add(0); // Width (0 means 256)
      icoBytes.add(0); // Height (0 means 256)
      icoBytes.add(0); // Color Palette (0)
      icoBytes.add(0); // Reserved
      icoBytes.addAll([1, 0]); // Color Planes
      icoBytes.addAll([32, 0]); // Bits per pixel (32)

      final size = pngBytes.length;
      icoBytes.addAll([size & 0xFF, (size >> 8) & 0xFF, (size >> 16) & 0xFF, (size >> 24) & 0xFF]); // Data size

      const offset = 6 + 16;
      icoBytes.addAll([offset & 0xFF, (offset >> 8) & 0xFF, (offset >> 16) & 0xFF, (offset >> 24) & 0xFF]); // Data offset

      icoBytes.addAll(pngBytes);
      return icoBytes;
    }

    // 生成または更新タスクを定義
    final tasks = <Map<String, dynamic>>[
      // Web
      {'path': 'web/icons/Icon-192.png', 'size': 192.0},
      {'path': 'web/icons/Icon-512.png', 'size': 512.0},
      {'path': 'web/icons/Icon-maskable-192.png', 'size': 192.0},
      {'path': 'web/icons/Icon-maskable-512.png', 'size': 512.0},
      {'path': 'web/favicon.png', 'size': 128.0}, // 元ファイルサイズから再取得

      // iOS App Icons
      {'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png', 'size': 40.0},
      {'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png', 'size': 60.0},
      {'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png', 'size': 29.0},
      {'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png', 'size': 58.0},
      {'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png', 'size': 87.0},
      {'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png', 'size': 40.0},
      {'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png', 'size': 80.0},
      {'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png', 'size': 120.0},
      {'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png', 'size': 120.0},
      {'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png', 'size': 180.0},
      {'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png', 'size': 76.0},
      {'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png', 'size': 152.0},
      {'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png', 'size': 167.0},
      {'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png', 'size': 1024.0},

      // macOS App Icons
      {'path': 'macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_16.png', 'size': 16.0},
      {'path': 'macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_32.png', 'size': 32.0},
      {'path': 'macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_64.png', 'size': 64.0},
      {'path': 'macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_128.png', 'size': 128.0},
      {'path': 'macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_256.png', 'size': 256.0},
      {'path': 'macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_512.png', 'size': 512.0},
      {'path': 'macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_1024.png', 'size': 1024.0},

      // Android Icons (元のファイルからサイズを読み取って同じサイズで更新)
      {'path': 'android/app/src/main/res/mipmap-mdpi/ic_launcher.png', 'size': null},
      {'path': 'android/app/src/main/res/mipmap-hdpi/ic_launcher.png', 'size': null},
      {'path': 'android/app/src/main/res/mipmap-xhdpi/ic_launcher.png', 'size': null},
      {'path': 'android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png', 'size': null},
      {'path': 'android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png', 'size': null},

      // iOS Splash (LaunchImages)
      {'path': 'ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png', 'size': null},
      {'path': 'ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png', 'size': null},
      {'path': 'ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png', 'size': null},
    ];

    for (final task in tasks) {
      final path = task['path'] as String;
      final file = File(path);
      double size = 192.0;

      if (task['size'] != null) {
        size = task['size'] as double;
      } else {
        // LaunchImageの場合は既存ファイルが1x1のダミーであることが多いため、既存サイズ読み込みをバイパスして適切なサイズを割り当てる
        if (path.contains('LaunchImage')) {
          if (path.contains('@3x')) size = 600.0;
          else if (path.contains('@2x')) size = 400.0;
          else size = 200.0;
        } else {
          final bool exists = await tester.runAsync<bool>(() async => file.existsSync()) ?? false;
          if (exists) {
            final existingSize = await tester.runAsync<Size>(() async => getImageSize(file)) ?? const Size(192, 192);
            size = existingSize.width; // 正方形前提
          } else {
            // フォールバック（Android / iOS Splash用）
            if (path.contains('mdpi')) size = 48.0;
            else if (path.contains('hdpi')) size = 72.0;
            else if (path.contains('xhdpi')) size = 96.0;
            else if (path.contains('xxhdpi')) size = 144.0;
            else if (path.contains('xxxhdpi')) size = 192.0;
            else size = 200.0;
          }
        }
      }

      final bytes = await renderIconToBytes(size);
      await tester.runAsync(() async {
        await file.parent.create(recursive: true);
        await file.writeAsBytes(bytes);
      });
      print('Generated: $path (size: $size)');
    }

    // Windows ICO 生成（256x256 で描画し、ICOに変換して保存）
    final png256 = await renderIconToBytes(256.0);
    final icoBytes = convertPngToIco(png256);
    final icoFile = File('windows/runner/resources/app_icon.ico');
    await tester.runAsync(() async {
      await icoFile.parent.create(recursive: true);
      await icoFile.writeAsBytes(icoBytes);
    });
    print('Generated Windows ICO: ${icoFile.path}');
  });
}
