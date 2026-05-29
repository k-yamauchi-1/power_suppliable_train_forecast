import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/local_storage.dart';
import 'station.dart';

part 'search_condition.freezed.dart';
part 'search_condition.g.dart';

const int _stHour = 6;
const int _endHour = 23;

enum TargetDate {
  today('本日'), nextDay('明日'), weekday('平日'), holiday('土休日');

  const TargetDate(this.name);
  final String name;

  bool get _isGeneral =>
      this == TargetDate.weekday || this == TargetDate.holiday;
  DateTime? get date => _isGeneral ? null : DateTime(
    DateTime.now().year, DateTime.now().month, DateTime.now().day
  ).add(Duration(days: this == TargetDate.today ? 0 : 1));
  bool get isHoliday =>
      this == TargetDate.holiday || (date?.weekday ?? 0) >= 6;

  String get note => _isGeneral ? '予報なし' : ' ${date!.month}/${
    date!.day.toString().padLeft(2, '0')
  }(${['月', '火', '水', '木', '金', '土', '日'][date!.weekday - 1]})';
  String get complement =>
      _isGeneral ? '充電可能な車両の比率のみに基づく確率表示です' : '';
}

@freezed
abstract class SearchCond with _$SearchCond {
  const SearchCond._();

  const factory SearchCond({
    @Default("OH01") String depID,
    @Default(Direction.up) Direction direction,
    @Default([]) List<String> arvIDs,
    @Default(TargetDate.today) TargetDate target,
    @Default(-1) int hourFrom
  }) = _SearchCond;

  factory SearchCond.fromJson(Map<String, dynamic> json) =>
      _$SearchCondFromJson(json);

  bool matchTime({required int hour, required int min}) {
    if (hourFrom != -1)  return hourFrom <= hour;
    return target != TargetDate.today || DateTime.now().hour < hour || (
      DateTime.now().hour == hour && DateTime.now().minute <= min
    );
  }

  List<MapEntry<int, String>> get _fromHours => [
    MapEntry(-1, target == TargetDate.today ? '現在' : '始発'),
    ...List.generate(_endHour - 1 - _stHour, (i) => i + _stHour + 1).where(
      (h) => h > (target == TargetDate.today ? DateTime.now().hour : _stHour)
    ).map((h) => MapEntry(h, '$h時'))
  ];
}

@riverpod
class Cond extends _$Cond {
  List<MapEntry<int, String>> fromHours = [];

  @override
  SearchCond build() {
    listenSelf((_, n) => fromHours = n._fromHours);
    return ref.read(localStorageProvider.notifier).initCond;
  }

  void updateProp({
    String? depID, Direction? direction, List<String>? arvIDs,
    TargetDate? target, int? hourFrom
  }) => state = state.copyWith(
    depID: depID ?? state.depID,
    direction: direction ?? state.direction,
    arvIDs: arvIDs ?? state.arvIDs,
    target: target ?? state.target,
    hourFrom: hourFrom ?? state.hourFrom
  );

  void update(SearchCond cond) => state = cond;
}
