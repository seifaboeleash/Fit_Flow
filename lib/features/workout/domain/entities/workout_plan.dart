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
        'name': name,
        'goal': goal,
        'daysPerWeek': daysPerWeek,
        'level': level,
        'description': description,
        'days': days.map((e) => e.toJson()).toList(),
      };

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) => WorkoutPlan(
        id: json['id'],
        name: json['name'],
        goal: json['goal'],
        daysPerWeek: json['daysPerWeek'],
        level: json['level'],
        description: json['description'],
        days: (json['days'] as List).map((e) => WorkoutDay.fromJson(e)).toList(),
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
        'dayNumber': dayNumber,
        'name': name,
        'focus': focus,
        'exercises': exercises.map((e) => e.toJson()).toList(),
      };

  factory WorkoutDay.fromJson(Map<String, dynamic> json) => WorkoutDay(
        dayNumber: json['dayNumber'],
        name: json['name'],
        focus: json['focus'],
        exercises: (json['exercises'] as List).map((e) => DayExercise.fromJson(e)).toList(),
      );
}

class DayExercise {
  final String exerciseId;
  final int order;
  final int sets;
  final String reps;
  final int restSeconds;
  final String? notes;
  final Exercise? exerciseDetails;

  const DayExercise({
    required this.exerciseId,
    required this.order,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    this.notes,
    this.exerciseDetails,
  });

  DayExercise copyWith({
    String? exerciseId,
    int? order,
    int? sets,
    String? reps,
    int? restSeconds,
    String? notes,
    Exercise? exerciseDetails,
  }) {
    return DayExercise(
      exerciseId: exerciseId ?? this.exerciseId,
      order: order ?? this.order,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      restSeconds: restSeconds ?? this.restSeconds,
      notes: notes ?? this.notes,
      exerciseDetails: exerciseDetails ?? this.exerciseDetails,
    );
  }

  Map<String, dynamic> toJson() => {
        'exerciseId': exerciseId,
        'order': order,
        'sets': sets,
        'reps': reps,
        'restSeconds': restSeconds,
        'notes': notes,
        'exerciseDetails': exerciseDetails?.toJson(),
      };

  factory DayExercise.fromJson(Map<String, dynamic> json) => DayExercise(
        exerciseId: json['exerciseId'],
        order: json['order'],
        sets: json['sets'],
        reps: json['reps'],
        restSeconds: json['restSeconds'],
        notes: json['notes'],
        exerciseDetails: json['exerciseDetails'] != null ? Exercise.fromJson(json['exerciseDetails']) : null,
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
        'name': name,
        'muscleGroup': muscleGroup,
        'equipment': equipment,
        'difficulty': difficulty,
        'gifUrl': gifUrl,
        'instructions': instructions,
        'category': category,
        'targetMuscles': targetMuscles,
      };

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json['id'],
        name: json['name'],
        muscleGroup: json['muscleGroup'],
        equipment: json['equipment'],
        difficulty: json['difficulty'],
        gifUrl: json['gifUrl'],
        instructions: List<String>.from(json['instructions']),
        category: json['category'],
        targetMuscles: List<String>.from(json['targetMuscles']),
      );
}
