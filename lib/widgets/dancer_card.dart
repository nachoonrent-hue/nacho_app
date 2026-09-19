import 'package:flutter/material.dart';
import '../models/dancer_model.dart';
import '../theme/app_theme.dart';
import 'verification_badge.dart';
import 'video_player_modal.dart';

class DancerCard extends StatelessWidget {
  final DancerModel dancer;
  final bool isSaved;
  final VoidCallback onTap;
  final VoidCallback onSaveTap;

  const DancerCard({
    super.key,
    required this.dancer,
    required this.isSaved,
    required this.onTap,
    required this.onSaveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover Image & Video indicator
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      dancer.coverVideoThumbnail,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 180,
                        color: AppColors.chipBackground,
                        child: const Icon(Icons.movie_rounded, color: AppColors.primaryPlum, size: 48),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withValues(alpha: 0.9),
                      child: IconButton(
                        icon: Icon(
                          isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                          color: isSaved ? AppColors.saffron : AppColors.charcoal,
                        ),
                        onPressed: onSaveTap,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => VideoPlayerModal(dancer: dancer),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.saffron, width: 1),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.play_circle_fill, color: AppColors.saffron, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'Watch Performance',
                              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(dancer.avatarUrl),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      dancer.name,
                                      style: AppTypography.h3,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (dancer.isVerified) ...[
                                    const SizedBox(width: 6),
                                    const VerificationBadge(),
                                  ],
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined, size: 14, color: AppColors.secondaryText),
                                  const SizedBox(width: 2),
                                  Text(dancer.location, style: AppTypography.small),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: dancer.danceStyles.map((style) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.chipBackground,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            style,
                            style: const TextStyle(fontSize: 12, color: AppColors.primaryPlum, fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                    ),

                    const Divider(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: AppColors.saffron, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              '${dancer.rating}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${dancer.reviewCount})',
                              style: AppTypography.small,
                            ),
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'From ',
                                style: TextStyle(color: AppColors.secondaryText, fontSize: 12),
                              ),
                              TextSpan(
                                text: '₹${dancer.startingPrice.toInt()}',
                                style: const TextStyle(
                                  color: AppColors.primaryPlum,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
