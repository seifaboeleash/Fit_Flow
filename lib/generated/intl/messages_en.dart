// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) =>
      "${Intl.plural(count, one: '1 Day', other: '${count} Days')}";

  static String m1(count) =>
      "${Intl.plural(count, one: '1 Exercise', other: '${count} Exercises')}";

  static String m2(count) =>
      "${Intl.plural(count, one: '1 Minute', other: '${count} Minutes')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "activePlanTitle": MessageLookupByLibrary.simpleMessage("ACTIVE PLAN"),
        "appTitle": MessageLookupByLibrary.simpleMessage("FitFlow"),
        "changeLaterProfile": MessageLookupByLibrary.simpleMessage(
            "YOU CAN CHANGE THIS LATER IN PROFILE"),
        "continueButton": MessageLookupByLibrary.simpleMessage("Continue"),
        "daysCount": m0,
        "exerciseInstructions":
            MessageLookupByLibrary.simpleMessage("Instructions"),
        "exerciseReps": MessageLookupByLibrary.simpleMessage("REPS"),
        "exerciseRest": MessageLookupByLibrary.simpleMessage("REST"),
        "exerciseSets": MessageLookupByLibrary.simpleMessage("SETS"),
        "exercisesCount": m1,
        "fivePlusDays": MessageLookupByLibrary.simpleMessage("5+ Days"),
        "goalBuildMuscle": MessageLookupByLibrary.simpleMessage("Build Muscle"),
        "goalBuildMuscleDesc": MessageLookupByLibrary.simpleMessage(
            "Focus on hypertrophy and strength."),
        "goalGeneralFitness":
            MessageLookupByLibrary.simpleMessage("General Fitness"),
        "goalGeneralFitnessDesc": MessageLookupByLibrary.simpleMessage(
            "Balanced health and mobility."),
        "goalGetStrong": MessageLookupByLibrary.simpleMessage("Get Strong"),
        "goalGetStrongDesc": MessageLookupByLibrary.simpleMessage(
            "Prioritize heavy lifting and power."),
        "homeGoodMorning": MessageLookupByLibrary.simpleMessage("Good Morning"),
        "homeLetsGetToWork":
            MessageLookupByLibrary.simpleMessage("Let\'s get to work."),
        "homeRecovery": MessageLookupByLibrary.simpleMessage("Recovery"),
        "homeRecoveryDesc": MessageLookupByLibrary.simpleMessage(
            "Optimal status for training today."),
        "homeTodaysExercises":
            MessageLookupByLibrary.simpleMessage("Today\'s Exercises"),
        "homeWeek1": MessageLookupByLibrary.simpleMessage("Week 1"),
        "homeWeeklyBlueprint":
            MessageLookupByLibrary.simpleMessage("Weekly Blueprint"),
        "homeWeeklyBurn": MessageLookupByLibrary.simpleMessage("Weekly Burn"),
        "homeWeeklyBurnDesc": MessageLookupByLibrary.simpleMessage(
            "Active kcal burned this week."),
        "minutesCount": m2,
        "navHome": MessageLookupByLibrary.simpleMessage("Home"),
        "navLearn": MessageLookupByLibrary.simpleMessage("Learn"),
        "navProfile": MessageLookupByLibrary.simpleMessage("Profile"),
        "notAvailable": MessageLookupByLibrary.simpleMessage("N/A"),
        "onboardingDesc": MessageLookupByLibrary.simpleMessage(
            "Customize your journey for precision performance."),
        "onboardingSubtitle": MessageLookupByLibrary.simpleMessage(
            "Please select your goal and availability"),
        "onboardingTitle":
            MessageLookupByLibrary.simpleMessage("Select Your Goal"),
        "startWorkout": MessageLookupByLibrary.simpleMessage("Start Workout"),
        "unknownExercise":
            MessageLookupByLibrary.simpleMessage("Unknown Exercise"),
        "weeklyAvailability":
            MessageLookupByLibrary.simpleMessage("Weekly Availability")
      };
}
