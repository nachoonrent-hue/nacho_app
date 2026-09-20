import 'package:flutter/material.dart';
import '../../models/booking_model.dart';
import '../../theme/app_theme.dart';
import 'check_in_screen.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final BookingModel booking;

  const PaymentConfirmationScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColors.emeraldSuccess,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 64,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              const Text('Booking Confirmed!', style: AppTypography.h1),
              const SizedBox(height: 8),
              Text(
                'Your payment for ${booking.itemTitle} was successful.',
                style: AppTypography.bodySecondary,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Event Pass / QR Token Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryPlum.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'EVENT ENTRY / CHECK-IN PASS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // QR Code Box Placeholder / Simulation
                    Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                        color: AppColors.warmIvory,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primaryPlum,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.qr_code_2_rounded,
                            size: 100,
                            color: AppColors.primaryPlum,
                          ),
                          Text(
                            booking.qrCode,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Show this QR code upon arrival at the venue for instant check-in confirmation.',
                      style: AppTypography.small,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CheckInScreen(booking: booking),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPlum,
                  ),
                  child: const Text('SIMULATE EVENT DAY CHECK-IN'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text('Back to Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
