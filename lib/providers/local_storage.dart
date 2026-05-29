import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/search_condition.dart';

part 'local_storage.g.dart';

typedef SavedConds = Map<int, SearchCond>;
extension on SavedConds {
  String toEncodedJson() => jsonEncode(
    map((k, v) => MapEntry(k.toString(), v.toJson()))
  );
}

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) =>
    throw UnimplementedError('SharedPreferences not initialized');

@Riverpod(keepAlive: true)
class LocalStorage extends _$LocalStorage {
  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);
  int get _newKey => DateTime.now().millisecondsSinceEpoch;

  @override
  ({SavedConds conds, int? initKey}) build() {
    listenSelf((_, n) {
      _prefs.setString('saved_conditions', n.conds.toEncodedJson());
      n.initKey == null ?
          _prefs.remove('init') : _prefs.setInt('init', n.initKey!);
    });

    final cond = Map<String, dynamic>.from(
      jsonDecode(_prefs.getString('saved_conditions') ?? '{}')
    ).map((key, value) => MapEntry(
      int.parse(key), SearchCond.fromJson(Map<String, dynamic>.from(value))
    ));
    return (conds: cond, initKey: _prefs.getInt('init'));
  }

  bool get initialized => state.initKey != null; 
  SearchCond get initCond => state.conds[state.initKey ?? 0] ?? SearchCond();
  void setInit([int key = 0]) => state = (conds: state.conds, initKey: key);

  void _setConds(SavedConds conds) =>
      state = (conds: conds, initKey: state.initKey);
  void addCond(SearchCond cond) => _setConds({_newKey: cond, ...state.conds});
  void deleteCond(int key) => _setConds({ ...state.conds..remove(key) });
  SearchCond? loadCond(int key) => state.conds[key];
}
