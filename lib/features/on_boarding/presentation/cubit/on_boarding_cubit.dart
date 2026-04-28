import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/workout_goal.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(const OnBoardingUpdated());

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
}
