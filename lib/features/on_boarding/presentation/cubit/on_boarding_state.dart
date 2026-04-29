part of 'on_boarding_cubit.dart';

sealed class OnBoardingState {
  const OnBoardingState();
}

final class OnBoardingUpdated extends OnBoardingState {
  final WorkoutGoal? selectedGoal;
  final int selectedDays;

  const OnBoardingUpdated({this.selectedGoal, this.selectedDays = 3});
}

final class OnBoardingLoading extends OnBoardingState {}

final class OnBoardingSuccess extends OnBoardingState {}

final class OnBoardingError extends OnBoardingState {
  final String message;
  const OnBoardingError(this.message);
}
