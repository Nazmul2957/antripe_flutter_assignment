import 'package:get/get.dart';

import '../../presentation/screens/home/view/home_screen.dart';
import '../../presentation/screens/splash/view/splash_screen.dart';
import '../bindings/splash_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: AppBinding(),
    ),
    GetPage(name: Routes.HOME, page: () =>  HomeScreen()),
  ];
}
