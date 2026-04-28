import 'package:fit_flow/core/theme/app_colors.dart';
import 'package:fit_flow/core/theme/styles.dart';
import 'package:flutter/material.dart';

class OnBoardingHeader extends StatelessWidget {
  const OnBoardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'FitFlow',
          style: Styles.textStyle20.copyWith(color: AppColors.primaryColor),
        ),
        Icon(Icons.help_outline, color: AppColors.textDark),
      ],
    );
  }
}