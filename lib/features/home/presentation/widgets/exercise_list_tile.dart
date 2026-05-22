import 'package:fit_flow/core/extensions/plan_localization_extension.dart';
import 'package:fit_flow/core/localization/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/styles.dart';
import '../../../workout/domain/entities/workout_plan.dart';
import '../screens/exercise_details_screen.dart';
import 'package:fit_flow/generated/l10n.dart';

class ExerciseListTile extends StatelessWidget {
  final DayExercise exercise;

  const ExerciseListTile({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final details = exercise.exerciseDetails;
    final lang = context.read<LocaleCubit>().state.languageCode;

    return GestureDetector(
      onTap: () {
        if (details != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ExerciseDetailsScreen(
                exercise: details,
                dayExercise: exercise,
              ),
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.outlineGrey),
        ),
        child: Row(
          children: [
            Hero(
              tag: 'exercise_${details?.id ?? exercise.exerciseId}',
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.layers, color: AppColors.primaryColor),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    details?.name(lang) ?? S.of(context).unknownExercise,
                    style:
                        Styles.textStyle16.copyWith(color: AppColors.textDark),
                  ),
                  SizedBox(height: 4.h),
                  Text(details?.muscleGroup(lang) ?? S.of(context).notAvailable,
                      style: Styles.textStyle14),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${exercise.sets} × ${exercise.reps(lang)}',
                  style: Styles.textStyle16.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  S.of(context).exerciseReps,
                  style: Styles.textStyle10.copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
