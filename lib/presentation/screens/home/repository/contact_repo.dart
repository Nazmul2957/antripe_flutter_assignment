import '../data_models/category_model.dart';
import '../data_models/contact_model.dart';
import '../datasource/contact_ds.dart';

class ContactRepository {
  final ContactRemoteDataSource remote;

  ContactRepository(this.remote);

  Future<List<ContactModel>> getContacts() async {
    final result = await remote.fetchContacts();
    return result.contacts;
  }

  Future<List<CategoryModel>> getCategories() async {
    final result = await remote.fetchContacts();
    return result.categories;
  }
}
