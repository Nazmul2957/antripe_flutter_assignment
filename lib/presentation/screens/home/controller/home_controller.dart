import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data_models/category_model.dart';
import '../data_models/contact_model.dart';
import '../repository/contact_repo.dart';

class ContactController extends GetxController {
  final ContactRepository repository;

  ContactController(this.repository);

  RxList<ContactModel> contacts = <ContactModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;
  RxString selectedCategory = 'all'.obs;
  RxString searchQuery = ''.obs;

  // reactive filtered contacts
  RxList<ContactModel> filteredContacts = <ContactModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Fetch  data
    fetchContacts();

    //searchQuery, selectedCategory, or contacts change
    everAll([
      contacts,
      searchQuery,
      selectedCategory,
    ], (_) => _filterContacts());
  }

  Future<void> fetchContacts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final contactList = await repository.getContacts();
      final categoryList = await repository.getCategories();
      contacts.assignAll(contactList);
      categories.assignAll(categoryList);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// TEMPORARY: force empty list to preview card design
  // void _filterContacts() {
  //   filteredContacts.value = [];
  // }

  void _filterContacts() {
    final query = searchQuery.value.toLowerCase();
    final numericQuery = searchQuery.value.replaceAll(
      RegExp(r'\D'),
      '',
    ); // digits only

    filteredContacts.value = contacts.where((c) {
      // Category match
      final matchesCategory =
          selectedCategory.value == 'all' ||
          c.categoryId == selectedCategory.value;

      // Name match
      final matchesName = c.name.toLowerCase().contains(query);

      // Phone match (partial digits match)
      final phoneDigits = c.phone.replaceAll(RegExp(r'\D'), '');
      final matchesPhone = numericQuery.isEmpty
          ? false
          : phoneDigits.contains(numericQuery);

      return matchesCategory && (matchesName || matchesPhone);
    }).toList();
  }
}
