class Service {
  final int id;
  final String serviceName;
  final String serviceDescription;
  final servicePrice;
  final String serviceImage;
  final String createdBy;
  final String createdAt;
  final String modifiedBy;
  final String modifiedAt;
  final bool isActive;

  Service({
    required this.id,
    required this.serviceName,
    required this.serviceDescription,
    required this.servicePrice,
    required this.serviceImage,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.modifiedAt,
    required this.isActive,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      serviceName: json['service_name'],
      serviceDescription: json['service_description'],
      servicePrice: json['service_price'],
      serviceImage: json['imageURL'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      modifiedBy: json['modified_by'] ?? "",
      modifiedAt: json['modified_at'] ?? "",
      isActive: json['is_active'],
    );
  }
}
