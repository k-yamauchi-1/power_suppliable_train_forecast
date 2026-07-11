import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/app_icons/splash_icon.dart';
import 'providers/local_storage.dart';
import 'screens/home_screen.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PowerSupliableTrainApp());
}

class PowerSupliableTrainApp extends StatefulWidget {
  const PowerSupliableTrainApp({super.key});

  @override
  State<PowerSupliableTrainApp> createState() => _PowerSupliableTrainAppState();
}

class _PowerSupliableTrainAppState extends State<PowerSupliableTrainApp> {
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // 初期化処理と最小待機時間タイマーを同時に開始し、全部終わるのを待つ
    final results = await Future.wait([
      () async {  // Firebase 初期化処理
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform
        );
        if (FirebaseAuth.instance.currentUser == null) {
          FirebaseAuth.instance.signInAnonymously();
        }

        // 正規アプリからのリクエストのみ許可するため Firebase App Check を有効化
        await FirebaseAppCheck.instance.activate(
          providerAndroid: kDebugMode ?
              const AndroidDebugProvider() : const AndroidPlayIntegrityProvider(),
          providerApple: kDebugMode ?
              const AppleDebugProvider() : const AppleAppAttestProvider()
        );
      }(),
      Future.delayed(const Duration(milliseconds: 600)),  // 最小表示時間タイマー
      SharedPreferences.getInstance()  // ストレージ初期化処理　★必ず最後に置く
    ]);

    // Future.wait の戻り値から、SharedPreferences のインスタンスを取り出す
    if (mounted)  setState(() => _prefs = results.last as SharedPreferences);
  }

  @override
  Widget build(BuildContext context) => _prefs == null ? MaterialApp(
    home: const Scaffold(body: Center(child: SplashIcon(size: 108)))
  ) : ProviderScope(
    overrides: [sharedPreferencesProvider.overrideWithValue(_prefs!)],
    child: MaterialApp(
      title: '充電できるロマンスカー予報アプリ',
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansJpTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF05322)),
        useMaterial3: true
      ),
      home: const HomeScreen()
    )
  );
}
