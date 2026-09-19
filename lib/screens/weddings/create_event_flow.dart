import 'package:flutter/material.dart';
import '../../models/wedding_event_model.dart';
import '../../models/mirage_experience_model.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';

class CreateEventFlow extends StatefulWidget {
  final int initialTab;
  const CreateEventFlow({super.key, this.initialTab = 0});

  @override
  State<CreateEventFlow> createState() => _CreateEventFlowState();
}

class _CreateEventFlowState extends State<CreateEventFlow> {
  late int _creationType; // 0: Wedding Event (Hire Dancers), 1: Mirage Experience (Invite Guests)
  int _currentStep = 0;

  // Event Form Controllers
  final _titleController = TextEditingController(text: 'Royal Destination Sangeet Night');
  final _descriptionController = TextEditingController(text: 'Seeking high-energy dancers to perform at our destination Sangeet function.');
  final _locationController = TextEditingController(text: 'JW Marriott Resort, Jaipur');
  final _dateController = TextEditingController(text: '12 Dec, 2026');
  final _timeController = TextEditingController(text: '07:00 PM');
  final _crowdController = TextEditingController(text: '450');
  final _dancersNeededController = TextEditingController(text: '6');
  final _dancerReqsController = TextEditingController(text: 'Looking for 6 Ghoomar and Bollywood fusion dancers for 2 hour performance set.');
  final _budgetController = TextEditingController(text: '35000');

  // Mirage Form Controllers
  final _mirageTitleController = TextEditingController(text: 'Dance in a Live Punjabi Wedding Baraat');
  final _mirageCategoryController = TextEditingController(text: 'Baraat');
  final _miragePriceController = TextEditingController(text: '4999');
  final _mirageDurationController = TextEditingController(text: '4 Hours');
  final _mirageIncludesController = TextEditingController(text: 'VIP Baraat Access Pass, Traditional Turban, 5-course Wedding Feast');

  String _selectedWeddingType = 'Punjabi Wedding';
  String _selectedStyle = 'Bhangra';

  final List<String> _weddingTypes = [
    'Punjabi Wedding',
    'Rajasthani Wedding',
    'Gujarati Wedding',
    'Marwari Wedding',
    'Bengali Wedding',
    'South Indian Wedding',
    'North Indian Wedding',
    'Other'
  ];

  final List<String> _danceStyles = [
    'Bhangra',
    'Bollywood',
    'Rajasthani',
    'Gujarati',
    'Kathak',
    'Giddha',
    'Folk'
  ];

