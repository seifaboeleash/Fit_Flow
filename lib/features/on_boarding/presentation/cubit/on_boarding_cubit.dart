import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/workout_goal.dart';
import '../../domain/repositories/on_boarding_repository.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final OnBoardingRepository _repository;

  OnBoardingCubit(this._repository) : super(const OnBoardingUpdated());

  void selectGoal(WorkoutGoal goal) {
    if (state is OnBoardingUpdated) {
      final currentState = state as OnBoardingUpdated;
      emit(
        OnBoardingUpdated(
          selectedGoal: goal,
          selectedDays: currentState.selectedDays,
        ),
      );
    }
  }

  void selectDays(int days) {
    if (state is OnBoardingUpdated) {
      final currentState = state as OnBoardingUpdated;
      emit(
        OnBoardingUpdated(
          selectedGoal: currentState.selectedGoal,
          selectedDays: days,
        ),
      );
    }
  }

  bool canContinue() {
    if (state is OnBoardingUpdated) {
      final currentState = state as OnBoardingUpdated;
      if(currentState.selectedGoal != null){
        return true;
      }
    }
    return false;
  }

  Future<void> completeOnboarding() async {
    if (state is OnBoardingUpdated) {
      final currentState = state as OnBoardingUpdated;
      if (currentState.selectedGoal == null) {
        emit(const OnBoardingError('Select goal and days first'));
        return;
      }
      
      final goalName = currentState.selectedGoal!.name;
      final days = currentState.selectedDays;

      emit(OnBoardingLoading());
      try {
        await _repository.savePreferences(
          goal: goalName,
          daysPerWeek: days,
        );
        emit(OnBoardingSuccess());
      } catch (e) {
        emit(OnBoardingError(e.toString()));
      }
    }
  }
}
