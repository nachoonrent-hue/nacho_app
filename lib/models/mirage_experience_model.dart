class MirageExperienceModel {
  final String id;
  final String title;
  final String category; // Baraat, Sangeet, Mehndi, Haldi, Traditional Food, Traditional Dress, Cultural Ceremony
  final String description;
  final String location;
  final String duration;
  final String hostId;
  final String hostName;
  final String hostAvatar;
  final double pricePerGuest; // INR
  final int guestCapacity;
  final List<String> includes;
  final List<String> excludes;
  final List<String> guestRules;
  final String coverImageUrl;
  final List<String> galleryUrls;
  final double rating;
  final int reviewCount;
  final List<String> availableDates;
  final String cancellationPolicy;

  MirageExperienceModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.location,
    required this.duration,
    required this.hostId,
    required this.hostName,
    required this.hostAvatar,
    required this.pricePerGuest,
    required this.guestCapacity,
    required this.includes,
    required this.excludes,
    required this.guestRules,
    required this.coverImageUrl,
    required this.galleryUrls,
    required this.rating,
    required this.reviewCount,
    required this.availableDates,
    required this.cancellationPolicy,
  });
}
