import 'package:flutter/material.dart';
import '../../models/organizer_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/verification_badge.dart';

class OrganizerProfileScreen extends StatelessWidget {
  final OrganizerModel organizer;

  const OrganizerProfileScreen({super.key, required this.organizer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Organizer Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(organizer.avatarUrl),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(organizer.name, style: AppTypography.h1),
                      if (organizer.isVerified) ...[
                        const SizedBox(width: 8),
                        const VerificationBadge(size: 20),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppColors.secondaryText,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        organizer.location,
                        style: AppTypography.bodySecondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Performance Metrics
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '${organizer.totalEventsOrganized}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryPlum,
                        ),
                      ),
                      const Text(
                        'Events Managed',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 30, width: 1, color: AppColors.borderLight),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: AppColors.saffron,
                            size: 18,
                          ),
                          Text(
                            '${organizer.rating}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryPlum,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '(${organizer.reviewCount} Reviews)',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text('About the Organizer', style: AppTypography.h2),
            const SizedBox(height: 8),
            Text(organizer.about, style: AppTypography.body),

            const SizedBox(height: 24),
            const Text('Past Event Gallery', style: AppTypography.h2),
            const SizedBox(height: 12),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: organizer.pastEventPhotos.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      image: DecorationImage(
                        image: NetworkImage(organizer.pastEventPhotos[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
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
