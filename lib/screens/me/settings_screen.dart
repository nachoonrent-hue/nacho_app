import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('General Settings', style: AppTypography.h3),
          const SizedBox(height: 12),
          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Booking requests & event reminders'),
            value: true,
            activeTrackColor: AppColors.primaryPlum,
            onChanged: (val) {},
          ),
          SwitchListTile(
            title: const Text('Location Services'),
            subtitle: const Text('Auto-detect nearby dancers & events'),
            value: true,
            activeTrackColor: AppColors.primaryPlum,
            onChanged: (val) {},
          ),
          const Divider(height: 32),
          const Text('Legal & About', style: AppTypography.h3),
          const SizedBox(height: 12),
          const ListTile(
            title: Text('Terms of Service'),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
          const ListTile(
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
          const ListTile(
            title: Text('App Version'),
            trailing: Text('1.0.0 (Phase 1)', style: TextStyle(color: AppColors.secondaryText)),
          ),
        ],
      ),
    );
  }
}
