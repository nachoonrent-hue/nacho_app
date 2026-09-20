import 'package:flutter/material.dart';
import '../models/mirage_experience_model.dart';
import '../theme/app_theme.dart';
import 'animations.dart';

/// Shared hero tag linking the card cover to the experience detail header.
String mirageExperienceCoverTag(String experienceId) =>
    'mirage-cover-$experienceId';

class MirageCard extends StatelessWidget {
  final MirageExperienceModel experience;
  final bool isSaved;
  final VoidCallback onTap;
  final VoidCallback onSaveTap;
  final double? width;
  final EdgeInsetsGeometry? margin;

  const MirageCard({
    super.key,
    required this.experience,
    required this.isSaved,
    required this.onTap,
    required this.onSaveTap,
    this.width = 260,
    this.margin = const EdgeInsets.only(right: 16),
  });

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      child: Container(
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPlum.withValues(alpha: 0.08),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: mirageExperienceCoverTag(experience.id),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.network(
                          experience.coverImageUrl,
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                height: 140,
                                color: AppColors.chipBackground,
                                child: const Icon(
                                  Icons.explore,
                                  color: AppColors.primaryPlum,
                                  size: 48,
                                ),
                              ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.saffron,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          experience.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white.withValues(alpha: 0.9),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 16,
                          icon: Icon(
                            isSaved
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            color: isSaved
                                ? AppColors.saffron
                                : AppColors.charcoal,
                          ),
                          onPressed: onSaveTap,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        experience.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 12,
                            color: AppColors.secondaryText,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              experience.location,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.secondaryText,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.timer_outlined,
                            size: 12,
                            color: AppColors.secondaryText,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            experience.duration,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: AppColors.saffron,
                                size: 14,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '${experience.rating}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '₹${experience.pricePerGuest.toInt()}',
                                  style: const TextStyle(
                                    color: AppColors.primaryPlum,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' / guest',
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 10,
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
      ),
    );
  }
}
