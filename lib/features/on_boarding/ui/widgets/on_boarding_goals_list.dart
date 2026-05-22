import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_flow/features/workout/domain/entities/workout_plan.dart';
import 'package:fit_flow/core/extensions/plan_localization_extension.dart';
import 'package:fit_flow/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fit_flow/features/on_boarding/ui/widgets/goal_selection_card.dart';

class OnBoardingGoalsList extends StatelessWidget {
  final List<Goal> displayGoals;
  final String? displaySelectedGoalId;
  final bool isLoading;
  final String lang;

  const OnBoardingGoalsList({
    super.key,
    required this.displayGoals,
    this.displaySelectedGoalId,
    required this.isLoading,
    required this.lang,
  });

  String _getSvgPathForGoal(String id) {
    switch (id) {
      case 'build_muscle':
        return 'assets/svgs/build_muscle.svg';
      case 'get_strong':
        return 'assets/svgs/get_strong.svg';
      case 'general_fitness':
      default:
        return 'assets/svgs/general_fitness.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: displayGoals.map((goal) => GoalSelectionCard(
        title: goal.title(lang),
        subtitle: goal.subtitle(lang),
        svgPath: _getSvgPathForGoal(goal.id),
        isSelected: displaySelectedGoalId == goal.id,
        onTap: () {
          if (!isLoading) {
            context.read<OnBoardingCubit>().selectGoal(goal);
          }
        },
      )).toList(),
    );
  }
}
