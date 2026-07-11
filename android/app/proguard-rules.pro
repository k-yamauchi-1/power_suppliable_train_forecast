# Flutter アプリ向け ProGuard / R8 ルール
# https://flutter.dev/to/obfuscation

# Flutter エンジン
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase / Google Play Services
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Kotlin Coroutines
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}

# JSON シリアライゼーション（freezed / json_serializable 生成コード）
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses,EnclosingMethod

# 一般的な警告を抑制
-dontwarn kotlin.**
-dontwarn kotlinx.**

# FlutterのPlay Store（Deferred Components）関連の欠損クラス警告を無視する
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**
