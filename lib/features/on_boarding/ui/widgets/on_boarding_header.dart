import 'package:fit_flow/core/localization/locale_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_flow/core/theme/app_colors.dart';
import 'package:fit_flow/core/theme/styles.dart';
import 'package:fit_flow/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        InkWell(
          onTap: () {
            showLanguagePopupMenu(context);
          },
          child: Row(
            children: [
              Text(
                context.watch<LocaleCubit>().state.languageCode == 'en'
                    ? 'En'
                    : 'Ar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.language, size: 24),
            ],
          ),
        ),
      ],
    );
  }
  void showLanguagePopupMenu(BuildContext context) {
    final LocaleCubit localeCubit = context.read<LocaleCubit>();
    showMenu(
      context: context,
      color: AppColors.backgroundColor,
      position: localeCubit.state.languageCode == 'en'
          ? RelativeRect.fromLTRB(200, 100, 0, 0)
          : RelativeRect.fromLTRB(0, 100, 200, 0),
      items: [
        PopupMenuItem(
          value: 'en',
          child: Text(
            'English',
            style: TextStyle(
              color: localeCubit.state.languageCode == 'en'
                  ? AppColors.primaryColor
                  : AppColors.textDark,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        PopupMenuItem(
          value: 'ar',
          child: Text(
            'العربية',
            style: TextStyle(
              color: localeCubit.state.languageCode == 'ar'
                  ? AppColors.primaryColor
                  : AppColors.textDark,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        context.read<LocaleCubit>().changeLanguage(value);
      }
    });
  }
}
