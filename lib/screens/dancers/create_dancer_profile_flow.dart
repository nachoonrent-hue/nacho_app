import 'package:flutter/material.dart';
import '../../models/dancer_model.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';

class CreateDancerProfileFlow extends StatefulWidget {
  const CreateDancerProfileFlow({super.key});

  @override
  State<CreateDancerProfileFlow> createState() => _CreateDancerProfileFlowState();
}

class _CreateDancerProfileFlowState extends State<CreateDancerProfileFlow> {
  int _currentStep = 0;

  final _nameController = TextEditingController(text: 'Sher-E-Punjab Bhangra Squad');
  final _locationController = TextEditingController(text: 'Amritsar & Chandigarh');
  final _aboutController = TextEditingController(text: 'High octane authentic Bhangra group specializing in Baraat processions and pre-wedding celebrations.');
  final _experienceController = TextEditingController(text: '7 Years');
  final _priceController = TextEditingController(text: '28000');
  final _performanceDetailsController = TextEditingController(text: 'Includes 8 dancers + 2 Dhol masters with authentic Punjabi dress.');
  final _instagramController = TextEditingController(text: '@bhangra_squad');
  final _youtubeController = TextEditingController(text: 'BhangraSquadOfficial');

  final List<String> _selectedStyles = ['Bhangra', 'Punjabi Folk'];
  final List<String> _availableStyles = ['Bhangra', 'Bollywood', 'Rajasthani', 'Gujarati', 'Kathak', 'Giddha', 'Folk', 'Contemporary'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Dancer Profile'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_currentStep + 1) / 5,
            backgroundColor: AppColors.borderLight,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryPlum),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: _buildStepContent(),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              if (_currentStep > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _currentStep--;
                      });
                    },
                    child: const Text('Back'),
                  ),
                ),
              if (_currentStep > 0) const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentStep < 4) {
                      setState(() {
                        _currentStep++;
                      });
                    } else {
                      _publishProfile();
                    }
                  },
                  child: Text(_currentStep == 4 ? 'Publish Profile' : 'Next Step'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 1: Basic Information', style: AppTypography.h1),
            const SizedBox(height: 8),
            const Text('Set up your stage / troupe name and location.', style: AppTypography.bodySecondary),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Dancer / Troupe Name',
                prefixIcon: Icon(Icons.person_outline, color: AppColors.primaryPlum),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Primary Location / City',
                prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.primaryPlum),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _experienceController,
              decoration: const InputDecoration(
                labelText: 'Years of Experience',
                prefixIcon: Icon(Icons.stars_outlined, color: AppColors.primaryPlum),
              ),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 2: Dance Styles', style: AppTypography.h1),
            const SizedBox(height: 8),
            const Text('Select all the dance forms you specialize in.', style: AppTypography.bodySecondary),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _availableStyles.map((style) {
                final isSelected = _selectedStyles.contains(style);
                return FilterChip(
                  label: Text(style),
                  selected: isSelected,
                  selectedColor: AppColors.primaryPlum,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColors.charcoal,
                    fontWeight: FontWeight.bold,
                  ),
                  onSelected: (val) {
                    setState(() {
                      if (val) {
                        _selectedStyles.add(style);
                      } else {
                        _selectedStyles.remove(style);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 3: Pricing & Performance', style: AppTypography.h1),
            const SizedBox(height: 8),
            const Text('Set your starting rate and performance setup details.', style: AppTypography.bodySecondary),
            const SizedBox(height: 24),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Starting Price (in INR ₹)',
                prefixIcon: Icon(Icons.currency_rupee, color: AppColors.primaryPlum),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _performanceDetailsController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Performance Package Details (Group size, duration, props)',
              ),
            ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 4: Biography & Social Media', style: AppTypography.h1),
            const SizedBox(height: 8),
            const Text('Tell organizers about your work and share social handles.', style: AppTypography.bodySecondary),
            const SizedBox(height: 24),
            TextField(
              controller: _aboutController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'About You / Your Group',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _instagramController,
              decoration: const InputDecoration(
                labelText: 'Instagram Handle',
                prefixIcon: Icon(Icons.camera_alt_outlined, color: AppColors.primaryPlum),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _youtubeController,
              decoration: const InputDecoration(
                labelText: 'YouTube Channel',
                prefixIcon: Icon(Icons.video_library_outlined, color: AppColors.primaryPlum),
              ),
            ),
          ],
        );
      case 4:
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 5: Profile Preview', style: AppTypography.h1),
            const SizedBox(height: 8),
            const Text('Review your profile before publishing to the public marketplace.', style: AppTypography.bodySecondary),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_nameController.text, style: AppTypography.h2),
                  const SizedBox(height: 4),
                  Text(_locationController.text, style: AppTypography.small),
                  const Divider(height: 20),
                  Text('Starting Price: ₹${_priceController.text}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryPlum)),
                  const SizedBox(height: 8),
                  Text(_aboutController.text, style: AppTypography.bodySecondary),
                ],
              ),
            ),
          ],
        );
    }
  }

  void _publishProfile() {
    final newDancer = DancerModel(
      id: 'dnc_${DateTime.now().millisecondsSinceEpoch}',
      userId: context.appState.currentUser.id,
      name: _nameController.text,
      avatarUrl: 'https://images.unsplash.com/photo-1545239351-ef35f43d514b?w=400&auto=format&fit=crop&q=80',
      coverVideoThumbnail: 'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=800&auto=format&fit=crop&q=80',
      videoUrls: ['https://example.com/demo.mp4'],
      photoGallery: [
        'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=800&auto=format&fit=crop&q=80',
      ],
      location: _locationController.text,
      danceStyles: _selectedStyles,
      rating: 5.0,
      reviewCount: 1,
      startingPrice: double.tryParse(_priceController.text) ?? 25000.0,
      experienceYears: _experienceController.text,
      about: _aboutController.text,
      isAvailable: true,
      instagramHandle: _instagramController.text,
      youtubeChannel: _youtubeController.text,
      completedBookings: 0,
      performanceDetails: _performanceDetailsController.text,
    );

    context.appState.saveDancerProfile(newDancer);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Congratulations! Your Dancer Profile is now Live!'),
        backgroundColor: AppColors.emeraldSuccess,
      ),
    );

    Navigator.of(context).pop();
  }
}
