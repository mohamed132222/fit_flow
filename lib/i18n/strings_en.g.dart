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
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	dynamic operator[](String key) => _meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: 'FitFlow'
	String get appName => 'FitFlow';

	late final Translations$language$en language = Translations$language$en._(_root);
	late final Translations$splash$en splash = Translations$splash$en._(_root);
	late final Translations$onboarding$en onboarding = Translations$onboarding$en._(_root);
}

// Path: language
class Translations$language$en {
	Translations$language$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Language'
	String get title => 'Language';

	/// en: 'Select language'
	String get select => 'Select language';
}

// Path: splash
class Translations$splash$en {
	Translations$splash$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'ELEVATE YOUR MOVEMENT'
	String get tagline => 'ELEVATE YOUR MOVEMENT';
}

// Path: onboarding
class Translations$onboarding$en {
	Translations$onboarding$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select Your Goal'
	String get title => 'Select Your Goal';

	/// en: 'Customize your journey for precision performance.'
	String get subtitle => 'Customize your journey for precision\nperformance.';

	/// en: 'Weekly Availability'
	String get weeklyAvailability => 'Weekly Availability';

	/// en: 'RECOMMENDED'
	String get recommended => 'RECOMMENDED';

	/// en: 'Optimal recovery cycle'
	String get recoveryCycle => 'Optimal recovery cycle';

	/// en: 'Continue'
	String get continueButton => 'Continue';

	/// en: 'YOU CAN CHANGE THIS LATER'
	String get canChangeLater => 'YOU CAN CHANGE THIS LATER';

	late final Translations$onboarding$goals$en goals = Translations$onboarding$goals$en._(_root);
	late final Translations$onboarding$availability$en availability = Translations$onboarding$availability$en._(_root);
}

// Path: onboarding.goals
class Translations$onboarding$goals$en {
	Translations$onboarding$goals$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$onboarding$goals$buildMuscle$en buildMuscle = Translations$onboarding$goals$buildMuscle$en._(_root);
	late final Translations$onboarding$goals$getStrong$en getStrong = Translations$onboarding$goals$getStrong$en._(_root);
	late final Translations$onboarding$goals$generalFitness$en generalFitness = Translations$onboarding$goals$generalFitness$en._(_root);
}

// Path: onboarding.availability
class Translations$onboarding$availability$en {
	Translations$onboarding$availability$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '2 Days'
	String get days2 => '2 Days';

	/// en: '3 Days'
	String get days3 => '3 Days';

	/// en: '4 Days'
	String get days4 => '4 Days';

	/// en: '5+ Days'
	String get days5plus => '5+ Days';
}

// Path: onboarding.goals.buildMuscle
class Translations$onboarding$goals$buildMuscle$en {
	Translations$onboarding$goals$buildMuscle$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Build Muscle'
	String get title => 'Build Muscle';

	/// en: 'Focus on hypertrophy and strength.'
	String get description => 'Focus on hypertrophy and\nstrength.';
}

// Path: onboarding.goals.getStrong
class Translations$onboarding$goals$getStrong$en {
	Translations$onboarding$goals$getStrong$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Get Strong'
	String get title => 'Get Strong';

	/// en: 'Prioritize heavy lifting and power.'
	String get description => 'Prioritize heavy lifting and power.';
}

// Path: onboarding.goals.generalFitness
class Translations$onboarding$goals$generalFitness$en {
	Translations$onboarding$goals$generalFitness$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'General Fitness'
	String get title => 'General Fitness';

	/// en: 'Balanced health and mobility.'
	String get description => 'Balanced health and mobility.';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'FitFlow',
			'language.title' => 'Language',
			'language.select' => 'Select language',
			'splash.tagline' => 'ELEVATE YOUR MOVEMENT',
			'onboarding.title' => 'Select Your Goal',
			'onboarding.subtitle' => 'Customize your journey for precision\nperformance.',
			'onboarding.weeklyAvailability' => 'Weekly Availability',
			'onboarding.recommended' => 'RECOMMENDED',
			'onboarding.recoveryCycle' => 'Optimal recovery cycle',
			'onboarding.continueButton' => 'Continue',
			'onboarding.canChangeLater' => 'YOU CAN CHANGE THIS LATER',
			'onboarding.goals.buildMuscle.title' => 'Build Muscle',
			'onboarding.goals.buildMuscle.description' => 'Focus on hypertrophy and\nstrength.',
			'onboarding.goals.getStrong.title' => 'Get Strong',
			'onboarding.goals.getStrong.description' => 'Prioritize heavy lifting and power.',
			'onboarding.goals.generalFitness.title' => 'General Fitness',
			'onboarding.goals.generalFitness.description' => 'Balanced health and mobility.',
			'onboarding.availability.days2' => '2 Days',
			'onboarding.availability.days3' => '3 Days',
			'onboarding.availability.days4' => '4 Days',
			'onboarding.availability.days5plus' => '5+ Days',
			_ => null,
		};
	}
}
