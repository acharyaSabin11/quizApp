import 'package:get/get.dart';
import 'package:quizapp/controllers/landing_page_animation_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => LandingPageAnimationController());
}
