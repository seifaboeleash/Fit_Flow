// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(count) =>
      "${Intl.plural(count, zero: '0 أيام', one: 'يوم واحد', two: 'يومان', few: '${count} أيام', many: '${count} يوماً', other: '${count} يوم')}";

  static String m1(count) =>
      "${Intl.plural(count, zero: '0 تمرين', one: 'تمرين واحد', two: 'تمرينان', few: '${count} تمارين', many: '${count} تمريناً', other: '${count} تمرين')}";

  static String m2(count) =>
      "${Intl.plural(count, zero: '0 دقيقة', one: 'دقيقة واحدة', two: 'دقيقتان', few: '${count} دقائق', many: '${count} دقيقة', other: '${count} دقيقة')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "activePlanTitle":
            MessageLookupByLibrary.simpleMessage("الخطة الحالية"),
        "appTitle": MessageLookupByLibrary.simpleMessage("فيت فلو"),
        "changeLaterProfile": MessageLookupByLibrary.simpleMessage(
            "يمكنك تغيير هذا لاحقًا في الملف الشخصي"),
        "continueButton": MessageLookupByLibrary.simpleMessage("متابعة"),
        "daysCount": m0,
        "exerciseInstructions":
            MessageLookupByLibrary.simpleMessage("التعليمات"),
        "exerciseReps": MessageLookupByLibrary.simpleMessage("تكرارات"),
        "exerciseRest": MessageLookupByLibrary.simpleMessage("راحة"),
        "exerciseSets": MessageLookupByLibrary.simpleMessage("مجموعات"),
        "exercisesCount": m1,
        "finish": MessageLookupByLibrary.simpleMessage("إنهاء"),
        "fivePlusDays": MessageLookupByLibrary.simpleMessage("5+ أيام"),
        "goalBuildMuscle": MessageLookupByLibrary.simpleMessage("بناء العضلات"),
        "goalBuildMuscleDesc": MessageLookupByLibrary.simpleMessage(
            "التركيز على تضخيم العضلات والقوة."),
        "goalGeneralFitness":
            MessageLookupByLibrary.simpleMessage("اللياقة العامة"),
        "goalGeneralFitnessDesc":
            MessageLookupByLibrary.simpleMessage("صحة متوازنة وحركة."),
        "goalGetStrong": MessageLookupByLibrary.simpleMessage("زيادة القوة"),
        "goalGetStrongDesc": MessageLookupByLibrary.simpleMessage(
            "إعطاء الأولوية لرفع الأثقال."),
        "homeGoodMorning": MessageLookupByLibrary.simpleMessage("صباح الخير"),
        "homeLetsGetToWork":
            MessageLookupByLibrary.simpleMessage("لنبدأ العمل."),
        "homeRecovery": MessageLookupByLibrary.simpleMessage("الاستشفاء"),
        "homeRecoveryDesc": MessageLookupByLibrary.simpleMessage(
            "الحالة المثلى للتدريب اليوم."),
        "homeTodaysExercises":
            MessageLookupByLibrary.simpleMessage("تمارين اليوم"),
        "homeWeek1": MessageLookupByLibrary.simpleMessage("الأسبوع الأول"),
        "homeWeeklyBlueprint":
            MessageLookupByLibrary.simpleMessage("مخطط الأسبوع"),
        "homeWeeklyBurn":
            MessageLookupByLibrary.simpleMessage("الحرق الأسبوعي"),
        "homeWeeklyBurnDesc": MessageLookupByLibrary.simpleMessage(
            "السعرات الحرارية المحروقة هذا الأسبوع."),
        "kg": MessageLookupByLibrary.simpleMessage("كجم"),
        "minutesCount": m2,
        "navHome": MessageLookupByLibrary.simpleMessage("الرئيسية"),
        "navLearn": MessageLookupByLibrary.simpleMessage("التعلم"),
        "navProfile": MessageLookupByLibrary.simpleMessage("الملف الشخصي"),
        "notAvailable": MessageLookupByLibrary.simpleMessage("غير متوفر"),
        "onboardingDesc":
            MessageLookupByLibrary.simpleMessage("قم بتخصيص رحلتك لأداء دقيق."),
        "onboardingSubtitle":
            MessageLookupByLibrary.simpleMessage("يرجى تحديد هدفك وتوفرك"),
        "onboardingTitle": MessageLookupByLibrary.simpleMessage("اختر هدفك"),
        "reps": MessageLookupByLibrary.simpleMessage("تكرار"),
        "set": MessageLookupByLibrary.simpleMessage("مجموعة"),
        "startTimer": MessageLookupByLibrary.simpleMessage("بدء المؤقت"),
        "startWorkout": MessageLookupByLibrary.simpleMessage("ابدأ التمرين"),
        "unknownExercise":
            MessageLookupByLibrary.simpleMessage("تمرين غير معروف"),
        "weeklyAvailability":
            MessageLookupByLibrary.simpleMessage("التوفر الأسبوعي"),
        "weight": MessageLookupByLibrary.simpleMessage("الوزن")
      };
}
