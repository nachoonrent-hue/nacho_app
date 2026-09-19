import 'package:flutter/material.dart';
import 'services/app_state.dart';
import 'services/app_state_provider.dart';
import 'theme/app_theme.dart';
import 'screens/onboarding/splash_screen.dart';

void main() {
  runApp(const NachoApp());
}

class NachoApp extends StatefulWidget {
  const NachoApp({super.key});

  @override
  State<NachoApp> createState() => _NachoAppState();
}

class _NachoAppState extends State<NachoApp> {
  late final AppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = AppState();
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      appState: _appState,
      child: MaterialApp(
        title: 'Nachoonrent',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
