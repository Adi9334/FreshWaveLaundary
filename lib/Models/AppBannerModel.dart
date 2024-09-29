class AppBanner {
  final int id;
  final String bannerName;
  final String bannerImage;
  final String createdBy;
  final String createdAt;
  final String modifiedBy;
  final String modifiedAt;
  final bool isActive;

  AppBanner({
    required this.id,
    required this.bannerName,
    required this.bannerImage,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.isActive,
  });

  factory AppBanner.fromJson(Map<String, dynamic> json) {
    return AppBanner(
      id: json['id'],
      bannerName: json['app_banner_name'],
      bannerImage: json['app_banner_imageURL'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      modifiedBy: json['modified_by'] ?? "",
      modifiedAt: json['modified_at'] ?? "",
      isActive: json['is_active'],
    );
  }
}
