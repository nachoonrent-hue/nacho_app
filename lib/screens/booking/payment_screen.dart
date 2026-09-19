import 'package:flutter/material.dart';
import '../../models/booking_model.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';
import 'payment_confirmation_screen.dart';

class PaymentScreen extends StatefulWidget {
  final BookingModel booking;

  const PaymentScreen({super.key, required this.booking});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'UPI / GPay / PhonePe';

  @override
  Widget build(BuildContext context) {
    final subtotal = widget.booking.totalAmount;
    final serviceFee = subtotal * 0.05;
    final total = subtotal + serviceFee;

    return Scaffold(
      appBar: AppBar(title: const Text('Protected Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary Card
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
                  const Text('Booking Summary', style: AppTypography.h3),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.booking.itemImageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 50,
                            height: 50,
                            color: AppColors.chipBackground,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.booking.itemTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text('${widget.booking.date} at ${widget.booking.time}', style: AppTypography.small),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Base Amount', style: AppTypography.bodySecondary),
                      Text('₹${subtotal.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Platform Guarantee Fee (5%)', style: AppTypography.bodySecondary),
                      Text('₹${serviceFee.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Payable', style: AppTypography.h2),
                      Text('₹${total.toInt()}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.emeraldSuccess)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Protected Payment Badge
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.emeraldSuccess.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.security, color: AppColors.emeraldSuccess),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Payment Protection Active: Funds are only released to provider after successful event check-in.',
                      style: TextStyle(fontSize: 12, color: AppColors.emeraldSuccess, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text('Select Payment Option', style: AppTypography.h2),
            const SizedBox(height: 12),
            _buildRadioTile('UPI / GPay / PhonePe', Icons.qr_code_scanner_rounded),
            _buildRadioTile('Credit / Debit Card', Icons.credit_card_rounded),
            _buildRadioTile('Net Banking', Icons.account_balance_rounded),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.emeraldSuccess,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('PAY ₹${total.toInt()} NOW'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioTile(String title, IconData icon) {
    final isSelected = _selectedPaymentMethod == title;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primaryPlum : AppColors.borderLight,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          onTap: () {
            setState(() => _selectedPaymentMethod = title);
          },
          leading: Icon(icon, color: AppColors.primaryPlum, size: 22),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          trailing: Icon(
            isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
            color: isSelected ? AppColors.primaryPlum : AppColors.secondaryText,
          ),
        ),
      ),
    );
  }

  void _processPayment() {
    final appState = context.appState;
    appState.updateBookingStatus(widget.booking.id, BookingStatus.confirmed);

    final updated = appState.bookings.firstWhere((b) => b.id == widget.booking.id);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => PaymentConfirmationScreen(booking: updated),
      ),
    );
  }
}
