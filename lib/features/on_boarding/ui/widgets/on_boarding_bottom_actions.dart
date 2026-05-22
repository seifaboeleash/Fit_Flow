import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fit_flow/core/theme/app_colors.dart';
import 'package:fit_flow/core/theme/styles.dart';
import 'package:fit_flow/core/shared/custom_button.dart';
import 'package:fit_flow/core/shared/custom_snack_bar.dart';
import 'package:fit_flow/generated/l10n.dart';
import 'package:fit_flow/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';

class OnBoardingBottomActions extends StatelessWidget {
  const OnBoardingBottomActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        CustomButton(
          text: S.of(context).continueButton,
          color: AppColors.primaryColor,
          textColor: AppColors.white,
          sufix: Icon(
            Icons.arrow_forward,
            color: AppColors.white,
          ),
          onTap: () {
            if (context.read<OnBoardingCubit>().canContinue()) {
              context.read<OnBoardingCubit>().completeOnboarding();
            } else {
              showCustomSnackBar(
                context,
                S.of(context).onboardingSubtitle,
              );
            }
          },
          radius: 1000.r,
        ),
        SizedBox(height: 16.h),
        Center(
          child: Text(
            S.of(context).changeLaterProfile,
            style: Styles.textStyle10.copyWith(
              color: AppColors.grey,
              letterSpacing: 1.1,
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
