import 'package:fit_flow/core/constants/strings.dart';
import 'package:fit_flow/features/on_boarding/ui/screens/on_boarding_screen.dart';
import 'package:fit_flow/features/home/presentation/screens/home_screen.dart';
import 'package:fit_flow/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (c) => SplashScreen());
      case onBoardingScreen:
        return MaterialPageRoute(builder: (c) => OnBoardingScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (c) => HomeScreen());
    }
    return null;
  }
}
