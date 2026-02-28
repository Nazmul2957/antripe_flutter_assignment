

import '../../../../core/network/api_client.dart';
import '../data_models/contact_response_model.dart';

class ContactRemoteDataSource {
  final ApiClient apiClient;
  ContactRemoteDataSource(this.apiClient);

  Future<ContactResponseModel> fetchContacts() async {
    final json = await apiClient.get('/v1/contact/api.json');
    return ContactResponseModel.fromJson(json);
  }
}