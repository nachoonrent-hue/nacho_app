import 'package:flutter/material.dart';
import '../../models/booking_model.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';

class DisputeSupportScreen extends StatefulWidget {
  final BookingModel booking;

  const DisputeSupportScreen({super.key, required this.booking});

  @override
  State<DisputeSupportScreen> createState() => _DisputeSupportScreenState();
}

class _DisputeSupportScreenState extends State<DisputeSupportScreen> {
  String _selectedReason = 'Dancer did not show up';
  final _detailsController = TextEditingController(
    text: 'Dancer did not arrive at venue on scheduled time.',
  );

  final List<String> _disputeReasons = [
    'Dancer did not show up',
    'Event schedule changed / cancelled',
    'Performance duration was shorter than agreed',
    'Organizer denied attendance at venue',
    'Payment refund request',
    'Other issue',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dispute & Support Resolution')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.errorRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.report_problem_outlined,
                    color: AppColors.errorRed,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Nachoonrent Protection System will hold funds while our support team investigates both sides.',
                      style: TextStyle(
                        color: AppColors.errorRed,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Reason for Dispute / Cancellation',
              style: AppTypography.h2,
            ),
            const SizedBox(height: 12),
            ..._disputeReasons.map((reason) {
              final isSelected = _selectedReason == reason;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryPlum
                        : AppColors.borderLight,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  child: ListTile(
                    onTap: () {
                      setState(() => _selectedReason = reason);
                    },
                    leading: Icon(
                      isSelected
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_off_rounded,
                      color: isSelected
                          ? AppColors.primaryPlum
                          : AppColors.secondaryText,
                    ),
                    title: Text(reason, style: const TextStyle(fontSize: 14)),
                  ),
                ),
              );
            }),

            const SizedBox(height: 16),
            TextField(
              controller: _detailsController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Provide details / evidence description',
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitDispute,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.errorRed,
                ),
                child: const Text('SUBMIT DISPUTE TICKET'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitDispute() {
    context.appState.updateBookingStatus(
      widget.booking.id,
      BookingStatus.disputed,
      reason: '$_selectedReason: ${_detailsController.text}',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Dispute ticket raised. Support team is reviewing evidence.',
        ),
        backgroundColor: AppColors.warning,
      ),
    );

    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
