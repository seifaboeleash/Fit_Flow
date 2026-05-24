import 'package:fit_flow/features/workout/domain/entities/workout_plan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/on_boarding_repository.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final OnBoardingRepository _repository;

  OnBoardingCubit(this._repository) : super(OnBoardingLoadingGoals());

  Future<void> loadGoals() async {
    try {
      final goals = await _repository.getGoals();
      emit(OnBoardingUpdated(goals: goals));
    } catch (e) {
      emit(OnBoardingError('Failed to load goals: $e'));
    }
  }
    // sperate cubits
  void selectGoal(Goal goal) {
    if (state is OnBoardingUpdated) {
      final currentState = state as OnBoardingUpdated;
      emit(
        OnBoardingUpdated(
          selectedGoal: goal,
          selectedDays: currentState.selectedDays,
          goals: currentState.goals,
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
          goals: currentState.goals,
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
      
      final goalId = currentState.selectedGoal!.id;
      final days = currentState.selectedDays;
      final currentGoals = currentState.goals;

      emit(OnBoardingLoading());
      try {
        await _repository.savePreferences(
          goal: goalId,
          daysPerWeek: days,
        );
        emit(OnBoardingSuccess());
      } catch (e) {
        emit(OnBoardingUpdated(
            selectedGoal: currentState.selectedGoal,
            selectedDays: days,
            goals: currentGoals,
        ));
        emit(OnBoardingError(e.toString()));
      }
    }
  }
}
