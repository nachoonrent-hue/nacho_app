import 'package:flutter/material.dart';
import '../services/app_state_provider.dart';
import '../widgets/custom_bottom_nav.dart';
import 'dancers/dancers_home_screen.dart';
import 'weddings/weddings_home_screen.dart';
import 'activity/activity_dashboard_screen.dart';
import 'me/user_profile_screen.dart';

class MainNavigationShell extends StatelessWidget {
  const MainNavigationShell({super.key});

  static final List<Widget> _screens = [
    const DancersHomeScreen(),
    const WeddingsHomeScreen(),
    const ActivityDashboardScreen(),
    const UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = context.appState;
    final currentIndex = appState.currentNavIndex;

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: _screens),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          appState.setNavIndex(index);
        },
      ),
    );
  }
}
