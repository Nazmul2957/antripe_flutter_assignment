import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';

class SplashController extends GetxController {
  // Add any state variables if needed
  /// Call this to navigate to the next screen
  void goToNextScreen() {
    // You can add logic here: login check, onboarding check, etc.
    Get.offNamed(Routes.HOME);
  }
}