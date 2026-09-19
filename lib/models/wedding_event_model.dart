class WeddingEventModel {
  final String id;
  final String title;
  final String weddingType; // Punjabi, Rajasthani, Gujarati, Marwari, etc.
  final String description;
  final String date;
  final String time;
  final String location;
  final String organizerId;
  final String organizerName;
  final String organizerAvatar;
  final int expectedCrowd;
  final String dancerRequirements;
  final int dancersNeeded;
  final String preferredDanceStyle;
  final double budget; // INR
  final String coverImageUrl;
  final List<String> photos;
  final String status; // 'published', 'draft', 'completed', 'cancelled'
  final String performanceDuration;
  final String cancellationRules;

  WeddingEventModel({
    required this.id,
    required this.title,
    required this.weddingType,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.organizerId,
    required this.organizerName,
    required this.organizerAvatar,
    required this.expectedCrowd,
    required this.dancerRequirements,
    required this.dancersNeeded,
    required this.preferredDanceStyle,
    required this.budget,
    required this.coverImageUrl,
    required this.photos,
    this.status = 'published',
    required this.performanceDuration,
    required this.cancellationRules,
  });

  WeddingEventModel copyWith({
    String? title,
    String? weddingType,
    String? description,
    String? date,
    String? time,
    String? location,
    int? expectedCrowd,
    String? dancerRequirements,
    int? dancersNeeded,
    String? preferredDanceStyle,
    double? budget,
    String? coverImageUrl,
    List<String>? photos,
    String? status,
    String? performanceDuration,
    String? cancellationRules,
  }) {
    return WeddingEventModel(
      id: id,
      title: title ?? this.title,
      weddingType: weddingType ?? this.weddingType,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      organizerId: organizerId,
      organizerName: organizerName,
      organizerAvatar: organizerAvatar,
      expectedCrowd: expectedCrowd ?? this.expectedCrowd,
      dancerRequirements: dancerRequirements ?? this.dancerRequirements,
      dancersNeeded: dancersNeeded ?? this.dancersNeeded,
      preferredDanceStyle: preferredDanceStyle ?? this.preferredDanceStyle,
      budget: budget ?? this.budget,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      photos: photos ?? this.photos,
      status: status ?? this.status,
      performanceDuration: performanceDuration ?? this.performanceDuration,
      cancellationRules: cancellationRules ?? this.cancellationRules,
    );
  }
}
