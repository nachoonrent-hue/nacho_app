import 'package:flutter/material.dart';
import '../models/organizer_model.dart';
import '../theme/app_theme.dart';
import 'animations.dart';
import 'verification_badge.dart';

class OrganizerCard extends StatelessWidget {
  final OrganizerModel organizer;
  final VoidCallback onTap;

  const OrganizerCard({
    super.key,
    required this.organizer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPlum.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(organizer.avatarUrl),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      organizer.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (organizer.isVerified) ...[
                    const SizedBox(width: 4),
                    const VerificationBadge(size: 14),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                organizer.location,
                style: AppTypography.small,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '${organizer.totalEventsOrganized}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const Text(
                        'Events',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20, width: 1, color: AppColors.borderLight),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: AppColors.saffron,
                            size: 12,
                          ),
                          Text(
                            '${organizer.rating}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        'Rating',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
