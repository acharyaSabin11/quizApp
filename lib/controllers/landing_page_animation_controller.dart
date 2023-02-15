import 'package:get/get.dart';

class LandingPageAnimationController extends GetxController {
  var index = 0.obs;
  var left = true.obs;
  var start = false.obs;
  var endIndex = 0.0.obs;
  var methodCalled = false.obs;
  var startedText = "Get Started".obs;
  var containerReversed = true.obs;
  var nextOrPrevIsExecuting = false.obs;
}
