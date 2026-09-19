import 'package:flutter/material.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/mirage_card.dart';
import 'experience_details_screen.dart';
import 'create_experience_flow.dart';

class MirageHomeScreen extends StatefulWidget {
  const MirageHomeScreen({super.key});

  @override
  State<MirageHomeScreen> createState() => _MirageHomeScreenState();
}

class _MirageHomeScreenState extends State<MirageHomeScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Baraat',
    'Sangeet',
    'Mehndi',
    'Haldi',
    'Traditional Food',
    'Traditional Dress',
    'Cultural Ceremony',
  ];

  @override
  Widget build(BuildContext context) {
    final appState = context.appState;
    var experiences = appState.mirageExperiences;

    if (_selectedCategory != 'All') {
      experiences = experiences.where((e) => e.category == _selectedCategory).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('MIRAGE', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2.0, color: AppColors.primaryPlum)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: AppColors.saffron, size: 28),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CreateExperienceFlow()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Immersive Header Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryPlum, Color(0xFF2A082D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.saffron,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('CULTURAL MARKETPLACE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Experience India Beyond the Tourist Trail',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Discover and book authentic Indian wedding ceremonies, Baraat processions & cultural guest passes.',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Experience Categories Horizontal Chips
            const Text('Explore Categories', style: AppTypography.h2),
            const SizedBox(height: 12),
            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = cat == _selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      selectedColor: AppColors.saffron,
                      backgroundColor: AppColors.chipBackground,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.charcoal,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 12,
                      ),
                      onSelected: (val) {
                        if (val) setState(() => _selectedCategory = cat);
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Experiences Listing Grid / List
            const Text('Featured Cultural Experiences', style: AppTypography.h2),
            const SizedBox(height: 12),

            if (experiences.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(child: Text('No experiences found under this category.')),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: experiences.length,
                itemBuilder: (context, index) {
                  final exp = experiences[index];
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: MirageCard(
                      experience: exp,
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
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
