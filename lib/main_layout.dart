import 'package:fit_flow/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'package:fit_flow/generated/l10n.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  List<Widget> _buildScreens(BuildContext context) {
    return [
      const HomeScreen(),
      Scaffold(body: Center(child: Text(S.of(context).navLearn))),
      Scaffold(body: Center(child: Text(S.of(context).navProfile))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _buildScreens(context)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.shifting,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: S.of(context).navHome),
          BottomNavigationBarItem(icon: const Icon(Icons.menu_book), label: S.of(context).navLearn),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: S.of(context).navProfile,
          ),
        ],
      ),
    );
  }
}
