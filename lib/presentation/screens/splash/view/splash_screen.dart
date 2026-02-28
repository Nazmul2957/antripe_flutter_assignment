//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/splash_controller.dart';
// import '../../../core/constants/app_colors.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _shapeController;
//   late AnimationController _bottomController;
//
//   late Animation<double> shapeFade;
//   late Animation<Offset> topRightSlide;
//   late Animation<Offset> bottomLeftSlide;
//
//   late Animation<double> logoScale;
//   late Animation<double> logoMoveUp;
//
//   late Animation<Offset> bottomSlide;
//   late Animation<double> bottomFade;
//
//   final SplashController controller = Get.put(SplashController());
//
//   @override
//   void initState() {
//     super.initState();
//
//     _shapeController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//
//     // Shapes animation
//     shapeFade = Tween(begin: 1.0, end: 0.0).animate(
//       CurvedAnimation(parent: _shapeController, curve: Curves.easeInOut),
//     );
//
//     topRightSlide =
//         Tween<Offset>(begin: Offset.zero, end: const Offset(0.3, -0.3)).animate(
//           CurvedAnimation(parent: _shapeController, curve: Curves.easeInOut),
//         );
//
//     bottomLeftSlide =
//         Tween<Offset>(begin: Offset.zero, end: const Offset(-0.3, 0.3)).animate(
//           CurvedAnimation(parent: _shapeController, curve: Curves.easeInOut),
//         );
//
//     // Logo scale & move up during shape animation
//     logoScale = Tween<double>(begin: 1.0, end: 0.9).animate(
//       CurvedAnimation(parent: _shapeController, curve: Curves.easeInOut),
//     );
//
//     logoMoveUp = Tween<double>(
//       begin: 0,
//       end: -50,
//     ).animate(CurvedAnimation(parent: _shapeController, curve: Curves.easeOut));
//
//     _shapeController.forward();
//
//     // Bottom sheet animation
//     _bottomController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//
//     bottomSlide = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
//         .animate(
//           CurvedAnimation(parent: _bottomController, curve: Curves.easeOut),
//         );
//
//     bottomFade = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(parent: _bottomController, curve: Curves.easeIn));
//
//     // Open bottom sheet after shapes finish
//     _shapeController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _bottomController.forward();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _shapeController.dispose();
//     _bottomController.dispose();
//     super.dispose();
//   }
//
//   // Responsive sizing helpers
//   double rsHeight(double val) => val * MediaQuery.of(context).size.height / 812;
//
//   double rsWidth(double val) => val * MediaQuery.of(context).size.width / 375;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: Stack(
//         children: [
//           // Shapes + Logo
//           AnimatedBuilder(
//             animation: _shapeController,
//             builder: (context, _) {
//               return Stack(
//                 children: [
//                   // Top-right shape
//                   FadeTransition(
//                     opacity: shapeFade,
//                     child: SlideTransition(
//                       position: topRightSlide,
//                       child: Align(
//                         alignment: Alignment.topRight,
//                         child: Container(
//                           height: rsHeight(140),
//                           width: rsWidth(140),
//                           decoration: BoxDecoration(
//                             color: AppColors.green,
//                             borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(100),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // Bottom-left shape
//                   FadeTransition(
//                     opacity: shapeFade,
//                     child: SlideTransition(
//                       position: bottomLeftSlide,
//                       child: Align(
//                         alignment: Alignment.bottomLeft,
//                         child: Container(
//                           height: rsHeight(220),
//                           width: rsWidth(220),
//                           decoration: BoxDecoration(
//                             color: AppColors.green,
//                             borderRadius: const BorderRadius.only(
//                               topRight: Radius.circular(200),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // Logo
//                   Center(
//                     child: AnimatedBuilder(
//                       animation: _shapeController,
//                       builder: (context, child) {
//                         return Transform.translate(
//                           offset: Offset(0, logoMoveUp.value),
//                           child: ScaleTransition(
//                             scale: logoScale,
//                             child: child,
//                           ),
//                         );
//                       },
//                       child: Image.asset(
//                         "assets/logo.png",
//                         width: rsWidth(100),
//                         height: rsHeight(100),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//
//           // Bottom sheet
//           AnimatedBuilder(
//             animation: _bottomController,
//             builder: (context, _) {
//               return FractionalTranslation(
//                 translation: bottomSlide.value,
//                 child: Opacity(
//                   opacity: bottomFade.value,
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.symmetric(
//                         vertical: rsHeight(24),
//                         horizontal: rsWidth(24),
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: const BorderRadius.vertical(
//                           top: Radius.circular(20),
//                         ),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 10,
//                             offset: Offset(0, -3),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             "welcome".tr,
//                             style: Theme.of(context).textTheme.titleLarge
//                                 ?.copyWith(
//                                   fontSize: rsHeight(24),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                           ),
//                           SizedBox(height: rsHeight(12)),
//                           Text(
//                             "welcome_message".tr,
//                             textAlign: TextAlign.center,
//                             style: Theme.of(context).textTheme.bodyMedium,
//                           ),
//                           SizedBox(height: rsHeight(24)),
//                           ElevatedButton(
//                             onPressed: controller.goToNextScreen,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.green,
//                               minimumSize: Size(double.infinity, rsHeight(50)),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: Text("continue".tr),
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_utils.dart';
import '../controller/splash_controller.dart';
import '../../../widgets/custom_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _shapeController;
  late AnimationController _bottomController;

  late Animation<double> shapeFade;
  late Animation<Offset> topRightSlide;
  late Animation<Offset> bottomLeftSlide;

  late Animation<double> logoScale;
  late Animation<double> logoMoveUp;

  late Animation<Offset> bottomSlide;
  late Animation<double> bottomFade;

  final SplashController controller = Get.put(SplashController());

  @override
  void initState() {
    super.initState();

    _shapeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Shapes animation
    shapeFade = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _shapeController, curve: Curves.easeInOut),
    );

    topRightSlide =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.3, -0.3)).animate(
          CurvedAnimation(parent: _shapeController, curve: Curves.easeInOut),
        );

    bottomLeftSlide =
        Tween<Offset>(begin: Offset.zero, end: const Offset(-0.3, 0.3)).animate(
          CurvedAnimation(parent: _shapeController, curve: Curves.easeInOut),
        );

    // Logo scale & move up during shape animation
    logoScale = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _shapeController, curve: Curves.easeInOut),
    );

    logoMoveUp = Tween<double>(
      begin: 0,
      end: -20,
    ).animate(CurvedAnimation(parent: _shapeController, curve: Curves.easeOut));

    // Bottom sheet animation
    _bottomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    bottomSlide = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _bottomController, curve: Curves.easeOut),
        );

    bottomFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _bottomController, curve: Curves.easeIn));

    // Start both animations together
    _shapeController.forward();
    _bottomController.forward();
  }

  @override
  void dispose() {
    _shapeController.dispose();
    _bottomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils.init(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Shapes + Logo
          AnimatedBuilder(
            animation: _shapeController,
            builder: (context, _) {
              return Stack(
                children: [
                  // Top-right shape
                  FadeTransition(
                    opacity: shapeFade,
                    child: SlideTransition(
                      position: topRightSlide,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: SizeUtils.rsHeight(100),
                          width: SizeUtils.rsWidth(100),
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Bottom-left shape
                  FadeTransition(
                    opacity: shapeFade,
                    child: SlideTransition(
                      position: bottomLeftSlide,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          height: SizeUtils.rsHeight(220),
                          width: SizeUtils.rsWidth(220),
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(200),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Logo
                  Center(
                    child: AnimatedBuilder(
                      animation: _shapeController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, logoMoveUp.value),
                          child: ScaleTransition(
                            scale: logoScale,
                            child: child,
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        "assets/images/logo.svg", // your SVG file here
                        width: SizeUtils.rsWidth(200),
                        height: SizeUtils.rsHeight(200),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Bottom sheet
          AnimatedBuilder(
            animation: _bottomController,
            builder: (context, _) {
              return FractionalTranslation(
                translation: bottomSlide.value,
                child: Opacity(
                  opacity: bottomFade.value,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: SizeUtils.rsHeight(24),
                        horizontal: SizeUtils.rsWidth(24),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome".tr,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontSize: SizeUtils.rsHeight(24),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                          SizedBox(height: SizeUtils.rsHeight(12)),
                          Text(
                            "Lorem ipsum dolor sit amet consectetur.\nPellentesque fames lobortis vestibulum nisi\nnulla egestas nibh tincidunt nunc. "
                                .tr,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontSize: SizeUtils.rsHeight(15),
                                  color: Colors.white, // <-- text color white
                                ),
                          ),
                          SizedBox(height: SizeUtils.rsHeight(24)),
                          CustomButton(
                            label: "Getting Started".tr,
                            backgroundColor: AppColors.background,
                            textColor: Colors.black,
                            borderRadius: 50,
                            fullWidth: true,
                            height: SizeUtils.rsHeight(50),
                            onPressed: controller.goToNextScreen,
                          ),
                          SizedBox(height: SizeUtils.rsHeight(20)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
