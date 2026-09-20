import 'package:flutter/material.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animations.dart';
import '../../widgets/verification_badge.dart';
import '../dancers/create_dancer_profile_flow.dart';
import '../dancers/dancer_profile_screen.dart';
import '../weddings/create_event_flow.dart';
import '../mirage/mirage_home_screen.dart';
import 'saved_items_screen.dart';
import 'settings_screen.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.appState;
    final user = appState.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Me & Account', style: AppTypography.h1),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.primaryPlum,
            ),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Header Profile Card
            Entrance(
              index: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryPlum.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundImage: NetworkImage(user.avatarUrl),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(user.name, style: AppTypography.h2),
                              if (user.isVerified) ...[
                                const SizedBox(width: 6),
                                const VerificationBadge(),
                              ],
                            ],
                          ),
                          Text(user.phone, style: AppTypography.small),
                          Text(user.location, style: AppTypography.small),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Unified Account Banner (Section 2 of README)
            Entrance(
              index: 1,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.saffron.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.saffron.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.workspace_premium_rounded,
                      color: AppColors.saffron,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Unified Account Active: You can freely act as a Dancer, Organizer, and Cultural Host from a single account.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.charcoal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text('Activity Shortcuts', style: AppTypography.h2),
            const SizedBox(height: 12),

            Entrance(
              index: 2,
              child: _Tile(
                icon: Icons.groups_rounded,
                title: user.hasDancerProfile
                    ? 'My Public Dancer Profile'
                    : 'Create Dancer Profile',
                subtitle: user.hasDancerProfile
                    ? 'View & edit dancer profile details'
                    : 'Publish your dancer identity',
                onTap: () {
                  if (user.hasDancerProfile && appState.dancers.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            DancerProfileScreen(dancer: appState.dancers.first),
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const CreateDancerProfileFlow(),
                      ),
                    );
                  }
                },
              ),
            ),

            Entrance(
              index: 3,
              child: _Tile(
                icon: Icons.celebration_rounded,
                title: 'Create Wedding Event',
                subtitle: 'Post new event & dancer requirements',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CreateEventFlow()),
                  );
                },
              ),
            ),

            Entrance(
              index: 4,
              child: _Tile(
                icon: Icons.explore_outlined,
                title: 'Mirage Cultural Experiences',
                subtitle: 'Explore or host cultural guest packages',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const MirageHomeScreen()),
                  );
                },
              ),
            ),

            Entrance(
              index: 5,
              child: _Tile(
                icon: Icons.bookmark_rounded,
                title: 'Saved Items & Bookmarks',
                subtitle:
                    '${user.savedDancerIds.length + user.savedEventIds.length + user.savedExperienceIds.length} Saved items',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SavedItemsScreen()),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
            const Entrance(
              index: 6,
              child: Text('Account & Settings', style: AppTypography.h2),
            ),
            const SizedBox(height: 12),

            Entrance(
              index: 7,
              child: _Tile(
                icon: Icons.notifications_none_rounded,
                title: 'Notifications & Alerts',
                subtitle: 'Manage activity push notifications',
                onTap: () => appState.setNavIndex(2),
              ),
            ),

            Entrance(
              index: 8,
              child: _Tile(
                icon: Icons.help_outline_rounded,
                title: 'Help & Customer Support',
                subtitle: '24/7 dispute & inquiry assistance',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Support Desk: support@nachoonrent.com'),
                    ),
                  );
                },
              ),
            ),

            Entrance(
              index: 9,
              child: _Tile(
                icon: Icons.logout_rounded,
                title: 'Log Out',
                subtitle: 'Sign out of your session',
                color: AppColors.errorRed,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logged out successfully.')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? color;

  const _Tile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          onTap: onTap,
          leading: Icon(icon, color: color ?? AppColors.primaryPlum),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: color,
            ),
          ),
          subtitle: Text(subtitle, style: AppTypography.small),
          trailing: const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.secondaryText,
          ),
        ),
      ),
    );
  }
}
