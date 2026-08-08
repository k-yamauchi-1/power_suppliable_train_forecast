///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsJa with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsJa({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ja,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ja>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsJa _root = this; // ignore: unused_field

	@override 
	TranslationsJa $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsJa(meta: meta ?? this.$meta);

	// Translations
	@override String get searchTrain => '列車検索';
	@override String get today => '本日';
	@override String get nextDay => '明日';
	@override String get weekday => '平日';
	@override String get holiday => '土休日';
	@override String get noForecast => '予報なし';
	@override String get noForecastComplement => '充電可能な車両の比率のみに基づく確率表示です';
	@override String get fromNowOn => '現在';
	@override String get allDay => '始発';
	@override String timeOption({required Object h}) => '${h}時';
	@override String departFrom({required Object s}) => '${s}発';
	@override String get departureStation => '発駅';
	@override String toward({required Object s}) => '${s}方面';
	@override String get gettingOffAt => '下車駅：';
	@override String get filterByStoppingStations => '停車駅で絞込み';
	@override String get anyOfSelectedStations => '選択した駅のいずれか';
	@override String destination({required Object s}) => '${s} 行';
	@override String stopsAt({required Object s}) => '${s}に停車';
	@override String trainNo({required Object n}) => '${n}号';
	@override String carNo({required Object n}) => '${n}\n号車';
	@override String get unfixed => '不定';
	@override String atAllSeats({required Object p}) => '全席${p}％';
	@override String onlyAtWindowSeats({required Object p}) => '窓側席のみ${p}％';
	@override String get probability => 'コンセント確率: ';
	@override String get noTrainsMatched => '条件に一致する列車はありません';
	@override String get saveSearch => '検索条件を保存';
	@override String get savedSuccesfully => '保存しました';
	@override String get savedSearches => '保存した検索条件';
	@override String get setAsStartupSearch => '起動時の条件に設定';
	@override String get infoAndContact => '最新情報\nお問合せ';
	@override String get notice => 'ご利用にあたって';
	@override String get termAndPolicy => '利用規約・プライバシーポリシー';
	@override String get agreeToTheDisclaimerAndTermsOfUse => '免責事項・利用規約に同意して';
	@override String get startUsing => '利用開始';
	@override String get version => 'バージョン';
	@override String get releaseInfo => 'リリース情報';
	@override String get licenses => 'ライセンス';
	@override String get separator => '・';
	@override String get or => 'または';
	@override String get close => '閉じる';
	@override String get delete => '削除';
	@override String get error => 'エラー';
	@override String get prodErrMsg => 'ただいまサービスの提供を停止しております。\nメンテナンス情報は「最新情報」をご確認ください。';
}

/// The flat map containing all translations for locale <ja>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsJa {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'searchTrain' => '列車検索',
			'today' => '本日',
			'nextDay' => '明日',
			'weekday' => '平日',
			'holiday' => '土休日',
			'noForecast' => '予報なし',
			'noForecastComplement' => '充電可能な車両の比率のみに基づく確率表示です',
			'fromNowOn' => '現在',
			'allDay' => '始発',
			'timeOption' => ({required Object h}) => '${h}時',
			'departFrom' => ({required Object s}) => '${s}発',
			'departureStation' => '発駅',
			'toward' => ({required Object s}) => '${s}方面',
			'gettingOffAt' => '下車駅：',
			'filterByStoppingStations' => '停車駅で絞込み',
			'anyOfSelectedStations' => '選択した駅のいずれか',
			'destination' => ({required Object s}) => '${s} 行',
			'stopsAt' => ({required Object s}) => '${s}に停車',
			'trainNo' => ({required Object n}) => '${n}号',
			'carNo' => ({required Object n}) => '${n}\n号車',
			'unfixed' => '不定',
			'atAllSeats' => ({required Object p}) => '全席${p}％',
			'onlyAtWindowSeats' => ({required Object p}) => '窓側席のみ${p}％',
			'probability' => 'コンセント確率: ',
			'noTrainsMatched' => '条件に一致する列車はありません',
			'saveSearch' => '検索条件を保存',
			'savedSuccesfully' => '保存しました',
			'savedSearches' => '保存した検索条件',
			'setAsStartupSearch' => '起動時の条件に設定',
			'infoAndContact' => '最新情報\nお問合せ',
			'notice' => 'ご利用にあたって',
			'termAndPolicy' => '利用規約・プライバシーポリシー',
			'agreeToTheDisclaimerAndTermsOfUse' => '免責事項・利用規約に同意して',
			'startUsing' => '利用開始',
			'version' => 'バージョン',
			'releaseInfo' => 'リリース情報',
			'licenses' => 'ライセンス',
			'separator' => '・',
			'or' => 'または',
			'close' => '閉じる',
			'delete' => '削除',
			'error' => 'エラー',
			'prodErrMsg' => 'ただいまサービスの提供を停止しております。\nメンテナンス情報は「最新情報」をご確認ください。',
			_ => null,
		};
	}
}
