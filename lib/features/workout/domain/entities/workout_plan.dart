import 'package:intl/intl.dart';
class Goal {
  final String id;
  final String titleEn;
  final String titleAr;
  final String subtitleEn;
  final String subtitleAr;

  const Goal({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.subtitleEn,
    required this.subtitleAr,
  });

  String get title => Intl.getCurrentLocale().contains('ar') ? titleAr : titleEn;
  String get subtitle => Intl.getCurrentLocale().contains('ar') ? subtitleAr : subtitleEn;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title_en': titleEn,
        'title_ar': titleAr,
        'subtitle_en': subtitleEn,
        'subtitle_ar': subtitleAr,
      };

  factory Goal.fromJson(Map<String, dynamic> json) => Goal(
        id: json['id'] ?? '',
        titleEn: json['title_en'] ?? '',
        titleAr: json['title_ar'] ?? '',
        subtitleEn: json['subtitle_en'] ?? '',
        subtitleAr: json['subtitle_ar'] ?? '',
      );
}

class WorkoutPlan {
  final String id;
  final String goalId;
  final int daysPerWeek;
  final String planNameEn;
  final String planNameAr;
  final String descriptionEn;
  final String descriptionAr;
  final List<WorkoutDay> days;

  const WorkoutPlan({
    required this.id,
    required this.goalId,
    required this.daysPerWeek,
    required this.planNameEn,
    required this.planNameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.days,
  });

  String get name => Intl.getCurrentLocale().contains('ar') ? planNameAr : planNameEn;
  String get description => Intl.getCurrentLocale().contains('ar') ? descriptionAr : descriptionEn;

  Map<String, dynamic> toJson() => {
        'id': id,
        'goal_id': goalId,
        'days_per_week': daysPerWeek,
        'plan_name_en': planNameEn,
        'plan_name_ar': planNameAr,
        'description_en': descriptionEn,
        'description_ar': descriptionAr,
        'days': days.map((e) => e.toJson()).toList(),
      };

  factory WorkoutPlan.fromJson(Map<String, dynamic> json, {List<WorkoutDay> days = const []}) => WorkoutPlan(
        id: json['id'] ?? '',
        goalId: json['goal_id'] ?? '',
        daysPerWeek: json['days_per_week'] ?? 0,
        planNameEn: json['plan_name_en'] ?? '',
        planNameAr: json['plan_name_ar'] ?? '',
        descriptionEn: json['description_en'] ?? '',
        descriptionAr: json['description_ar'] ?? '',
        days: days.isNotEmpty ? days : (json['workouts'] as List?)?.map((e) => WorkoutDay.fromJson(e)).toList() ?? [],
      );
}

class WorkoutDay {
  final int dayNumber;
  final String focusEn;
  final String focusAr;
  final List<DayExercise> exercises;

  const WorkoutDay({
    required this.dayNumber,
    required this.focusEn,
    required this.focusAr,
    required this.exercises,
  });

  String get focus => Intl.getCurrentLocale().contains('ar') ? focusAr : focusEn;
  // Fallback for some previous code trying to use name
  String get name => 'Day $dayNumber - $focus'; 

  Map<String, dynamic> toJson() => {
        'day_number': dayNumber,
        'focus_en': focusEn,
        'focus_ar': focusAr,
        'exercises': exercises.map((e) => e.toJson()).toList(),
      };

  factory WorkoutDay.fromJson(Map<String, dynamic> json, {List<DayExercise> exercises = const []}) => WorkoutDay(
        dayNumber: json['day_number'] ?? 0,
        focusEn: json['focus_en'] ?? '',
        focusAr: json['focus_ar'] ?? '',
        exercises: exercises.isNotEmpty ? exercises : (json['exercises'] as List?)?.map((e) => DayExercise.fromJson(e)).toList() ?? [],
      );
}

class DayExercise {
  final String exerciseId;
  final String? notes;
  final int order;
  final String repsEn;
  final String repsAr;
  final int sets;
  final String restTimeEn;
  final String restTimeAr;
  final Exercise? exerciseDetails;

  const DayExercise({
    required this.exerciseId,
    this.notes,
    required this.order,
    required this.repsEn,
    required this.repsAr,
    required this.sets,
    required this.restTimeEn,
    required this.restTimeAr,
    this.exerciseDetails,
  });

  String get reps => Intl.getCurrentLocale().contains('ar') ? repsAr : repsEn;
  String get restTime => Intl.getCurrentLocale().contains('ar') ? restTimeAr : restTimeEn;

