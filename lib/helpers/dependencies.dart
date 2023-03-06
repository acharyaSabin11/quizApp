import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:quizapp/controllers/auth_controller.dart';
import 'package:quizapp/controllers/profile_image_controller.dart';
import 'package:quizapp/firebase_options.dart';
import 'package:quizapp/utilities/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  if (!sharedPreferences.containsKey(AppConstants.firstLoad)) {
    sharedPreferences.setBool(AppConstants.firstLoad, true);
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.lazyPut(() => sharedPreferences, fenix: true);
  Get.lazyPut(() => AuthController(), fenix: true);
  Get.lazyPut(() => ProfileImageController(), fenix: true);
}
