import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/app_icons/splash_icon.dart';
import 'providers/crashlytics_observer.dart';
import 'providers/local_storage.dart';
import 'screens/home_screen.dart';

import 'firebase_options.dart';

void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const PowerSupliableTrainApp());
  }, (error, stack) {
    // Zone 内で捕捉されなかった非同期例外を Crashlytics に記録する
    crashlyticsInstance?.recordError(error, stack, fatal: true);
  });
}

class PowerSupliableTrainApp extends StatefulWidget {
  const PowerSupliableTrainApp({super.key});

  @override
  State<PowerSupliableTrainApp> createState() => _PowerSupliableTrainAppState();
}

class _PowerSupliableTrainAppState extends State<PowerSupliableTrainApp> {
  SharedPreferences? _prefs;

  Future<void> _initializeCrashlytics() async {
    // Flutter フレームワークが検知した致命的エラーを Crashlytics に記録する
    FlutterError.onError = crashlyticsInstance?.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      crashlyticsInstance?.recordError(error, stack, fatal: true);
      return true;
    };
    // デバッグ実行時は収集しない
    await crashlyticsInstance?.setCrashlyticsCollectionEnabled(!kDebugMode);
  }

  Future<void> _authFirebaseServices() async {
    // 正規アプリからのリクエストのみ許可するため FirebaseAuth/AppCheck を有効化
    if (FirebaseAuth.instance.currentUser == null) {
      FirebaseAuth.instance.signInAnonymously();
    }

    await FirebaseAppCheck.instance.activate(
      providerAndroid: kDebugMode ?
          const AndroidDebugProvider() : const AndroidPlayIntegrityProvider(),
      providerApple: kDebugMode ?
          const AppleDebugProvider() : const AppleAppAttestProvider()
    );
  }

  Future<void> _initializeApp() async {
    // Firebase 初期化処理
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );

    // 初期化処理と最小待機時間タイマーを同時に開始し、全部終わるのを待つ
    final results = await Future.wait([
      _initializeCrashlytics(),
      _authFirebaseServices(),
      Future.delayed(const Duration(milliseconds: 600)),  // 最小表示時間タイマー
      SharedPreferences.getInstance()  // ストレージ初期化処理　★必ず最後に置く
    ]);

    // Future.wait の戻り値から、SharedPreferences のインスタンスを取り出す
    if (mounted)  setState(() => _prefs = results.last as SharedPreferences);
  }

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  @override
  Widget build(BuildContext context) => _prefs == null ? MaterialApp(
    home: const Scaffold(body: Center(child: SplashIcon(size: 108)))
  ) : ProviderScope(
    observers: const [CrashlyticsProviderObserver()],
    overrides: [sharedPreferencesProvider.overrideWithValue(_prefs!)],
    child: MaterialApp(
      title: 'ロマンスカー充電コンセント予報',
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansJpTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF05322)),
        useMaterial3: true
      ),
      home: const HomeScreen()
    )
  );
}
