part of 'exercise_cubit.dart';

abstract class ExerciseState {}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoaded extends ExerciseState {
  final List<SetData> sets;
  final int currentSetIndex;

  ExerciseLoaded({required this.sets, required this.currentSetIndex});
}

class ExerciseResting extends ExerciseState {
  final List<SetData> sets;
  final int currentSetIndex;
  final int remainingRestTime;

  ExerciseResting({
    required this.sets,
    required this.currentSetIndex,
    required this.remainingRestTime,
  });
}

class ExerciseCompleted extends ExerciseState {
  final List<SetData> sets;
  ExerciseCompleted({required this.sets});
}

class SetData {
  String weight;
  String reps;
  bool isDone;

  SetData({
    required this.weight,
    required this.reps,
    this.isDone = false,
  });
}
