import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class DancerFilterBottomSheet extends StatefulWidget {
  const DancerFilterBottomSheet({super.key});

  @override
  State<DancerFilterBottomSheet> createState() => _DancerFilterBottomSheetState();
}

class _DancerFilterBottomSheetState extends State<DancerFilterBottomSheet> {
  RangeValues _priceRange = const RangeValues(10000, 75000);
  double _minRating = 4.0;
  bool _onlyAvailable = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 24,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Filter Dancers', style: AppTypography.h2),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Price Range (per event in ₹)', style: TextStyle(fontWeight: FontWeight.bold)),
          RangeSlider(
            values: _priceRange,
            min: 5000,
            max: 100000,
            divisions: 19,
            activeColor: AppColors.primaryPlum,
            labels: RangeLabels(
              '₹${_priceRange.start.toInt()}',
              '₹${_priceRange.end.toInt()}',
            ),
            onChanged: (values) {
              setState(() {
                _priceRange = values;
              });
            },
          ),
          const SizedBox(height: 16),
          const Text('Minimum Rating', style: TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            value: _minRating,
            min: 3.0,
            max: 5.0,
            divisions: 4,
            activeColor: AppColors.saffron,
            label: '$_minRating Stars',
            onChanged: (val) {
              setState(() {
                _minRating = val;
              });
            },
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            title: const Text('Only Show Available Dancers'),
            value: _onlyAvailable,
            activeTrackColor: AppColors.primaryPlum,
            onChanged: (val) {
              setState(() {
                _onlyAvailable = val;
              });
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }
}
