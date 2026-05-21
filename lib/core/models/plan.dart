import 'package:hive/hive.dart';

part 'plan.g.dart';

@HiveType(typeId: 0)
class Plan extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String goal;

  @HiveField(3)
  final int daysPerWeek;

  @HiveField(4)
  final List<PlanDay> days;

  Plan({
    required this.id,
    required this.name,
    required this.goal,
    required this.daysPerWeek,
    required this.days,
  });
}

@HiveType(typeId: 1)
class PlanDay {
  @HiveField(0)
  final int dayNumber;

  @HiveField(1)
  final List<PlanExercise> exercises;

  PlanDay({
    required this.dayNumber,
    required this.exercises,
  });
}

@HiveType(typeId: 2)
class PlanExercise {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int sets;

  @HiveField(2)
  final int reps;

  @HiveField(3)
  final int durationMinutes;

  PlanExercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.durationMinutes,
  });
}
