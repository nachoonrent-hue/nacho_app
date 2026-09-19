class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String location;
  final String avatarUrl;
  final String bio;
  final bool isVerified;
  final bool hasDancerProfile;
  final String? dancerProfileId;
  final bool hasOrganizerProfile;
  final String? organizerProfileId;
  final List<String> savedDancerIds;
  final List<String> savedEventIds;
  final List<String> savedExperienceIds;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.avatarUrl,
    required this.bio,
    this.isVerified = false,
    this.hasDancerProfile = false,
    this.dancerProfileId,
    this.hasOrganizerProfile = false,
    this.organizerProfileId,
    this.savedDancerIds = const [],
    this.savedEventIds = const [],
    this.savedExperienceIds = const [],
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? location,
    String? avatarUrl,
    String? bio,
    bool? isVerified,
    bool? hasDancerProfile,
    String? dancerProfileId,
    bool? hasOrganizerProfile,
    String? organizerProfileId,
    List<String>? savedDancerIds,
    List<String>? savedEventIds,
    List<String>? savedExperienceIds,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      isVerified: isVerified ?? this.isVerified,
      hasDancerProfile: hasDancerProfile ?? this.hasDancerProfile,
      dancerProfileId: dancerProfileId ?? this.dancerProfileId,
      hasOrganizerProfile: hasOrganizerProfile ?? this.hasOrganizerProfile,
      organizerProfileId: organizerProfileId ?? this.organizerProfileId,
      savedDancerIds: savedDancerIds ?? this.savedDancerIds,
      savedEventIds: savedEventIds ?? this.savedEventIds,
      savedExperienceIds: savedExperienceIds ?? this.savedExperienceIds,
    );
  }
}
