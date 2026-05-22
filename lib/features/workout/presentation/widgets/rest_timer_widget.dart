import 'package:fit_flow/core/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/styles.dart';
import '../../../../generated/l10n.dart';
import '../cubit/exercise_cubit.dart';

class RestTimerWidget extends StatelessWidget {
  const RestTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseCubit, ExerciseState>(
      builder: (context, state) {
        if (state is! ExerciseResting) return const SizedBox.shrink();

        String minutes =
            (state.remainingRestTime ~/ 60).toString().padLeft(2, '0');
        String seconds =
            (state.remainingRestTime % 60).toString().padLeft(2, '0');

        // return Container(
        //   margin: EdgeInsets.only(top: 16.h, bottom: 8.h),
        //   padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
        //   decoration: BoxDecoration(
        //     color: AppColors.primaryColor.withOpacity(0.1),
        //     borderRadius: BorderRadius.circular(16.r),
        //     border: Border.all(color: AppColors.primaryColor),
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Row(
        //         children: [
        //           Icon(Icons.timer_outlined, color: AppColors.primaryColor, size: 24.r),
        //           SizedBox(width: 8.w),
        //           Text(
        //             S.of(context).exerciseRest,
        //             style: Styles.textStyle16.copyWith(
        //               fontWeight: FontWeight.bold,
        //               color: AppColors.primaryColor,
        //             ),
        //           ),
        //         ],
        //       ),
        //       Text(
        //         '$minutes:$seconds',
        //         style: TextStyle(
        //           fontSize: 24.sp,
        //           fontWeight: FontWeight.bold,
        //           color: AppColors.primaryColor,
        //           fontFamily: 'monospace',
        //         ),
        //       ),
        //     ],
        //   ),
        // );
        return CustomButton(
          prefix:
              Icon(Icons.timer_outlined, color: AppColors.white, size: 24.r),
          text: 'Start Rest Timer ($minutes:$seconds)',
          fontSize: 16.sp,
          color: AppColors.primaryColor,
          textColor: AppColors.white,
          radius: 999.r,
          width: 350.w,
          height: 50.h,
        );
      },
    );
  }
}
