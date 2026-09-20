import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animations.dart';
import '../main_navigation_shell.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Center(
                child: Entrance(
                  index: 0,
                  offset: 8,
                  child: Pulse(
                    minScale: 0.98,
                    maxScale: 1.03,
                    duration: const Duration(milliseconds: 2600),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.primaryPlum.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.groups_rounded,
                        size: 80,
                        color: AppColors.primaryPlum,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Entrance(
                index: 1,
                child: Text(
                  'The Heart of Indian Wedding Celebrations',
                  style: AppTypography.display,
                ),
              ),
              const SizedBox(height: 12),
              const Entrance(
                index: 2,
                child: Text(
                  'Discover professional dancers, manage grand wedding events, or step inside authentic cultural experiences with Mirage.',
                  style: AppTypography.bodySecondary,
                ),
              ),
              const Spacer(),
              Entrance(
                index: 3,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Get Started'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Entrance(
                index: 4,
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigate directly to main app shell as guest
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => const MainNavigationShell(),
                        ),
                        (route) => false,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Explore App as Guest'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
