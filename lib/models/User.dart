class User {
  final int id;
  final String name;
  final String username;
  final String email;

  final DateTime? emailVerifiedAt;
  final DateTime? mobileVerifiedAt;

  final String? mobile;
  final String? profileImage;
  final String? coverImage;
  final String? bio;
  final String? website;
  final String? dob;
  final String? gender;

  final bool isPrivate;
  final bool profileCompleted;

  final int profileCompletionPercentage;
  final int followersCount;
  final int followingCount;
  final int postsCount;

  final String? loginProvider;
  final String? providerId;
  final String? deviceToken;

  final DateTime? lastSeenAt;

  final String? statusMessage;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? zipCode;

  final String role;
  final bool isActive;
  final bool isVerified;

  final String? metaTitle;
  final String? metaDescription;
  final String? metaKeywords;

  final String? h1;
  final String? shortContent;
  final String? content;
  final String? faqContent;
  final String? schemaJson;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.emailVerifiedAt,
    required this.mobileVerifiedAt,
    required this.mobile,
    required this.profileImage,
    required this.coverImage,
    required this.bio,
    required this.website,
    required this.dob,
    required this.gender,
    required this.isPrivate,
    required this.profileCompleted,
    required this.profileCompletionPercentage,
    required this.followersCount,
    required this.followingCount,
    required this.postsCount,
    required this.loginProvider,
    required this.providerId,
    required this.deviceToken,
    required this.lastSeenAt,
    required this.statusMessage,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.role,
    required this.isActive,
    required this.isVerified,
    required this.metaTitle,
    required this.metaDescription,
    required this.metaKeywords,
    required this.h1,
    required this.shortContent,
    required this.content,
    required this.faqContent,
    required this.schemaJson,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String? value) {
      if (value == null) return null;
      return DateTime.tryParse(value);
    }

    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',

      emailVerifiedAt: parseDate(json['emailVerifiedAt']),
      mobileVerifiedAt: parseDate(json['mobileVerifiedAt']),
      lastSeenAt: parseDate(json['lastSeenAt']),
      createdAt: parseDate(json['createdAt']),
      updatedAt: parseDate(json['updatedAt']),

      mobile: json['mobile'],
      profileImage: json['profileImage'],
      coverImage: json['coverImage'],
      bio: json['bio'],
      website: json['website'],
      dob: json['dob'],
      gender: json['gender'],

      isPrivate: json['isPrivate'] ?? false,
      profileCompleted: json['profileCompleted'] ?? false,

      profileCompletionPercentage:
      json['profileCompletionPercentage'] ?? 0,

      followersCount: json['followersCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
      postsCount: json['postsCount'] ?? 0,

      loginProvider: json['loginProvider'],
      providerId: json['providerId'],
      deviceToken: json['deviceToken'],

      statusMessage: json['statusMessage'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      zipCode: json['zipCode'],

      role: json['role'] ?? 'USER',
      isActive: json['isActive'] ?? false,
      isVerified: json['isVerified'] ?? false,

      metaTitle: json['metaTitle'],
      metaDescription: json['metaDescription'],
      metaKeywords: json['metaKeywords'],

      h1: json['h1'],
      shortContent: json['shortContent'],
      content: json['content'],
      faqContent: json['faqContent'],
      schemaJson: json['schemaJson'],
    );
  }
}