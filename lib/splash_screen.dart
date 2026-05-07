import 'package:fit_flow/core/constants/strings.dart';
import 'package:fit_flow/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      // if (mounted) {
      //   final onBoardingRepo = getIt<OnBoardingRepository>();
      //   final hasCompleted = await onBoardingRepo.hasCompletedOnboarding();
      //   if (hasCompleted) {
      //     Navigator.pushReplacementNamed(context, mainLayoutScreen);
      //   } else {
      //     Navigator.pushReplacementNamed(context, onBoardingScreen);
      //   }
      // }
      Navigator.pushReplacementNamed(context, onBoardingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 200.h,
          width: 200.w,
          key: const Key('logoPng'),
        ),
      ),
    );
  }
}
