import 'package:flutter/material.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/wedding_card.dart';
import 'event_details_screen.dart';

class WeddingTypeScreen extends StatelessWidget {
  final String weddingTypeName;

  const WeddingTypeScreen({super.key, required this.weddingTypeName});

  @override
  Widget build(BuildContext context) {
    final appState = context.appState;
    final categoryEvents = appState.weddingEvents
        .where(
          (e) => e.weddingType.toLowerCase().contains(
            weddingTypeName.toLowerCase().split(' ')[0],
          ),
        )
        .toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.primaryPlum,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                weddingTypeName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1519741497674-611481863552?w=800&auto=format&fit=crop&q=80',
                    fit: BoxFit.cover,
                  ),
                  Container(color: Colors.black.withValues(alpha: 0.5)),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cultural Heritage & Celebrations',
                    style: AppTypography.h2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$weddingTypeName celebrations are renowned worldwide for rich music, grand Baraat entries, traditional dances like Bhangra and Giddha, and festive family hospitality.',
                    style: AppTypography.bodySecondary,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upcoming $weddingTypeName Events',
                        style: AppTypography.h2,
                      ),
                      Text(
                        '${categoryEvents.length} Active',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.saffron,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (categoryEvents.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: Text(
                          'No upcoming events listed yet for this category.',
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categoryEvents.length,
                      itemBuilder: (context, index) {
                        final event = categoryEvents[index];
                        return WeddingCard(
                          event: event,
                          isSaved: appState.isEventSaved(event.id),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    EventDetailsScreen(event: event),
                              ),
                            );
                          },
                          onSaveTap: () {
                            appState.toggleSaveEvent(event.id);
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
