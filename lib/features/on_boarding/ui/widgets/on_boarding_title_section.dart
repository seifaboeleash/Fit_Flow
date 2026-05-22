import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fit_flow/core/theme/app_colors.dart';
import 'package:fit_flow/core/theme/styles.dart';
import 'package:fit_flow/generated/l10n.dart';

class OnBoardingTitleSection extends StatelessWidget {
  const OnBoardingTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).onboardingTitle,
          style: TextStyle(
            fontSize: 34.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          S.of(context).onboardingDesc,
          style: Styles.textStyle14,
        ),
      ],
    );
  }
}
