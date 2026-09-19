class OrganizerModel {
  final String id;
  final String userId;
  final String name;
  final String avatarUrl;
  final bool isVerified;
  final String location;
  final String about;
  final double rating;
  final int reviewCount;
  final int totalEventsOrganized;
  final int activeEventsCount;
  final List<String> pastEventPhotos;

  OrganizerModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.avatarUrl,
    this.isVerified = true,
    required this.location,
    required this.about,
    required this.rating,
    required this.reviewCount,
    required this.totalEventsOrganized,
    required this.activeEventsCount,
    required this.pastEventPhotos,
  });
}
