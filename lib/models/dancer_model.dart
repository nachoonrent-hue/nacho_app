class DancerModel {
  final String id;
  final String userId;
  final String name;
  final String avatarUrl;
  final String coverVideoThumbnail;
  final List<String> videoUrls;
  final List<String> photoGallery;
  final bool isVerified;
  final String location;
  final List<String> danceStyles; // e.g. Bollywood, Bhangra, Kathak, Garba
  final double rating;
  final int reviewCount;
  final double startingPrice; // per performance / hour in INR
  final String experienceYears;
  final String about;
  final bool isAvailable;
  final String instagramHandle;
  final String youtubeChannel;
  final int completedBookings;
  final String performanceDetails;

  DancerModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.avatarUrl,
    required this.coverVideoThumbnail,
    required this.videoUrls,
    required this.photoGallery,
    this.isVerified = true,
    required this.location,
    required this.danceStyles,
    required this.rating,
    required this.reviewCount,
    required this.startingPrice,
    required this.experienceYears,
    required this.about,
    this.isAvailable = true,
    this.instagramHandle = '',
    this.youtubeChannel = '',
    required this.completedBookings,
    required this.performanceDetails,
  });

  DancerModel copyWith({
    String? name,
    String? avatarUrl,
    String? coverVideoThumbnail,
    List<String>? videoUrls,
    List<String>? photoGallery,
    bool? isVerified,
    String? location,
    List<String>? danceStyles,
    double? rating,
    int? reviewCount,
    double? startingPrice,
    String? experienceYears,
    String? about,
    bool? isAvailable,
    String? instagramHandle,
    String? youtubeChannel,
    int? completedBookings,
    String? performanceDetails,
  }) {
    return DancerModel(
      id: id,
      userId: userId,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      coverVideoThumbnail: coverVideoThumbnail ?? this.coverVideoThumbnail,
      videoUrls: videoUrls ?? this.videoUrls,
      photoGallery: photoGallery ?? this.photoGallery,
      isVerified: isVerified ?? this.isVerified,
      location: location ?? this.location,
      danceStyles: danceStyles ?? this.danceStyles,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      startingPrice: startingPrice ?? this.startingPrice,
      experienceYears: experienceYears ?? this.experienceYears,
      about: about ?? this.about,
      isAvailable: isAvailable ?? this.isAvailable,
      instagramHandle: instagramHandle ?? this.instagramHandle,
      youtubeChannel: youtubeChannel ?? this.youtubeChannel,
      completedBookings: completedBookings ?? this.completedBookings,
      performanceDetails: performanceDetails ?? this.performanceDetails,
    );
  }
}
