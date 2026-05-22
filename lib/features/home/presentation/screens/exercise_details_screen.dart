import 'package:fit_flow/core/extensions/plan_localization_extension.dart';
import 'package:fit_flow/core/localization/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/styles.dart';
import '../../../workout/domain/entities/workout_plan.dart';
import 'package:fit_flow/generated/l10n.dart';
import '../../../workout/presentation/cubit/exercise_cubit.dart';
import '../../../workout/presentation/widgets/exercise_finish_button.dart';
import '../../../workout/presentation/widgets/exercise_stat_card.dart';
import '../../../workout/presentation/widgets/rest_timer_widget.dart';
import '../../../workout/presentation/widgets/sets_table.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  final Exercise exercise;
  final DayExercise dayExercise;

  const ExerciseDetailsScreen({
    super.key,
    required this.exercise,
    required this.dayExercise,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExerciseCubit()..init(dayExercise),
      child: _ExerciseDetailsView(exercise: exercise, dayExercise: dayExercise),
    );
  }
}

class _ExerciseDetailsView extends StatelessWidget {
  final Exercise exercise;
  final DayExercise dayExercise;

  const _ExerciseDetailsView({
    required this.exercise,
    required this.dayExercise,
  });

  @override
  Widget build(BuildContext context) {
    final lang = context.read<LocaleCubit>().state.languageCode;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: AppColors.textDark),
        title: Text(
          'Workout Session',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
      ),
      body: BlocBuilder<ExerciseCubit, ExerciseState>(
        builder: (context, state) {
          if (state is ExerciseInitial) {
            return const Center(
                child:
                    CircularProgressIndicator(color: AppColors.primaryColor));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'exercise_${exercise.id}',
                  child: Container(
                    width: double.infinity,
                    height: 220.h,
                    //color: AppColors.grey,
                    child: Image.asset(
                        'assets/images/Section - Media Zone (Top 30%).png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.name(lang),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: [
                          _buildChip(exercise.muscleGroup(lang)),
                          _buildChip(exercise.equipment(lang)),
                          _buildChip(exercise.difficulty(lang)),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      Container(
                        height: 246.h,
                        width: 350.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: AppColors.white,
                        ),
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 24.w,
                                  height: 24.w,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff004AC6),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(Icons.info_outlined,
                                      color: AppColors.white,
                                      //color: AppColors.primaryColor,
                                      size: 24.w),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  S.of(context).exerciseInstructions,
                                  style: Styles.textStyle18
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            ...exercise
                                .instructions(lang)
                                .asMap()
                                .entries
                                .map((entry) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: Row(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 8.w,
                                      height: 8.w,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff004AC6),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      // child: Text(
                                      //   '${entry.key + 1}',
                                      //   style: TextStyle(
                                      //       color: AppColors.white,
                                      //       fontSize: 12.sp,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Text(
                                        entry.value,
                                        style: Styles.textStyle14.copyWith(
                                            height: 1.5,
                                            color: AppColors.textDark),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            // Sets Table
                          ],
                        ),
                      ),
                      const SetsTable(),

                      // Rest Timer
                      const RestTimerWidget(),

                      // Finish Button
                      // const ExerciseFinishButton(),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildChip(String label) {
    if (label.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.outlineGrey,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: Styles.textStyle12.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
 // Row(
                      //   children: [
                      //     Expanded(
                      //         child: ExerciseStatCard(
                      //             title: S.of(context).exerciseSets,
                      //             value: '${dayExercise.sets}')),
                      //     SizedBox(width: 12.w),
                      //     Expanded(
                      //         child: ExerciseStatCard(
                      //             title: S.of(context).exerciseReps,
                      //             value: dayExercise.reps(lang))),
                      //     SizedBox(width: 12.w),
                      //     Expanded(
                      //         child: ExerciseStatCard(
                      //             title: S.of(context).exerciseRest,
                      //             value: dayExercise.restTime(lang))),
                      //   ],
                      // ),
                      // SizedBox(height: 24.h),