// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `FitFlow`
  String get appTitle {
    return Intl.message(
      'FitFlow',
      name: 'appTitle',
      desc: 'The title of the application',
      args: [],
    );
  }

  /// `Continue`
  String get continueButton {
    return Intl.message('Continue', name: 'continueButton', desc: '', args: []);
  }

  /// `Please select your goal and availability`
  String get onboardingSubtitle {
    return Intl.message(
      'Please select your goal and availability',
      name: 'onboardingSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Build Muscle`
  String get goalBuildMuscle {
    return Intl.message(
      'Build Muscle',
      name: 'goalBuildMuscle',
      desc: '',
      args: [],
    );
  }

  /// `Focus on hypertrophy and strength.`
  String get goalBuildMuscleDesc {
    return Intl.message(
      'Focus on hypertrophy and strength.',
      name: 'goalBuildMuscleDesc',
      desc: '',
      args: [],
    );
  }

  /// `Get Strong`
  String get goalGetStrong {
    return Intl.message(
      'Get Strong',
      name: 'goalGetStrong',
      desc: '',
      args: [],
    );
  }

  /// `Prioritize heavy lifting and power.`
  String get goalGetStrongDesc {
    return Intl.message(
      'Prioritize heavy lifting and power.',
      name: 'goalGetStrongDesc',
      desc: '',
      args: [],
    );
  }

  /// `General Fitness`
  String get goalGeneralFitness {
    return Intl.message(
      'General Fitness',
      name: 'goalGeneralFitness',
      desc: '',
      args: [],
    );
  }

  /// `Balanced health and mobility.`
  String get goalGeneralFitnessDesc {
    return Intl.message(
      'Balanced health and mobility.',
      name: 'goalGeneralFitnessDesc',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get navHome {
    return Intl.message('Home', name: 'navHome', desc: '', args: []);
  }

  /// `Learn`
  String get navLearn {
    return Intl.message('Learn', name: 'navLearn', desc: '', args: []);
  }

  /// `Profile`
  String get navProfile {
    return Intl.message('Profile', name: 'navProfile', desc: '', args: []);
  }

  /// `Weekly Blueprint`
  String get homeWeeklyBlueprint {
    return Intl.message(
      'Weekly Blueprint',
      name: 'homeWeeklyBlueprint',
      desc: '',
      args: [],
    );
  }

  /// `Today's Exercises`
  String get homeTodaysExercises {
    return Intl.message(
      'Today\'s Exercises',
      name: 'homeTodaysExercises',
      desc: '',
      args: [],
    );
  }

  /// `Let's get to work.`
  String get homeLetsGetToWork {
    return Intl.message(
      'Let\'s get to work.',
      name: 'homeLetsGetToWork',
      desc: '',
      args: [],
    );
  }

  /// `Recovery`
  String get homeRecovery {
    return Intl.message('Recovery', name: 'homeRecovery', desc: '', args: []);
  }

  /// `Optimal status for training today.`
  String get homeRecoveryDesc {
    return Intl.message(
      'Optimal status for training today.',
      name: 'homeRecoveryDesc',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Burn`
  String get homeWeeklyBurn {
    return Intl.message(
      'Weekly Burn',
      name: 'homeWeeklyBurn',
      desc: '',
      args: [],
    );
  }

  /// `Active kcal burned this week.`
  String get homeWeeklyBurnDesc {
    return Intl.message(
      'Active kcal burned this week.',
      name: 'homeWeeklyBurnDesc',
      desc: '',
      args: [],
    );
  }

  /// `Week 1`
  String get homeWeek1 {
    return Intl.message('Week 1', name: 'homeWeek1', desc: '', args: []);
  }

  /// `Instructions`
  String get exerciseInstructions {
    return Intl.message(
      'Instructions',
      name: 'exerciseInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Select Your Goal`
  String get onboardingTitle {
    return Intl.message(
      'Select Your Goal',
      name: 'onboardingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Customize your journey for precision performance.`
  String get onboardingDesc {
    return Intl.message(
      'Customize your journey for precision performance.',
      name: 'onboardingDesc',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Availability`
  String get weeklyAvailability {
    return Intl.message(
      'Weekly Availability',
      name: 'weeklyAvailability',
      desc: '',
      args: [],
    );
  }

  /// `YOU CAN CHANGE THIS LATER IN PROFILE`
  String get changeLaterProfile {
    return Intl.message(
      'YOU CAN CHANGE THIS LATER IN PROFILE',
      name: 'changeLaterProfile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
