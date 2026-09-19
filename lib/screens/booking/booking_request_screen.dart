import 'package:flutter/material.dart';
import '../../models/dancer_model.dart';
import '../../models/booking_model.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';
import 'payment_screen.dart';

class BookingRequestScreen extends StatefulWidget {
  final DancerModel dancer;

  const BookingRequestScreen({super.key, required this.dancer});

  @override
  State<BookingRequestScreen> createState() => _BookingRequestScreenState();
}

class _BookingRequestScreenState extends State<BookingRequestScreen> {
  final _dateController = TextEditingController(text: '28 Oct 2026');
  final _timeController = TextEditingController(text: '06:30 PM');
  final _notesController = TextEditingController(text: 'Baraat procession performance with live Dhol drums.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Booking Request')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dancer Brief Card
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.dancer.avatarUrl),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.dancer.name, style: AppTypography.h3),
                      Text('Starting from ₹${widget.dancer.startingPrice.toInt()}', style: const TextStyle(color: AppColors.primaryPlum, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 32),

            const Text('Event Booking Details', style: AppTypography.h2),
            const SizedBox(height: 16),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Event Date',
                prefixIcon: Icon(Icons.calendar_today_rounded, color: AppColors.primaryPlum),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: 'Performance Start Time',
                prefixIcon: Icon(Icons.access_time_rounded, color: AppColors.primaryPlum),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Special Requests / Event Instructions',
              ),
            ),

            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.chipBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.shield_outlined, color: AppColors.primaryPlum),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Nachoonrent Protected Payment Guarantee ensures funds are securely held until event completion.',
                      style: TextStyle(fontSize: 12, color: AppColors.primaryPlum),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitRequest,
                child: const Text('SUBMIT BOOKING REQUEST'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitRequest() {
    final appState = context.appState;
    final booking = BookingModel(
      id: 'bk_${DateTime.now().millisecondsSinceEpoch}',
      type: BookingType.dancer,
      itemId: widget.dancer.id,
      itemTitle: widget.dancer.name,
      itemImageUrl: widget.dancer.coverVideoThumbnail,
      customerId: appState.currentUser.id,
      customerName: appState.currentUser.name,
      providerId: widget.dancer.userId,
      providerName: widget.dancer.name,
      date: _dateController.text,
      time: _timeController.text,
      totalAmount: widget.dancer.startingPrice,
      status: BookingStatus.accepted, // Instantly accepted in demo flow to trigger payment
      qrCode: 'NCH-DNC-${DateTime.now().millisecondsSinceEpoch}',
      specialNotes: _notesController.text,
      createdAt: '2026-09-19',
    );

    appState.createBooking(booking);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => PaymentScreen(booking: booking),
      ),
    );
  }
}
