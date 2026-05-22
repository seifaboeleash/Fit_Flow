import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/styles.dart';
import '../../../../generated/l10n.dart';
import '../cubit/exercise_cubit.dart';

class ExerciseFinishButton extends StatelessWidget {
  const ExerciseFinishButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseCubit, ExerciseState>(
      builder: (context, state) {
        bool allDone = state is ExerciseCompleted;

        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 24.h, bottom: 8.h),
          child: ElevatedButton(
            onPressed: allDone ? () {
              Navigator.of(context).pop();
            } : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              disabledBackgroundColor: AppColors.outlineGrey,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Text(
              S.of(context).finish,
              style: Styles.textStyle16.copyWith(
                color: allDone ? AppColors.white : AppColors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
