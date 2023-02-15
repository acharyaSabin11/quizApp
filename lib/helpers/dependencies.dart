import 'package:get/get.dart';
import 'package:quizapp/controllers/landing_page_animation_controller.dart';
import 'package:quizapp/utilities/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  if (!sharedPreferences.containsKey(AppConstants.firstLoad)) {
    sharedPreferences.setBool(AppConstants.firstLoad, true);
  }
  Get.lazyPut(() => LandingPageAnimationController());
  Get.lazyPut(() => sharedPreferences);
}
