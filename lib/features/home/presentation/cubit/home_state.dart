part of 'home_cubit.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  final DashboardData data;

  const HomeLoaded(this.data);
}

final class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}
