import '../domain/contact.dart';

class ContactModel extends Contact {
  ContactModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.categoryId,
    required super.avatarUrl,
    required super.subtitle,
    required super.status,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      categoryId: json['categoryId'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      subtitle: json['subtitle'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