  @override
  void initState() {
    super.initState();
    _creationType = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_creationType == 0 ? 'Create Wedding Event' : 'Host Mirage Experience'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_currentStep + 1) / 4,
            backgroundColor: AppColors.borderLight,
            valueColor: AlwaysStoppedAnimation<Color>(
              _creationType == 0 ? AppColors.primaryPlum : AppColors.saffron,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP DUAL TOGGLE TYPE SELECTOR
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.chipBackground,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _creationType = 0;
                          _currentStep = 0;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _creationType == 0 ? AppColors.primaryPlum : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Hire Dancers for Event',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _creationType == 0 ? Colors.white : AppColors.charcoal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _creationType = 1;
                          _currentStep = 0;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _creationType == 1 ? AppColors.saffron : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Host Mirage Cultural Pass',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _creationType == 1 ? Colors.white : AppColors.charcoal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _creationType == 0 ? _buildEventStepContent() : _buildMirageStepContent(),
          ],
        ),
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
                    if (_currentStep < 3) {
                      setState(() {
                        _currentStep++;
                      });
                    } else {
                      if (_creationType == 0) {
                        _publishEvent();
                      } else {
                        _publishMirage();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _creationType == 0 ? AppColors.primaryPlum : AppColors.saffron,
                  ),
                  child: Text(_currentStep == 3 ? 'Publish Listing' : 'Next Step'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventStepContent() {
    switch (_currentStep) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 1: Event & Tradition Details', style: AppTypography.h1),
            const SizedBox(height: 8),
            const Text('Select wedding tradition type and event name.', style: AppTypography.bodySecondary),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              initialValue: _selectedWeddingType,
              decoration: const InputDecoration(labelText: 'Wedding Type / Tradition'),
              items: _weddingTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedWeddingType = val);
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Event Name / Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'About the Event'),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 2: Date & Venue', style: AppTypography.h1),
            const SizedBox(height: 8),
            const Text('When and where is the event taking place?', style: AppTypography.bodySecondary),
            const SizedBox(height: 24),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Venue Location & City'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dateController,
                    decoration: const InputDecoration(labelText: 'Event Date'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _timeController,
                    decoration: const InputDecoration(labelText: 'Event Time'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _crowdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Expected Guest Crowd Count'),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 3: Dancer Requirements', style: AppTypography.h1),
            const SizedBox(height: 8),
            const Text('Specify how many dancers you need and budget.', style: AppTypography.bodySecondary),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              initialValue: _selectedStyle,
              decoration: const InputDecoration(labelText: 'Preferred Dance Style'),
              items: _danceStyles.map((style) {
                return DropdownMenuItem(value: style, child: Text(style));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedStyle = val);
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dancersNeededController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Number of Dancers Needed'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _budgetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Budget (in INR ₹)'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dancerReqsController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Detailed Requirements / Proposal Notes'),
            ),
          ],
        );
      case 3:
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 4: Review & Publish Event', style: AppTypography.h1),
            const SizedBox(height: 8),
            const Text('Verify event listing information before going live.', style: AppTypography.bodySecondary),
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
                  Text(_titleController.text, style: AppTypography.h2),
                  const SizedBox(height: 4),
                  Text('$_selectedWeddingType • ${_dateController.text}', style: AppTypography.small),
                  const Divider(height: 20),
                  Text('Budget: ₹${_budgetController.text}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.emeraldSuccess)),
                  const SizedBox(height: 8),
                  Text('${_dancersNeededController.text} Dancers Needed ($_selectedStyle)', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryPlum)),
                ],
              ),
            ),
          ],
        );
    }
  }

  Widget _buildMirageStepContent() {
    switch (_currentStep) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 1: Experience & Category', style: AppTypography.h1),
            const SizedBox(height: 8),
            const Text('Title your cultural experience pass.', style: AppTypography.bodySecondary),
            const SizedBox(height: 24),
            TextField(
              controller: _mirageTitleController,
              decoration: const InputDecoration(labelText: 'Experience Title (e.g. Dance in a Live Baraat)'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Venue Location & City'),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 2: Guest Inclusions', style: AppTypography.h1),
            const SizedBox(height: 8),
            const Text('What will travelers experience during the event?', style: AppTypography.bodySecondary),
            const SizedBox(height: 24),
            TextField(
              controller: _mirageIncludesController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: "What's Included (VIP access, attire, food)"),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 3: Pricing & Duration', style: AppTypography.h1),
            const SizedBox(height: 8),
            const Text('Set ticket price per guest and duration.', style: AppTypography.bodySecondary),
            const SizedBox(height: 24),
            TextField(
              controller: _miragePriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price per Guest (INR ₹)'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _mirageDurationController,
              decoration: const InputDecoration(labelText: 'Experience Duration (e.g. 4 Hours)'),
            ),
          ],
        );
      case 3:
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Step 4: Review Mirage Pass', style: AppTypography.h1),
            const SizedBox(height: 8),
            const Text('Review before publishing to Mirage Marketplace.', style: AppTypography.bodySecondary),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.saffron),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_mirageTitleController.text, style: AppTypography.h2),
                  const SizedBox(height: 4),
                  Text('${_locationController.text} • ${_mirageDurationController.text}', style: AppTypography.small),
                  const Divider(height: 20),
                  Text('Price per Guest: ₹${_miragePriceController.text}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.saffron)),
                ],
              ),
            ),
          ],
        );
    }
  }

  void _publishEvent() {
    final newEvent = WeddingEventModel(
      id: 'evt_${DateTime.now().millisecondsSinceEpoch}',
      title: _titleController.text,
      weddingType: _selectedWeddingType,
      description: _descriptionController.text,
      date: _dateController.text,
      time: _timeController.text,
      location: _locationController.text,
      organizerId: context.appState.currentUser.id,
      organizerName: context.appState.currentUser.name,
      organizerAvatar: context.appState.currentUser.avatarUrl,
      expectedCrowd: int.tryParse(_crowdController.text) ?? 300,
      dancerRequirements: _dancerReqsController.text,
      dancersNeeded: int.tryParse(_dancersNeededController.text) ?? 5,
      preferredDanceStyle: _selectedStyle,
      budget: double.tryParse(_budgetController.text) ?? 30000.0,
      coverImageUrl: 'https://images.unsplash.com/photo-1519741497674-611481863552?w=800&auto=format&fit=crop&q=80',
      photos: [
        'https://images.unsplash.com/photo-1519741497674-611481863552?w=800&auto=format&fit=crop&q=80',
      ],
      status: 'published',
      performanceDuration: '2 Hours',
      cancellationRules: 'Standard cancellation terms.',
    );

    context.appState.createWeddingEvent(newEvent);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Wedding Event Published Successfully!'),
        backgroundColor: AppColors.emeraldSuccess,
      ),
    );

    Navigator.of(context).pop();
  }

  void _publishMirage() {
    final exp = MirageExperienceModel(
      id: 'mrg_${DateTime.now().millisecondsSinceEpoch}',
      title: _mirageTitleController.text,
      category: _mirageCategoryController.text,
      description: _mirageIncludesController.text,
      location: _locationController.text,
      duration: _mirageDurationController.text,
      hostId: context.appState.currentUser.id,
      hostName: context.appState.currentUser.name,
      hostAvatar: context.appState.currentUser.avatarUrl,
      pricePerGuest: double.tryParse(_miragePriceController.text) ?? 4999.0,
      guestCapacity: 10,
      includes: _mirageIncludesController.text.split(','),
      excludes: ['Transportation'],
      guestRules: ['Wear festive Indian ethnic attire'],
      coverImageUrl: 'https://images.unsplash.com/photo-1545239351-ef35f43d514b?w=800&auto=format&fit=crop&q=80',
      galleryUrls: ['https://images.unsplash.com/photo-1545239351-ef35f43d514b?w=800&auto=format&fit=crop&q=80'],
      rating: 5.0,
      reviewCount: 1,
      availableDates: ['28 Oct 2026', '15 Nov 2026'],
      cancellationPolicy: 'Standard policy.',
    );

    context.appState.createMirageExperience(exp);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mirage Cultural Experience Published Live!'),
        backgroundColor: AppColors.saffron,
      ),
    );

    Navigator.of(context).pop();
  }
}
