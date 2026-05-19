import 'package:intl/intl.dart';

String _getLocalized(Map<String, dynamic> json, String keyEn, String keyAr) {
  final isArabic = Intl.getCurrentLocale().contains('ar');
  return json[isArabic ? keyAr : keyEn] ?? json[keyEn] ?? '';
}

class WorkoutPlan {
  final String id;
  final String name;
  final String goal;
  final int daysPerWeek;
  final String level;
  final String description;
  final List<WorkoutDay> days;

  const WorkoutPlan({
    required this.id,
    required this.name,
    required this.goal,
    required this.daysPerWeek,
    required this.level,
    required this.description,
    required this.days,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'plan_name_en': name,
        'goal_id': goal,
        'days_per_week': daysPerWeek,
        'level': level,
        'description_en': description,
        'days': days.map((e) => e.toJson()).toList(),
      };

  factory WorkoutPlan.fromJson(Map<String, dynamic> json, {List<WorkoutDay> days = const []}) => WorkoutPlan(
        id: json['id'] ?? '',
        name: _getLocalized(json, 'plan_name_en', 'plan_name_ar'),
        goal: json['goal_id'] ?? json['goal'] ?? '',
        daysPerWeek: json['days_per_week'] ?? json['daysPerWeek'] ?? 0,
        level: json['level'] ?? '',
        description: _getLocalized(json, 'description_en', 'description_ar'),
        days: days.isNotEmpty ? days : (json['workouts'] as List?)?.map((e) => WorkoutDay.fromJson(e)).toList() ?? [],
      );
}

class WorkoutDay {
  final int dayNumber;
  final String name;
  final String focus;
  final List<DayExercise> exercises;

  const WorkoutDay({
    required this.dayNumber,
    required this.name,
    required this.focus,
    required this.exercises,
  });

  Map<String, dynamic> toJson() => {
        'day_number': dayNumber,
        'name': name,
        'focus_en': focus,
        'exercises': exercises.map((e) => e.toJson()).toList(),
      };

  factory WorkoutDay.fromJson(Map<String, dynamic> json, {List<DayExercise> exercises = const []}) => WorkoutDay(
        dayNumber: json['day_number'] ?? json['dayNumber'] ?? 0,
        name: json['name'] ?? '',
        focus: _getLocalized(json, 'focus_en', 'focus_ar'),
        exercises: exercises.isNotEmpty ? exercises : (json['exercises'] as List?)?.map((e) => DayExercise.fromJson(e)).toList() ?? [],
      );
}

class DayExercise {
  final String exerciseId;
  final int order;
  final int sets;
  final String reps;
  final String restTime;
  final String? notes;
  final Exercise? exerciseDetails;

  const DayExercise({
    required this.exerciseId,
    required this.order,
    required this.sets,
    required this.reps,
    required this.restTime,
    this.notes,
    this.exerciseDetails,
  });

  DayExercise copyWith({
    String? exerciseId,
    int? order,
    int? sets,
    String? reps,
    String? restTime,
    String? notes,
    Exercise? exerciseDetails,
  }) {
    return DayExercise(
      exerciseId: exerciseId ?? this.exerciseId,
      order: order ?? this.order,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      restTime: restTime ?? this.restTime,
      notes: notes ?? this.notes,
      exerciseDetails: exerciseDetails ?? this.exerciseDetails,
    );
  }

  Map<String, dynamic> toJson() => {
        'exercise_id': exerciseId,
        'order': order,
        'sets': sets,
        'reps_en': reps,
        'rest_time_en': restTime,
        'notes': notes,
        'exerciseDetails': exerciseDetails?.toJson(),
      };

  factory DayExercise.fromJson(Map<String, dynamic> json, {Exercise? exerciseDetails}) => DayExercise(
        exerciseId: json['exercise_id'] ?? json['exerciseId'] ?? '',
        order: json['order'] ?? 0,
        sets: json['sets'] ?? 0,
        reps: _getLocalized(json, 'reps_en', 'reps_ar'),
        restTime: _getLocalized(json, 'rest_time_en', 'rest_time_ar'),
        notes: json['notes'],
        exerciseDetails: exerciseDetails ?? (json['exerciseDetails'] != null ? Exercise.fromJson(json['exerciseDetails']) : null),
      );
}

class Exercise {
  final String id;
  final String name;
  final String muscleGroup;
  final String equipment;
  final String difficulty;
  final String gifUrl;
  final List<String> instructions;
  final String category;
  final List<String> targetMuscles;

  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.equipment,
    required this.difficulty,
    required this.gifUrl,
    required this.instructions,
    required this.category,
    required this.targetMuscles,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name_en': name,
        'muscleGroup_en': muscleGroup,
        'equipment_en': equipment,
        'difficulty': difficulty,
        'gifUrl': gifUrl,
        'instructions_en': instructions,
        'category_en': category,
        'targetMuscles_en': targetMuscles,
      };

  factory Exercise.fromJson(Map<String, dynamic> json) {
    final isArabic = Intl.getCurrentLocale().contains('ar');
    return Exercise(
      id: json['id'] ?? '',
      name: _getLocalized(json, 'name_en', 'name_ar'),
      muscleGroup: _getLocalized(json, 'muscleGroup_en', 'muscleGroup_ar'),
      equipment: _getLocalized(json, 'equipment_en', 'equipment_ar'),
      difficulty: json['difficulty'] ?? '',
      gifUrl: json['gifUrl'] ?? '',
      instructions: List<String>.from(json[isArabic ? 'instructions_ar' : 'instructions_en'] ?? json['instructions_en'] ?? []),
      category: _getLocalized(json, 'category_en', 'category_ar'),
      targetMuscles: List<String>.from(json[isArabic ? 'targetMuscles_ar' : 'targetMuscles_en'] ?? json['targetMuscles_en'] ?? []),
    );
  }
}
