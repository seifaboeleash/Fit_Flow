import 'package:fit_flow/features/workout/domain/entities/workout_plan.dart';

extension GoalLocalization on Goal {
  String title(String langCode) => langCode == 'ar' ? titleAr : titleEn;
  String subtitle(String langCode) => langCode == 'ar' ? subtitleAr : subtitleEn;
}

extension PlanLocalization on WorkoutPlan {
  String name(String langCode) => langCode == 'ar' ? planNameAr : planNameEn;
  String description(String langCode) => langCode == 'ar' ? descriptionAr : descriptionEn;
}

extension WorkoutDayLocalization on WorkoutDay {
  String focus(String langCode) => langCode == 'ar' ? focusAr : focusEn;
  String name(String langCode) => 'Day $dayNumber - ${focus(langCode)}';
}

extension DayExerciseLocalization on DayExercise {
  String reps(String langCode) => langCode == 'ar' ? repsAr : repsEn;
  String restTime(String langCode) => langCode == 'ar' ? restTimeAr : restTimeEn;
}

extension ExerciseLocalization on Exercise {
  String name(String langCode) => langCode == 'ar' ? nameAr : nameEn;
  String muscleGroup(String langCode) => langCode == 'ar' ? muscleGroupAr : muscleGroupEn;
  String equipment(String langCode) => langCode == 'ar' ? equipmentAr : equipmentEn;
  String difficulty(String langCode) => langCode == 'ar' ? difficultyAr : difficultyEn;
  String category(String langCode) => langCode == 'ar' ? categoryAr : categoryEn;
  List<String> targetMuscles(String langCode) => langCode == 'ar' ? targetMusclesAr : targetMusclesEn;
  List<String> instructions(String langCode) => langCode == 'ar' ? instructionsAr : instructionsEn;
}
