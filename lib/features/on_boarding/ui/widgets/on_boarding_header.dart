import 'package:fit_flow/core/localization/locale_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_flow/core/theme/app_colors.dart';
import 'package:fit_flow/core/theme/styles.dart';
import 'package:fit_flow/generated/l10n.dart';
import 'package:flutter/material.dart';

class OnBoardingHeader extends StatelessWidget {
  const OnBoardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).appTitle,
          style: Styles.textStyle20.copyWith(color: AppColors.primaryColor),
        ),
        TextButton(
          onPressed: () {
            context.read<LocaleCubit>().toggleLanguage();
          },
          child: Text(
            context.watch<LocaleCubit>().state.languageCode == 'en' ? 'عربي' : 'EN',
            style: TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}