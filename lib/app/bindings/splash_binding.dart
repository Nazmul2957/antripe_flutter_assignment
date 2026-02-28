
import 'package:antripe_flutter_assignment/presentation/screens/home/controller/home_controller.dart';
import 'package:get/get.dart';
import '../../core/network/api_client.dart';
import '../../presentation/screens/home/datasource/contact_ds.dart';
import '../../presentation/screens/home/repository/contact_repo.dart';
import '../../presentation/screens/splash/controller/splash_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Splash controller
    Get.lazyPut(() => SplashController());

    // API client
    Get.lazyPut(() => ApiClient('https://api.antripe.com'));

    // Contacts: DataSource → Repository → Controller
    Get.lazyPut(() => ContactRemoteDataSource(Get.find()));
    Get.lazyPut(() => ContactRepository(Get.find()));
    Get.lazyPut(() => ContactController(Get.find()));
  }
}