import 'package:flutter/foundation.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Firebase Crashlytics がサポートされているプラットフォームであれば
/// [FirebaseCrashlytics.instance] を返し、そうでなければ `null` を返します。
FirebaseCrashlytics? get crashlyticsInstance => switch(defaultTargetPlatform) {
  TargetPlatform.android || TargetPlatform.iOS || TargetPlatform.macOS =>
      FirebaseCrashlytics.instance,
  _ => null
};

final class CrashlyticsProviderObserver extends ProviderObserver {
  const CrashlyticsProviderObserver();

  @override
  void providerDidFail(context, error, stackTrace) => crashlyticsInstance
      ?.recordError(error, stackTrace, reason: 'Provider failed: ${
        context.provider.name ?? context.provider.runtimeType
      }');
}
