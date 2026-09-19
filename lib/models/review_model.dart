class ReviewModel {
  final String id;
  final String bookingId;
  final String targetId; // dancerId or experienceId or organizerId
  final String authorName;
  final String authorAvatar;
  final double rating;
  final String comment;
  final String date;
  final bool isVerifiedBooking;

  ReviewModel({
    required this.id,
    required this.bookingId,
    required this.targetId,
    required this.authorName,
    required this.authorAvatar,
    required this.rating,
    required this.comment,
    required this.date,
    this.isVerifiedBooking = true,
  });
}
