///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: 'Search Train'
	String get searchTrain => 'Search Train';

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'Tomorrow'
	String get nextDay => 'Tomorrow';

	/// en: 'Weekdays'
	String get weekday => 'Weekdays';

	/// en: 'Holidays'
	String get holiday => 'Holidays';

	/// en: 'No forecast'
	String get noForecast => 'No forecast';

	/// en: 'Probabilities based solely on ratios of fleet available outlet'
	String get noForecastComplement => 'Probabilities based solely on ratios of fleet available outlet';

	/// en: 'From now on'
	String get fromNowOn => 'From now on';

	/// en: 'All day'
	String get allDay => 'All day';

	/// en: '$h or later'
	String timeOption({required Object h}) => '${h} or later';

	/// en: 'Depart from $s\n'
	String departFrom({required Object s}) => 'Depart from ${s}\n';

	/// en: 'Departure station'
	String get departureStation => 'Departure station';

	/// en: 'Toward $s'
	String toward({required Object s}) => 'Toward ${s}';

	/// en: 'Getting off at '
	String get gettingOffAt => 'Getting off at ';

	/// en: 'Filter by stopping stations'
	String get filterByStoppingStations => 'Filter by stopping stations';

	/// en: 'Any of selected stations'
	String get anyOfSelectedStations => 'Any of selected stations';

	/// en: 'for $s'
	String destination({required Object s}) => 'for ${s}';

	/// en: 'Stops at $s'
	String stopsAt({required Object s}) => 'Stops at ${s}';

	/// en: ' No.$n'
	String trainNo({required Object n}) => ' No.${n}';

	/// en: 'car\n$n'
	String carNo({required Object n}) => 'car\n${n}';

	/// en: 'Dep.'
	String get dep => 'Dep.';

	/// en: 'Arv.'
	String get arv => 'Arv.';

	/// en: 'Stops'
	String get stopsName => 'Stops';

	/// en: 'unfixed'
	String get unfixed => 'unfixed';

	/// en: '$p% at all seats'
	String atAllSeats({required Object p}) => '${p}% at all seats';

	/// en: '$p% only at window seats'
	String onlyAtWindowSeats({required Object p}) => '${p}% only at window seats';

	/// en: 'Probabilty of power outlet available'
	String get probability => 'Probabilty of power outlet available';

	/// en: 'No trains matched'
	String get noTrainsMatched => 'No trains matched';

	/// en: 'Save search'
	String get saveSearch => 'Save search';

	/// en: 'Saved succesfully'
	String get savedSuccesfully => 'Saved succesfully';

	/// en: 'Saved searches'
	String get savedSearches => 'Saved searches';

	/// en: 'Set as startup search'
	String get setAsStartupSearch => 'Set as startup search';

	/// en: 'Latest info\n & Contact'
	String get infoAndContact => 'Latest info\n & Contact';

	/// en: 'Notice'
	String get notice => 'Notice';

	/// en: 'Term and Policy'
	String get termAndPolicy => 'Term and Policy';

	/// en: 'Agree to the disclaimer and terms of use, '
	String get agreeToTheDisclaimerAndTermsOfUse => 'Agree to the disclaimer and terms of use, ';

	/// en: 'Start using'
	String get startUsing => 'Start using';

	/// en: 'Version'
	String get version => 'Version';

	/// en: 'Release info'
	String get releaseInfo => 'Release info';

	/// en: 'Licenses'
	String get licenses => 'Licenses';

	/// en: ', '
	String get separator => ', ';

	/// en: 'or'
	String get or => 'or';

	/// en: 'close'
	String get close => 'close';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Error'
	String get error => 'Error';

	/// en: 'Service is currently suspended.\nPlease check "Latest info" for maintenance updates.'
	String get prodErrMsg => 'Service is currently suspended.\nPlease check "Latest info" for maintenance updates.';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'searchTrain' => 'Search Train',
			'today' => 'Today',
			'nextDay' => 'Tomorrow',
			'weekday' => 'Weekdays',
			'holiday' => 'Holidays',
			'noForecast' => 'No forecast',
			'noForecastComplement' => 'Probabilities based solely on ratios of fleet available outlet',
			'fromNowOn' => 'From now on',
			'allDay' => 'All day',
			'timeOption' => ({required Object h}) => '${h} or later',
			'departFrom' => ({required Object s}) => 'Depart from ${s}\n',
			'departureStation' => 'Departure station',
			'toward' => ({required Object s}) => 'Toward ${s}',
			'gettingOffAt' => 'Getting off at ',
			'filterByStoppingStations' => 'Filter by stopping stations',
			'anyOfSelectedStations' => 'Any of selected stations',
			'destination' => ({required Object s}) => 'for ${s}',
			'stopsAt' => ({required Object s}) => 'Stops at ${s}',
			'trainNo' => ({required Object n}) => ' No.${n}',
			'carNo' => ({required Object n}) => 'car\n${n}',
			'dep' => 'Dep.',
			'arv' => 'Arv.',
			'stopsName' => 'Stops',
			'unfixed' => 'unfixed',
			'atAllSeats' => ({required Object p}) => '${p}% at all seats',
			'onlyAtWindowSeats' => ({required Object p}) => '${p}% only at window seats',
			'probability' => 'Probabilty of power outlet available',
			'noTrainsMatched' => 'No trains matched',
			'saveSearch' => 'Save search',
			'savedSuccesfully' => 'Saved succesfully',
			'savedSearches' => 'Saved searches',
			'setAsStartupSearch' => 'Set as startup search',
			'infoAndContact' => 'Latest info\n & Contact',
			'notice' => 'Notice',
			'termAndPolicy' => 'Term and Policy',
			'agreeToTheDisclaimerAndTermsOfUse' => 'Agree to the disclaimer and terms of use, ',
			'startUsing' => 'Start using',
			'version' => 'Version',
			'releaseInfo' => 'Release info',
			'licenses' => 'Licenses',
			'separator' => ', ',
			'or' => 'or',
			'close' => 'close',
			'delete' => 'Delete',
			'error' => 'Error',
			'prodErrMsg' => 'Service is currently suspended.\nPlease check "Latest info" for maintenance updates.',
			_ => null,
		};
	}
}