  DayExercise copyWith({
    String? exerciseId,
    String? notes,
    int? order,
    String? repsEn,
    String? repsAr,
    int? sets,
    String? restTimeEn,
    String? restTimeAr,
    Exercise? exerciseDetails,
  }) {
    return DayExercise(
      exerciseId: exerciseId ?? this.exerciseId,
      notes: notes ?? this.notes,
      order: order ?? this.order,
      repsEn: repsEn ?? this.repsEn,
      repsAr: repsAr ?? this.repsAr,
      sets: sets ?? this.sets,
      restTimeEn: restTimeEn ?? this.restTimeEn,
      restTimeAr: restTimeAr ?? this.restTimeAr,
      exerciseDetails: exerciseDetails ?? this.exerciseDetails,
    );
  }

  Map<String, dynamic> toJson() => {
        'exerciseId': exerciseId,
        'notes': notes,
        'order': order,
        'reps_en': repsEn,
        'reps_ar': repsAr,
        'sets': sets,
        'rest_time_en': restTimeEn,
        'rest_time_ar': restTimeAr,
        'exerciseDetails': exerciseDetails?.toJson(),
      };

  factory DayExercise.fromJson(Map<String, dynamic> json, {Exercise? exerciseDetails}) => DayExercise(
        exerciseId: json['exerciseId'] ?? json['exercise_id'] ?? '',
        notes: json['notes'],
        order: json['order'] ?? 0,
        repsEn: json['reps_en'] ?? '',
        repsAr: json['reps_ar'] ?? '',
        sets: json['sets'] ?? 0,
        restTimeEn: json['rest_time_en'] ?? '',
        restTimeAr: json['rest_time_ar'] ?? '',
        exerciseDetails: exerciseDetails ?? (json['exerciseDetails'] != null ? Exercise.fromJson(json['exerciseDetails']) : null),
      );
}

class Exercise {
  final String id;
  final String nameEn;
  final String nameAr;
  final String muscleGroupEn;
  final String muscleGroupAr;
  final String equipmentEn;
  final String equipmentAr;
  final String difficultyEn;
  final String difficultyAr;
  final String categoryEn;
  final String categoryAr;
  final List<String> targetMusclesEn;
  final List<String> targetMusclesAr;
  final String videoUrl;
  final List<String> instructionsEn;
  final List<String> instructionsAr;

  const Exercise({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.muscleGroupEn,
    required this.muscleGroupAr,
    required this.equipmentEn,
    required this.equipmentAr,
    required this.difficultyEn,
    required this.difficultyAr,
    required this.categoryEn,
    required this.categoryAr,
    required this.targetMusclesEn,
    required this.targetMusclesAr,
    required this.videoUrl,
    required this.instructionsEn,
    required this.instructionsAr,
  });

  String get name => Intl.getCurrentLocale().contains('ar') ? nameAr : nameEn;
  String get muscleGroup => Intl.getCurrentLocale().contains('ar') ? muscleGroupAr : muscleGroupEn;
  String get equipment => Intl.getCurrentLocale().contains('ar') ? equipmentAr : equipmentEn;
  String get difficulty => Intl.getCurrentLocale().contains('ar') ? difficultyAr : difficultyEn;
  String get category => Intl.getCurrentLocale().contains('ar') ? categoryAr : categoryEn;
  List<String> get targetMuscles => Intl.getCurrentLocale().contains('ar') ? targetMusclesAr : targetMusclesEn;
  List<String> get instructions => Intl.getCurrentLocale().contains('ar') ? instructionsAr : instructionsEn;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name_en': nameEn,
        'name_ar': nameAr,
        'muscleGroup_en': muscleGroupEn,
        'muscleGroup_ar': muscleGroupAr,
        'equipment_en': equipmentEn,
        'equipment_ar': equipmentAr,
        'difficulty_en': difficultyEn,
        'difficulty_ar': difficultyAr,
        'category_en': categoryEn,
        'category_ar': categoryAr,
        'targetMuscles_en': targetMusclesEn,
        'targetMuscles_ar': targetMusclesAr,
        'videoUrl': videoUrl,
        'instructions_en': instructionsEn,
        'instructions_ar': instructionsAr,
      };

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] ?? '',
      nameEn: json['name_en'] ?? '',
      nameAr: json['name_ar'] ?? '',
      muscleGroupEn: json['muscleGroup_en'] ?? '',
      muscleGroupAr: json['muscleGroup_ar'] ?? '',
      equipmentEn: json['equipment_en'] ?? '',
      equipmentAr: json['equipment_ar'] ?? '',
      difficultyEn: json['difficulty_en'] ?? '',
      difficultyAr: json['difficulty_ar'] ?? '',
      categoryEn: json['category_en'] ?? '',
      categoryAr: json['category_ar'] ?? '',
      targetMusclesEn: List<String>.from(json['targetMuscles_en'] ?? []),
      targetMusclesAr: List<String>.from(json['targetMuscles_ar'] ?? []),
      videoUrl: json['videoUrl'] ?? '',
      instructionsEn: List<String>.from(json['instructions_en'] ?? []),
      instructionsAr: List<String>.from(json['instructions_ar'] ?? []),
    );
  }
}
