import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../i18n/strings.g.dart';
import '../providers/local_storage.dart';
import 'station.dart';

part 'search_condition.freezed.dart';
part 'search_condition.g.dart';

const int _stHour = 6;
const int _endHour = 23;

List<String> get daysOfWeek => t.$meta.locale == AppLocale.ja
    ? ['月', '火', '水', '木', '金', '土', '日']
    : ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

enum TargetDate {
  today, nextDay, weekday, holiday;

  String get label => switch (this) {
    TargetDate.today => t.today,
    TargetDate.nextDay => t.nextDay,
    TargetDate.weekday => t.weekday,
    TargetDate.holiday => t.holiday,
  };

  bool get _isGeneral =>
      this == TargetDate.weekday || this == TargetDate.holiday;
  DateTime? get date => _isGeneral ? null : DateTime(
    DateTime.now().year, DateTime.now().month, DateTime.now().day
  ).add(Duration(days: this == TargetDate.today ? 0 : 1));
  bool get isHoliday =>
      this == TargetDate.holiday || (date?.weekday ?? 0) >= 6;

  String get note => _isGeneral ? t.noForecast :
      ' ${date!.month}/${date!.day}(${daysOfWeek[date!.weekday - 1]})';
  String get complement => _isGeneral ? t.noForecastComplement : '';
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

  List<MapEntry<int, String>> get timeOptions => [
    MapEntry(-1, target == TargetDate.today ? t.fromNowOn : t.allDay),
    ...List.generate(_endHour - 1 - _stHour, (i) => i + _stHour + 1).where(
      (h) => h > (target == TargetDate.today ? DateTime.now().hour : _stHour)
    ).map((h) => MapEntry(h, t.timeOption(h: h)))
  ];
}

@riverpod
class Cond extends _$Cond {
  @override
  SearchCond build() => ref.read(localStorageProvider.notifier).initCond;

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
