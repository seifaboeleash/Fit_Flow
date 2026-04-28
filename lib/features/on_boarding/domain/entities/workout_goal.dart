enum WorkoutGoal {
  buildMuscle(
    title: 'Build Muscle',
    subtitle: 'Focus on hypertrophy and strength.',
    svgPath: 'assets/svgs/build_muscle.svg',
  ),
  getStrong(
    title: 'Get Strong',
    subtitle: 'Prioritize heavy lifting and power.',
    svgPath: 'assets/svgs/get_strong.svg',
  ),
  generalFitness(
    title: 'General Fitness',
    subtitle: 'Balanced health and mobility.',
    svgPath: 'assets/svgs/general_fitness.svg',
  );

  final String title;
  final String subtitle;
  final String svgPath;

  const WorkoutGoal({required this.title, required this.subtitle, required this.svgPath});
}
  