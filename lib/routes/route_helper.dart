import 'package:get/get.dart';
import 'package:quizapp/screens/auth/sign_up_page.dart';
import 'package:quizapp/screens/landing/landing_screen.dart';
import 'package:quizapp/utilities/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteHelper {
  static final SharedPreferences sharedPreferences = Get.find();
  static const String _landingPage = '/landingPage';
  static const String _signUpPage = '/signUpPage';
  static const String _initialPage = '/initialPage';

  static getLandingPage() => _landingPage;
  static getSignUpPage() => _signUpPage;
  static getInitialPage() {
    bool firstInitialize = true;
    if (sharedPreferences.containsKey(AppConstants.firstLoad)) {
      firstInitialize = sharedPreferences.getBool(AppConstants.firstLoad)!;
    }
    if (firstInitialize) {
      return _landingPage;
    } else {
      return _signUpPage;
    }
  }

  static List<GetPage> routes = [
    GetPage(
      name: getLandingPage(),
      page: () => const LandingScreen(),
    ),
    GetPage(
      name: getSignUpPage(),
      page: () => const SignUpPage(),
    ),
  ];
}
