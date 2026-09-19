import 'package:flutter/material.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/search_bar_widget.dart';
import '../../widgets/wedding_card.dart';
import '../../widgets/organizer_card.dart';
import '../../widgets/mirage_card.dart';
import 'wedding_type_screen.dart';
import 'event_details_screen.dart';
import 'create_event_flow.dart';
import 'organizer_profile_screen.dart';
import '../mirage/mirage_home_screen.dart';
import '../mirage/experience_details_screen.dart';
import '../mirage/create_experience_flow.dart';

class WeddingsHomeScreen extends StatefulWidget {
  const WeddingsHomeScreen({super.key});

  @override
  State<WeddingsHomeScreen> createState() => _WeddingsHomeScreenState();
}

class _WeddingsHomeScreenState extends State<WeddingsHomeScreen> {
  int _selectedTab = 0; // 0: Wedding Events (Dancer Hire), 1: Mirage Experiences (Cultural Pass)
  String _searchQuery = '';

  final List<Map<String, String>> _weddingTypes = [
    {
      'title': 'Punjabi Wedding',
      'image': 'https://images.unsplash.com/photo-1519741497674-611481863552?w=600&auto=format&fit=crop&q=80',
    },
    {
      'title': 'Rajasthani Wedding',
      'image': 'https://images.unsplash.com/photo-1583939003579-730e3918a45a?w=600&auto=format&fit=crop&q=80',
    },
    {
      'title': 'Gujarati Wedding',
      'image': 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=600&auto=format&fit=crop&q=80',
    },
    {
      'title': 'Marwari Wedding',
      'image': 'https://images.unsplash.com/photo-1465495976277-4387d4b0b4c6?w=600&auto=format&fit=crop&q=80',
    },
    {
      'title': 'Bengali Wedding',
      'image': 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=600&auto=format&fit=crop&q=80',
    },
    {
      'title': 'South Indian Wedding',
      'image': 'https://images.unsplash.com/photo-1609357605129-26f69add5d6e?w=600&auto=format&fit=crop&q=80',
    },
    {
      'title': 'North Indian Wedding',
      'image': 'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?w=600&auto=format&fit=crop&q=80',
    },
    {
      'title': 'Other Indian Wedding',
      'image': 'https://images.unsplash.com/photo-1545239351-ef35f43d514b?w=600&auto=format&fit=crop&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final appState = context.appState;
    var events = appState.weddingEvents;
    var experiences = appState.mirageExperiences;

    if (_searchQuery.isNotEmpty) {
      events = events.where((e) {
        return e.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            e.weddingType.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            e.location.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();

      experiences = experiences.where((ex) {
        return ex.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            ex.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            ex.location.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weddings & Culture', style: AppTypography.h1),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: AppColors.primaryPlum, size: 28),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CreateEventFlow(initialTab: _selectedTab),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            SearchBarWidget(
              hintText: _selectedTab == 0
                  ? 'Search wedding events & dancer requirements...'
                  : 'Search Mirage experiences, Baraat passes & traditions...',
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
            ),

            const SizedBox(height: 16),

            // DUAL TOP SEGMENTED TAB SELECTOR (Wedding Events vs Mirage Experiences)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.chipBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedTab == 0 ? AppColors.primaryPlum : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.groups_rounded,
                              size: 18,
                              color: _selectedTab == 0 ? Colors.white : AppColors.charcoal,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Wedding Events',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: _selectedTab == 0 ? Colors.white : AppColors.charcoal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedTab == 1 ? AppColors.saffron : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.explore_outlined,
                              size: 18,
                              color: _selectedTab == 1 ? Colors.white : AppColors.charcoal,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Mirage Passes',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: _selectedTab == 1 ? Colors.white : AppColors.charcoal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // TAB 0: WEDDING EVENTS FOR DANCER BOOKING
            if (_selectedTab == 0) ...[
              // Create Event Hero Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6B206C), AppColors.primaryPlum],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Organizing a Wedding Event?',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Post event details & receive proposals from top dancers.',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const CreateEventFlow(initialTab: 0)),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.saffron,
                            ),
                            child: const Text('CREATE WEDDING EVENT'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.celebration, color: AppColors.saffronAccent, size: 56),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Wedding Types Category Cards
              const Text('Wedding Traditions & Types', style: AppTypography.h2),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _weddingTypes.length,
                  itemBuilder: (context, index) {
                    final type = _weddingTypes[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WeddingTypeScreen(weddingTypeName: type['title']!),
                          ),
                        );
                      },
                      child: Container(
                        width: 140,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          image: DecorationImage(
                            image: NetworkImage(type['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black.withValues(alpha: 0.85)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            type['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),

              // Upcoming Events Feed Header (Fixed 41px right overflow with Expanded)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Upcoming Events (Dancer Needed)',
                      style: AppTypography.h2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See All', style: TextStyle(color: AppColors.primaryPlum, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (events.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: Text('No events found.')),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return WeddingCard(
                      event: event,
                      isSaved: appState.isEventSaved(event.id),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => EventDetailsScreen(event: event),
                          ),
                        );
                      },
                      onSaveTap: () {
                        appState.toggleSaveEvent(event.id);
                      },
                    );
                  },
                ),

              const SizedBox(height: 24),

              // Featured Organizers Carousel (Fixed 14px bottom overflow by increasing container height to 195)
              const Text('Featured Organizers', style: AppTypography.h2),
              const SizedBox(height: 12),
              SizedBox(
                height: 195,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: appState.organizers.length,
                  itemBuilder: (context, index) {
                    final organizer = appState.organizers[index];
                    return OrganizerCard(
                      organizer: organizer,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => OrganizerProfileScreen(organizer: organizer),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ]
            // TAB 1: MIRAGE EXPERIENCES FOR CULTURAL PASSES
            else ...[
              // Host Experience Hero Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.saffron, Color(0xFFC87916)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Host a Cultural Experience',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Share authentic wedding traditions (Baraat, Sangeet, Haldi) with guest travelers.',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const CreateExperienceFlow()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryPlum,
                            ),
                            child: const Text('HOST EXPERIENTIAL PASS'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.explore_outlined, color: Colors.white, size: 56),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Mirage Header (Fixed 87px right overflow with Expanded)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Discover Cultural Passes',
                      style: AppTypography.h2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const MirageHomeScreen()),
                      );
                    },
                    child: const Text('Marketplace →', style: TextStyle(color: AppColors.saffron, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (experiences.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: Text('No cultural passes available.')),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: experiences.length,
                  itemBuilder: (context, index) {
                    final exp = experiences[index];
                    return MirageCard(
                      experience: exp,
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 16),
                      isSaved: appState.isExperienceSaved(exp.id),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ExperienceDetailsScreen(experience: exp),
                          ),
                        );
                      },
                      onSaveTap: () {
                        appState.toggleSaveExperience(exp.id);
                      },
                    );
                  },
                ),
            ],

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
