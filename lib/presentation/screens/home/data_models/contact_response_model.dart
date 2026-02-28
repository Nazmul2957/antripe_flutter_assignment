import 'category_model.dart';
import 'contact_model.dart';

class ContactResponseModel {
  final List<CategoryModel> categories;
  final List<ContactModel> contacts;

  ContactResponseModel({required this.categories, required this.contacts});

  factory ContactResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return ContactResponseModel(
      categories: (data['categories'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
      contacts: (data['contacts'] as List)
          .where((e) => e['isEmpty'] == false)
          .map((e) => ContactModel.fromJson(e))
          .toList(),
    );
  }
}