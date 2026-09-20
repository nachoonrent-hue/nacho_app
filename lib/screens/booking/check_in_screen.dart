import 'package:flutter/material.dart';
import '../../models/booking_model.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';
import 'completion_review_screen.dart';
import 'dispute_support_screen.dart';

class CheckInScreen extends StatefulWidget {
  final BookingModel booking;

  const CheckInScreen({super.key, required this.booking});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  bool _isCheckedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event-Day Check-In')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                children: [
                  Text(widget.booking.itemTitle, style: AppTypography.h2),
                  const SizedBox(height: 6),
                  Text(
                    'Scheduled for ${widget.booking.date} (${widget.booking.time})',
                    style: AppTypography.bodySecondary,
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Check-In Code Token:'),
                      Text(
                        widget.booking.qrCode,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryPlum,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _isCheckedIn
                    ? AppColors.emeraldSuccess.withValues(alpha: 0.1)
                    : AppColors.warmIvory,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isCheckedIn
                      ? AppColors.emeraldSuccess
                      : AppColors.primaryPlum,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    _isCheckedIn
                        ? Icons.verified_rounded
                        : Icons.qr_code_scanner_rounded,
                    size: 64,
                    color: _isCheckedIn
                        ? AppColors.emeraldSuccess
                        : AppColors.primaryPlum,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _isCheckedIn
                        ? 'Dancer Attendance Checked-In!'
                        : 'Scan QR Code or Confirm Attendance',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _isCheckedIn
                        ? 'Event is now ongoing. Complete event once performance finishes.'
                        : 'Press the button below when the dancer/host arrives at venue.',
                    style: AppTypography.small,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const Spacer(),

            if (!_isCheckedIn)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isCheckedIn = true;
                    });
                    context.appState.updateBookingStatus(
                      widget.booking.id,
                      BookingStatus.checkedIn,
                    );
                  },
                  child: const Text('CONFIRM VENUE CHECK-IN'),
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.appState.updateBookingStatus(
                      widget.booking.id,
                      BookingStatus.completed,
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) =>
                            CompletionReviewScreen(booking: widget.booking),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.emeraldSuccess,
                  ),
                  child: const Text('MARK EVENT AS COMPLETED'),
                ),
              ),

            const SizedBox(height: 12),

            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        DisputeSupportScreen(booking: widget.booking),
                  ),
                );
              },
              child: const Text(
                'Report Issue or Dispute Booking',
                style: TextStyle(color: AppColors.errorRed),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
