import 'package:flutter/material.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animations.dart';
import '../../widgets/dancer_card.dart';
import '../../widgets/search_bar_widget.dart';
import 'dancer_profile_screen.dart';
import 'create_dancer_profile_flow.dart';
import 'dancer_filter_bottom_sheet.dart';

class DancersHomeScreen extends StatefulWidget {
  const DancersHomeScreen({super.key});

  @override
  State<DancersHomeScreen> createState() => _DancersHomeScreenState();
}

class _DancersHomeScreenState extends State<DancersHomeScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<String> _categories = [
    'All',
    'Bhangra',
    'Bollywood',
    'Punjabi',
    'Rajasthani',
    'Gujarati',
    'Classical',
    'Folk',
    'Dance Groups',
  ];

  @override
  Widget build(BuildContext context) {
    final appState = context.appState;
    var filteredDancers = appState.dancers;

    if (_selectedCategory != 'All') {
      filteredDancers = filteredDancers
          .where((d) => d.danceStyles.contains(_selectedCategory))
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      filteredDancers = filteredDancers.where((d) {
        return d.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            d.location.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            d.danceStyles.any(
              (s) => s.toLowerCase().contains(_searchQuery.toLowerCase()),
            );
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.location_on, color: AppColors.saffron, size: 16),
                SizedBox(width: 4),
                Text(
                  'Chandigarh, Punjab',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.keyboard_arrow_down, size: 18),
              ],
            ),
            const Text(
              'Discover Baraat & Wedding Dancers',
              style: TextStyle(fontSize: 11, color: AppColors.secondaryText),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.primaryPlum,
            ),
            onPressed: () {
              appState.setNavIndex(2); // Go to activity notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Entrance(
                index: 0,
                child: SearchBarWidget(
                  hintText: 'Search dancers, Bhangra groups, styles...',
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  onFilterTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (_) => const DancerFilterBottomSheet(),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Create My Dancer Profile Banner
              Entrance(
                index: 1,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryPlum, Color(0xFF6B206C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.saffron,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'FOR DANCERS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Are you a Dancer or Troupe?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Create your public profile & get booked by wedding organizers.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const CreateDancerProfileFlow(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.saffron,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text(
                                'Create Dancer Profile',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.stars_rounded,
                        color: AppColors.saffron,
                        size: 64,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Dance Styles Categories
              Entrance(
                index: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Dance Categories', style: AppTypography.h2),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 38,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final category = _categories[index];
                          final isSelected = category == _selectedCategory;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              label: Text(category),
                              selected: isSelected,
                              selectedColor: AppColors.primaryPlum,
                              backgroundColor: AppColors.chipBackground,
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.charcoal,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 13,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() {
                                    _selectedCategory = category;
                                  });
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Featured & Popular Dancers
              Entrance(
                index: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            'Featured Dancers',
                            style: AppTypography.h2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              color: AppColors.primaryPlum,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    if (filteredDancers.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.0),
                        child: Center(
                          child: Text(
                            'No dancers found matching filter criteria.',
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredDancers.length,
                        itemBuilder: (context, index) {
                          final dancer = filteredDancers[index];
                          return Entrance(
                            index: index,
                            offset: 10,
                            child: DancerCard(
                              dancer: dancer,
                              isSaved: appState.isDancerSaved(dancer.id),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        DancerProfileScreen(dancer: dancer),
                                  ),
                                );
                              },
                              onSaveTap: () {
                                appState.toggleSaveDancer(dancer.id);
                              },
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
