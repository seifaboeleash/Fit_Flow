part of 'on_boarding_cubit.dart';

sealed class OnBoardingState {
  const OnBoardingState();
}

final class OnBoardingLoadingGoals extends OnBoardingState {}

final class OnBoardingUpdated extends OnBoardingState {
  final Goal? selectedGoal;
  final int selectedDays;
  final List<Goal> goals;

  const OnBoardingUpdated({
    this.selectedGoal, 
    this.selectedDays = 3,
    this.goals = const [],
  });
}

final class OnBoardingLoading extends OnBoardingState {}

final class OnBoardingSuccess extends OnBoardingState {}

final class OnBoardingError extends OnBoardingState {
  final String message;
  const OnBoardingError(this.message);
}
