import 'package:flutter/material.dart';
import '../../models/booking_model.dart';
import '../../models/review_model.dart';
import '../../services/app_state_provider.dart';
import '../../theme/app_theme.dart';

class CompletionReviewScreen extends StatefulWidget {
  final BookingModel booking;

  const CompletionReviewScreen({super.key, required this.booking});

  @override
  State<CompletionReviewScreen> createState() => _CompletionReviewScreenState();
}

class _CompletionReviewScreenState extends State<CompletionReviewScreen> {
  double _rating = 5.0;
  final _commentController = TextEditingController(text: 'Phenomenal performance! Arrived on time and amazed all wedding guests with high-energy Bhangra routines!');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leave Verified Review')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.stars_rounded, size: 64, color: AppColors.saffron),
            const SizedBox(height: 16),
            const Text('Event Completed!', style: AppTypography.h1),
            const SizedBox(height: 8),
            Text(
              'How was your experience with ${widget.booking.itemTitle}?',
              style: AppTypography.bodySecondary,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Rating Star Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starValue = index + 1;
                return IconButton(
                  iconSize: 36,
                  icon: Icon(
                    starValue <= _rating ? Icons.star_rounded : Icons.star_border_rounded,
                    color: AppColors.saffron,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = starValue.toDouble();
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Write your verified review...',
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitReview,
                child: const Text('SUBMIT REVIEW & RELEASE PAYOUT'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitReview() {
    final appState = context.appState;
    final review = ReviewModel(
      id: 'rev_${DateTime.now().millisecondsSinceEpoch}',
      bookingId: widget.booking.id,
      targetId: widget.booking.itemId,
      authorName: appState.currentUser.name,
      authorAvatar: appState.currentUser.avatarUrl,
      rating: _rating,
      comment: _commentController.text,
      date: '19 Sep 2026',
      isVerifiedBooking: true,
    );

    appState.addReview(review);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thank you! Review submitted and payout eligible.'),
        backgroundColor: AppColors.emeraldSuccess,
      ),
    );

    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
