import 'package:flutter/material.dart';
import '../../models/mirage_experience_model.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';

class CreateExperienceFlow extends StatefulWidget {
  const CreateExperienceFlow({super.key});

  @override
  State<CreateExperienceFlow> createState() => _CreateExperienceFlowState();
}

class _CreateExperienceFlowState extends State<CreateExperienceFlow> {
  final _titleController = TextEditingController(text: 'Traditional Haldi & Floral Ceremony Pass');
  final _descriptionController = TextEditingController(text: 'Be an honored guest in an authentic Haldi ceremony with live music, floral rain, and traditional turmeric ritual.');
  final _locationController = TextEditingController(text: 'Udaipur, Rajasthan');
  final _durationController = TextEditingController(text: '3 Hours');
  final _priceController = TextEditingController(text: '2999');

  String _selectedCategory = 'Haldi';

  final List<String> _categories = [
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
    return Scaffold(
      appBar: AppBar(title: const Text('Create Mirage Experience')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Host a Cultural Experience', style: AppTypography.h1),
            const SizedBox(height: 8),
            const Text('Share authentic Indian wedding traditions with guest travelers.', style: AppTypography.bodySecondary),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: const InputDecoration(labelText: 'Experience Category'),
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedCategory = val);
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Experience Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location / City'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _durationController,
                    decoration: const InputDecoration(labelText: 'Duration'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Price / Guest (₹)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Full Experience Description'),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _publish,
                child: const Text('Submit Experience for Verification'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _publish() {
    final exp = MirageExperienceModel(
      id: 'mrg_${DateTime.now().millisecondsSinceEpoch}',
      title: _titleController.text,
      category: _selectedCategory,
      description: _descriptionController.text,
      location: _locationController.text,
      duration: _durationController.text,
      hostId: context.appState.currentUser.id,
      hostName: context.appState.currentUser.name,
      hostAvatar: context.appState.currentUser.avatarUrl,
      pricePerGuest: double.tryParse(_priceController.text) ?? 2999.0,
      guestCapacity: 10,
      includes: ['Ceremony Access Pass', 'Welcome Refreshments', 'Souvenir Photos'],
      excludes: ['Transportation'],
      guestRules: ['Wear festive yellow or ethnic attire'],
      coverImageUrl: 'https://images.unsplash.com/photo-1545239351-ef35f43d514b?w=800&auto=format&fit=crop&q=80',
      galleryUrls: ['https://images.unsplash.com/photo-1545239351-ef35f43d514b?w=800&auto=format&fit=crop&q=80'],
      rating: 5.0,
      reviewCount: 1,
      availableDates: ['15 Nov 2026', '20 Dec 2026'],
      cancellationPolicy: 'Standard 48 hour policy.',
    );

    context.appState.createMirageExperience(exp);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mirage Experience Submitted Successfully!'),
        backgroundColor: AppColors.emeraldSuccess,
      ),
    );

    Navigator.pop(context);
  }
}
