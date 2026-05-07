import 'package:fit_flow/generated/l10n.dart';

enum WorkoutGoal {
  buildMuscle(
    svgPath: 'assets/svgs/build_muscle.svg',
  ),
  getStrong(
    svgPath: 'assets/svgs/get_strong.svg',
  ),
  generalFitness(
    svgPath: 'assets/svgs/general_fitness.svg',
  );

  final String svgPath;

  const WorkoutGoal({required this.svgPath});

  String get title {
    switch (this) {
      case WorkoutGoal.buildMuscle:
        return S.current.goalBuildMuscle;
      case WorkoutGoal.getStrong:
        return S.current.goalGetStrong;
      case WorkoutGoal.generalFitness:
        return S.current.goalGeneralFitness;
    }
  }

  String get subtitle {
    switch (this) {
      case WorkoutGoal.buildMuscle:
        return S.current.goalBuildMuscleDesc;
      case WorkoutGoal.getStrong:
        return S.current.goalGetStrongDesc;
      case WorkoutGoal.generalFitness:
        return S.current.goalGeneralFitnessDesc;
    }
  }
}
  