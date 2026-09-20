import 'package:flutter/material.dart';
import '../../models/mirage_experience_model.dart';
import '../../models/booking_model.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';
import '../booking/payment_screen.dart';

class ExperienceDetailsScreen extends StatelessWidget {
  final MirageExperienceModel experience;

  const ExperienceDetailsScreen({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    final appState = context.appState;
    final isSaved = appState.isExperienceSaved(experience.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: AppColors.primaryPlum,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'mirage-cover-${experience.id}',
                    child: Image.network(
                      experience.coverImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.3),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.saffron,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            experience.category,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          experience.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
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
                onPressed: () => appState.toggleSaveExperience(experience.id),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overview Metadata Card
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
                        _MetaItem(
                          icon: Icons.timer_outlined,
                          title: 'Duration',
                          subtitle: experience.duration,
                        ),
                        _divider(),
                        _MetaItem(
                          icon: Icons.star_rounded,
                          title: 'Rating',
                          subtitle:
                              '${experience.rating} (${experience.reviewCount})',
                        ),
                        _divider(),
                        _MetaItem(
                          icon: Icons.location_on_outlined,
                          title: 'Location',
                          subtitle: experience.location,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Host Information
                  const Text('About the Host', style: AppTypography.h2),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(experience.hostAvatar),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            experience.hostName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Text(
                            'Verified Cultural Host',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Description
                  const Text("What You'll Experience", style: AppTypography.h2),
                  const SizedBox(height: 8),
                  Text(experience.description, style: AppTypography.body),

                  const SizedBox(height: 24),

                  // What's Included
                  const Text("What's Included", style: AppTypography.h2),
                  const SizedBox(height: 10),
                  ...experience.includes.map(
                    (inc) => Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.emeraldSuccess,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              inc,
                              style: AppTypography.bodySecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Available Dates Selection
                  const Text('Available Dates', style: AppTypography.h2),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: experience.availableDates.map((d) {
                      return Chip(
                        label: Text(d),
                        backgroundColor: AppColors.chipBackground,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryPlum,
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 32),

                  // Bottom Action Bar
                  Container(
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
                              'Price per Guest',
                              style: AppTypography.small,
                            ),
                            Text(
                              '₹${experience.pricePerGuest.toInt()}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryPlum,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Create Mirage Booking & Navigate to Payment Simulation
                            final newBooking = BookingModel(
                              id: 'bk_${DateTime.now().millisecondsSinceEpoch}',
                              type: BookingType.mirage,
                              itemId: experience.id,
                              itemTitle: experience.title,
                              itemImageUrl: experience.coverImageUrl,
                              customerId: appState.currentUser.id,
                              customerName: appState.currentUser.name,
                              providerId: experience.hostId,
                              providerName: experience.hostName,
                              date: experience.availableDates.first,
                              time: '05:00 PM',
                              totalAmount: experience.pricePerGuest,
                              status: BookingStatus.paymentPending,
                              qrCode:
                                  'NCH-MRG-${DateTime.now().millisecondsSinceEpoch}',
                              createdAt: '2026-09-19',
                            );

                            appState.createBooking(newBooking);

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    PaymentScreen(booking: newBooking),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.saffron,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                          ),
                          child: const Text('BOOK EXPERIENCE'),
                        ),
                      ],
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

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _MetaItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryPlum, size: 20),
        const SizedBox(height: 4),
        Text(title, style: AppTypography.small),
        Text(
          subtitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ],
    );
  }
}
