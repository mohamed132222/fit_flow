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
class TranslationsAr with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsAr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ar,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ar>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key);

	late final TranslationsAr _root = this; // ignore: unused_field

	@override 
	TranslationsAr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsAr(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'FitFlow';
	@override late final _Translations$language$ar language = _Translations$language$ar._(_root);
	@override late final _Translations$splash$ar splash = _Translations$splash$ar._(_root);
	@override late final _Translations$onboarding$ar onboarding = _Translations$onboarding$ar._(_root);
}

// Path: language
class _Translations$language$ar implements Translations$language$en {
	_Translations$language$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اللغة';
	@override String get select => 'اختر اللغة';
}

// Path: splash
class _Translations$splash$ar implements Translations$splash$en {
	_Translations$splash$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get tagline => 'ارتقِ بحركتك';
}

// Path: onboarding
class _Translations$onboarding$ar implements Translations$onboarding$en {
	_Translations$onboarding$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختر هدفك';
	@override String get subtitle => 'خصّص رحلتك لأداءٍ دقيق ومتميّز.';
	@override String get weeklyAvailability => 'التوفر الأسبوعي';
	@override String get recommended => 'موصى به';
	@override String get recoveryCycle => 'دورة تعافٍ مثالية';
	@override String get continueButton => 'متابعة';
	@override String get canChangeLater => 'يمكنك تغيير هذا لاحقًا';
	@override late final _Translations$onboarding$goals$ar goals = _Translations$onboarding$goals$ar._(_root);
	@override late final _Translations$onboarding$availability$ar availability = _Translations$onboarding$availability$ar._(_root);
}

// Path: onboarding.goals
class _Translations$onboarding$goals$ar implements Translations$onboarding$goals$en {
	_Translations$onboarding$goals$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$onboarding$goals$buildMuscle$ar buildMuscle = _Translations$onboarding$goals$buildMuscle$ar._(_root);
	@override late final _Translations$onboarding$goals$getStrong$ar getStrong = _Translations$onboarding$goals$getStrong$ar._(_root);
	@override late final _Translations$onboarding$goals$generalFitness$ar generalFitness = _Translations$onboarding$goals$generalFitness$ar._(_root);
}

// Path: onboarding.availability
class _Translations$onboarding$availability$ar implements Translations$onboarding$availability$en {
	_Translations$onboarding$availability$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get days2 => 'يومان';
	@override String get days3 => '٣ أيام';
	@override String get days4 => '٤ أيام';
	@override String get days5plus => '٥+ أيام';
}

// Path: onboarding.goals.buildMuscle
class _Translations$onboarding$goals$buildMuscle$ar implements Translations$onboarding$goals$buildMuscle$en {
	_Translations$onboarding$goals$buildMuscle$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'بناء العضلات';
	@override String get description => 'ركّز على تضخيم العضلات والقوة.';
}

// Path: onboarding.goals.getStrong
class _Translations$onboarding$goals$getStrong$ar implements Translations$onboarding$goals$getStrong$en {
	_Translations$onboarding$goals$getStrong$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'زيادة القوة';
	@override String get description => 'أعطِ الأولوية لرفع الأثقال والقوة.';
}

// Path: onboarding.goals.generalFitness
class _Translations$onboarding$goals$generalFitness$ar implements Translations$onboarding$goals$generalFitness$en {
	_Translations$onboarding$goals$generalFitness$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اللياقة العامة';
	@override String get description => 'صحة وتوازن ومرونة.';
}

/// The flat map containing all translations for locale <ar>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'FitFlow',
			'language.title' => 'اللغة',
			'language.select' => 'اختر اللغة',
			'splash.tagline' => 'ارتقِ بحركتك',
			'onboarding.title' => 'اختر هدفك',
			'onboarding.subtitle' => 'خصّص رحلتك لأداءٍ دقيق ومتميّز.',
			'onboarding.weeklyAvailability' => 'التوفر الأسبوعي',
			'onboarding.recommended' => 'موصى به',
			'onboarding.recoveryCycle' => 'دورة تعافٍ مثالية',
			'onboarding.continueButton' => 'متابعة',
			'onboarding.canChangeLater' => 'يمكنك تغيير هذا لاحقًا',
			'onboarding.goals.buildMuscle.title' => 'بناء العضلات',
			'onboarding.goals.buildMuscle.description' => 'ركّز على تضخيم العضلات والقوة.',
			'onboarding.goals.getStrong.title' => 'زيادة القوة',
			'onboarding.goals.getStrong.description' => 'أعطِ الأولوية لرفع الأثقال والقوة.',
			'onboarding.goals.generalFitness.title' => 'اللياقة العامة',
			'onboarding.goals.generalFitness.description' => 'صحة وتوازن ومرونة.',
			'onboarding.availability.days2' => 'يومان',
			'onboarding.availability.days3' => '٣ أيام',
			'onboarding.availability.days4' => '٤ أيام',
			'onboarding.availability.days5plus' => '٥+ أيام',
			_ => null,
		};
	}
}
