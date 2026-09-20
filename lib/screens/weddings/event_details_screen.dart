import 'package:flutter/material.dart';
import '../../models/wedding_event_model.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/status_badge.dart';
import 'organizer_profile_screen.dart';

class EventDetailsScreen extends StatelessWidget {
  final WeddingEventModel event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final appState = context.appState;
    final isSaved = appState.isEventSaved(event.id);

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
                    tag: 'event-cover-${event.id}',
                    child: Image.network(
                      event.coverImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.chipBackground,
                        child: const Icon(
                          Icons.celebration,
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
                          Colors.black.withValues(alpha: 0.4),
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            event.weddingType,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          event.title,
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
                onPressed: () {
                  appState.toggleSaveEvent(event.id);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatusBadge(status: event.status),
                      Text(
                        'Budget: ₹${event.budget.toInt()}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.emeraldSuccess,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Key Event Details Grid
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Column(
                      children: [
                        _DetailRow(
                          icon: Icons.calendar_today_rounded,
                          label: 'Date & Time',
                          value: '${event.date} at ${event.time}',
                        ),
                        const Divider(height: 20),
                        _DetailRow(
                          icon: Icons.location_on_outlined,
                          label: 'Venue Location',
                          value: event.location,
                        ),
                        const Divider(height: 20),
                        _DetailRow(
                          icon: Icons.groups_rounded,
                          label: 'Expected Crowd',
                          value: '${event.expectedCrowd} Guests',
                        ),
                        const Divider(height: 20),
                        _DetailRow(
                          icon: Icons.timer_outlined,
                          label: 'Performance Duration',
                          value: event.performanceDuration,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Organizer Profile Card Shortcut
                  const Text('Event Organizer', style: AppTypography.h2),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () {
                      final organizer = appState.organizers.firstWhere(
                        (o) => o.id == event.organizerId,
                        orElse: () => appState.organizers.first,
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              OrganizerProfileScreen(organizer: organizer),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.chipBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(
                              event.organizerAvatar,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.organizerName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const Text(
                                  'Verified Wedding Organizer',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: AppColors.primaryPlum,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Dancer Requirements Section
                  const Text('Dancer Requirements', style: AppTypography.h2),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.warmIvory,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.primaryPlum.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.music_note_rounded,
                              color: AppColors.primaryPlum,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${event.dancersNeeded} ${event.preferredDanceStyle} Dancers Required',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.primaryPlum,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          event.dancerRequirements,
                          style: AppTypography.body,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // About Event
                  const Text('About the Event', style: AppTypography.h2),
                  const SizedBox(height: 8),
                  Text(event.description, style: AppTypography.bodySecondary),

                  const SizedBox(height: 24),

                  // Cancellation Policy
                  const Text(
                    'Cancellation & Refund Policy',
                    style: AppTypography.h2,
                  ),
                  const SizedBox(height: 8),
                  Text(event.cancellationRules, style: AppTypography.small),

                  const SizedBox(height: 32),

                  // CTA Button for Dancers or Organizers
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Booking participation request sent for "${event.title}"!',
                            ),
                            backgroundColor: AppColors.emeraldSuccess,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('SUBMIT DANCER PROPOSAL / BOOKING'),
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
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryPlum, size: 20),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTypography.small),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
