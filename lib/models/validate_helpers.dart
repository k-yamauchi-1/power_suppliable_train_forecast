/// 各モデルの `validate()` で共通して使用する検証ヘルパー。
///
/// 各モデルの `validate()` は不備の内容を表す `List<String>` を返す。
/// 不備が一つもなければ空の `List` を返す。
library;

/// 特記のないコレクション（List, Map等）が満たすべき最小要素数。
const int minLength = 2;

/// [length] が [min]（既定は[minLength]）未満の場合にエラーメッセージを返す。
String? validateSize(String label, int length, {int min = minLength}) =>
    length < min ? '$label: 要素数は$min以上必要です（現在$length件）' : null;

/// [keys] に空文字列が含まれる場合にエラーメッセージを返す。
String? validateKeysNotEmpty(String label, Iterable<String> keys) =>
    keys.any((k) => k.isEmpty) ? '$label: 空のキーが含まれています' : null;
