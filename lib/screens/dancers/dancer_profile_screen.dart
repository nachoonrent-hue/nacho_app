import 'package:flutter/material.dart';
import '../../models/dancer_model.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animations.dart';
import '../../widgets/verification_badge.dart';
import '../booking/booking_request_screen.dart';

class DancerProfileScreen extends StatelessWidget {
  final DancerModel dancer;

  const DancerProfileScreen({super.key, required this.dancer});

  @override
  Widget build(BuildContext context) {
    final appState = context.appState;
    final isSaved = appState.isDancerSaved(dancer.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero Media Header
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.primaryPlum,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'dancer-cover-${dancer.id}',
                    child: Image.network(
                      dancer.coverVideoThumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.chipBackground,
                        child: const Icon(
                          Icons.movie_rounded,
                          size: 64,
                          color: AppColors.primaryPlum,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.8),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundImage: NetworkImage(dancer.avatarUrl),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      dancer.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  if (dancer.isVerified) ...[
                                    const SizedBox(width: 6),
                                    const VerificationBadge(),
                                  ],
                                ],
                              ),
                              Text(
                                dancer.location,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isSaved
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: isSaved ? AppColors.saffron : Colors.white,
                ),
                onPressed: () {
                  appState.toggleSaveDancer(dancer.id);
                },
              ),
              IconButton(
                icon: const Icon(Icons.share_rounded, color: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile link copied to clipboard!'),
                    ),
                  );
                },
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overview Stats Bar
                  Entrance(
                    index: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryPlum.withValues(
                              alpha: 0.05,
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatItem(
                            label: 'Rating',
                            value: '${dancer.rating} ★',
                            subtitle: '${dancer.reviewCount} reviews',
                          ),
                          _divider(),
                          _StatItem(
                            label: 'Experience',
                            value: dancer.experienceYears,
                            subtitle: 'Professional',
                          ),
                          _divider(),
                          _StatItem(
                            label: 'Completed',
                            value: '',
                            subtitle: 'Bookings',
                            count: dancer.completedBookings.toDouble(),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Performance Video Showcase Section
                  const Entrance(
                    index: 1,
                    child: Text('Performance Videos', style: AppTypography.h2),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dancer.photoGallery.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 160,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(dancer.photoGallery[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Dance Styles Tags
                  const Entrance(
                    index: 2,
                    child: Text('Specialized Styles', style: AppTypography.h2),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: dancer.danceStyles.map((style) {
                      return Chip(
                        label: Text(style),
                        backgroundColor: AppColors.chipBackground,
                        labelStyle: const TextStyle(
                          color: AppColors.primaryPlum,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // About Section
                  const Entrance(
                    index: 3,
                    child: Text('About Dancer', style: AppTypography.h2),
                  ),
                  const SizedBox(height: 8),
                  Text(dancer.about, style: AppTypography.body),

                  const SizedBox(height: 24),

                  // Performance & Setup Info
                  const Entrance(
                    index: 4,
                    child: Text('Performance Details', style: AppTypography.h2),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dancer.performanceDetails,
                    style: AppTypography.bodySecondary,
                  ),

                  const SizedBox(height: 24),

                  // Social Media Connections
                  const Entrance(
                    index: 5,
                    child: Text(
                      'Social Media & Portfolio',
                      style: AppTypography.h2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _SocialButton(
                        icon: Icons.camera_alt_outlined,
                        label: dancer.instagramHandle.isNotEmpty
                            ? dancer.instagramHandle
                            : '@dancer',
                        color: Colors.purple,
                      ),
                      const SizedBox(width: 12),
                      _SocialButton(
                        icon: Icons.video_library_outlined,
                        label: dancer.youtubeChannel.isNotEmpty
                            ? dancer.youtubeChannel
                            : 'YouTube Channel',
                        color: Colors.red,
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Price & Booking Bar
                  Entrance(
                    index: 6,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.warmIvory,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Starting Price',
                                style: AppTypography.small,
                              ),
                              Text(
                                '₹${dancer.startingPrice.toInt()}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryPlum,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      BookingRequestScreen(dancer: dancer),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryPlum,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 16,
                              ),
                            ),
                            child: const Text('BOOK DANCER'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      Container(height: 30, width: 1, color: AppColors.borderLight);
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;
  final double? count;

  const _StatItem({
    required this.label,
    required this.value,
    required this.subtitle,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (count == null)
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryPlum,
            ),
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedStat(
                value: count!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryPlum,
                ),
              ),
              if (value.isNotEmpty)
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryPlum,
                  ),
                ),
            ],
          ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 11, color: AppColors.secondaryText),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
