import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/workout/domain/entities/workout_plan.dart';

part 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  Timer? _restTimer;
  late int _defaultRestTimeSeconds;

  ExerciseCubit() : super(ExerciseInitial());

  List<SetData> get _currentSets {
    final s = state;
    if (s is ExerciseLoaded) return s.sets;
    if (s is ExerciseResting) return s.sets;
    if (s is ExerciseCompleted) return s.sets;
    return [];
  }

  int get _currentIndex {
    final s = state;
    if (s is ExerciseLoaded) return s.currentSetIndex;
    if (s is ExerciseResting) return s.currentSetIndex;
    return 0;
  }

  void init(DayExercise dayExercise) {
    final defaultReps = dayExercise.repsEn;
    final numSets = dayExercise.sets;
    final sets = List.generate(
      numSets > 0 ? numSets : 3,
      (index) => SetData(weight: "-", reps: defaultReps),
    );

    String restString = dayExercise.restTimeEn;
    final match = RegExp(r'\d+').firstMatch(restString);
    if (match != null) {
      _defaultRestTimeSeconds = int.tryParse(match.group(0) ?? '60') ?? 60;
    } else {
      _defaultRestTimeSeconds = 60;
    }

    emit(ExerciseLoaded(sets: sets, currentSetIndex: 0));
  }

  void toggleSetDone(int index) {
    final sets = _currentSets;
    if (sets.isEmpty) return;
    
    sets[index].isDone = !sets[index].isDone;

    int newIndex = _currentIndex;
    
    if (sets[index].isDone) {
      if (index < sets.length - 1) {
        newIndex = index + 1;
      }
      
      bool allDone = sets.every((set) => set.isDone);
      if (allDone) {
        emit(ExerciseCompleted(sets: sets));
      } else {
        startRestTimer(sets: sets, newIndex: newIndex);
      }
    } else {
      stopRestTimer(sets: sets, newIndex: newIndex);
    }
  }

  void updateSetWeight(int index, String weight) {
    final sets = _currentSets;
    if (sets.isNotEmpty) sets[index].weight = weight;
  }

  void updateSetReps(int index, String reps) {
    final sets = _currentSets;
    if (sets.isNotEmpty) sets[index].reps = reps;
  }

  void startRestTimer({List<SetData>? sets, int? newIndex}) {
    _restTimer?.cancel();
    
    final currentSets = sets ?? _currentSets;
    final index = newIndex ?? _currentIndex;

    emit(ExerciseResting(
      sets: currentSets,
      currentSetIndex: index,
      remainingRestTime: _defaultRestTimeSeconds,
    ));

    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentState = state;
      if (currentState is ExerciseResting) {
        if (currentState.remainingRestTime > 0) {
          emit(ExerciseResting(
            sets: currentState.sets,
            currentSetIndex: currentState.currentSetIndex,
            remainingRestTime: currentState.remainingRestTime - 1,
          ));
        } else {
          stopRestTimer(sets: currentState.sets, newIndex: currentState.currentSetIndex);
        }
      } else {
        timer.cancel();
      }
    });
  }

  void stopRestTimer({List<SetData>? sets, int? newIndex}) {
    _restTimer?.cancel();
    
    final currentSets = sets ?? _currentSets;
    final index = newIndex ?? _currentIndex;
    
    bool allDone = currentSets.every((set) => set.isDone);
    if (allDone) {
      emit(ExerciseCompleted(sets: currentSets));
    } else {
      emit(ExerciseLoaded(
        sets: currentSets,
        currentSetIndex: index,
      ));
    }
  }

  @override
  Future<void> close() {
    _restTimer?.cancel();
    return super.close();
  }
}

