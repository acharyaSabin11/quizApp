import 'package:get/get.dart';
import 'package:quizapp/screens/auth/sign_up_page.dart';
import 'package:quizapp/screens/landing/on_boarding_screen.dart';
import 'package:quizapp/utilities/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteHelper {
  static final SharedPreferences sharedPreferences = Get.find();
  static const String _onBoardingPage = '/onBoardingScreen';
  static const String _signUpPage = '/signUpPage';
  static const String _initialPage = '/initialPage';

  static getOnBoardingPage() => _onBoardingPage;
  static getSignUpPage() => _signUpPage;
  static getInitialPage() {
    bool firstInitialize = true;
    if (sharedPreferences.containsKey(AppConstants.firstLoad)) {
      firstInitialize = sharedPreferences.getBool(AppConstants.firstLoad)!;
    }
    if (firstInitialize) {
      return _onBoardingPage;
    } else {
      return _signUpPage;
    }
  }

  static List<GetPage> routes = [
    GetPage(
      name: getOnBoardingPage(),
      page: () => OnBoardingScreen(),
    ),
    GetPage(
      name: getSignUpPage(),
      page: () => const SignUpPage(),
    ),
  ];
}
