import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/styles.dart';
import '../../../../generated/l10n.dart';
import '../../presentation/cubit/exercise_cubit.dart';

class SetsTable extends StatelessWidget {
  const SetsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseCubit, ExerciseState>(
      builder: (context, state) {
        List<SetData> sets = [];
        int currentSetIndex = 0;

        if (state is ExerciseLoaded) {
          sets = state.sets;
          currentSetIndex = state.currentSetIndex;
        } else if (state is ExerciseResting) {
          sets = state.sets;
          currentSetIndex = state.currentSetIndex;
        } else if (state is ExerciseCompleted) {
          sets = state.sets;
          currentSetIndex =
              sets.length; // Ensure no row is highlighted when completed
        } else {
          return const SizedBox.shrink(); // ExerciseInitial
        }

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(S.of(context).set,
                            style: Styles.textStyle12))),
                Expanded(
                    flex: 2,
                    child: Center(
                        child: Text(S.of(context).weight,
                            style: Styles.textStyle12))),
                Expanded(
                    flex: 2,
                    child: Center(
                        child: Text(S.of(context).reps,
                            style: Styles.textStyle12))),
                Expanded(flex: 1, child: const SizedBox.shrink()),
              ],
            ),
            SizedBox(height: 8.h),
            ...sets.asMap().entries.map((entry) {
              final index = entry.key;
              final setData = entry.value;
              final isActive = index == currentSetIndex;
              final isDone = setData.isDone;

              return Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: isDone
                      ? AppColors.primaryColor.withOpacity(0.1)
                      : isActive
                          ? AppColors.white
                          : AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isActive
                        ? AppColors.primaryColor
                        : AppColors.outlineGrey,
                    width: isActive ? 2 : 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: Styles.textStyle16.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDone
                                ? AppColors.primaryColor
                                : AppColors.textDark,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 36.h,
                        decoration: BoxDecoration(
                          color: AppColors.outlineGrey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: TextFormField(
                            initialValue: setData.weight,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: Styles.textStyle14
                                .copyWith(fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (val) => context
                                .read<ExerciseCubit>()
                                .updateSetWeight(index, val),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 36.h,
                        decoration: BoxDecoration(
                          color: AppColors.outlineGrey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: TextFormField(
                            initialValue: setData.reps,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: Styles.textStyle14
                                .copyWith(fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (val) => context
                                .read<ExerciseCubit>()
                                .updateSetReps(index, val),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () =>
                            context.read<ExerciseCubit>().toggleSetDone(index),
                        child: Container(
                          height: 32.w,
                          width: 32.w,
                          decoration: BoxDecoration(
                            color: isDone
                                ? AppColors.primaryColor
                                : AppColors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDone
                                  ? AppColors.primaryColor
                                  : AppColors.outlineGrey,
                              width: 2,
                            ),
                          ),
                          child: isDone
                              ? Icon(Icons.check,
                                  color: AppColors.white, size: 20.r)
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
