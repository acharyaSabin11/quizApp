import 'package:get/get.dart';
import 'package:quizapp/screens/auth/sign_up_page.dart';
import 'package:quizapp/screens/boarding/on_boarding_screen.dart';
import 'package:quizapp/utilities/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/auth/sign_in_page.dart';

class RouteHelper {
  static final SharedPreferences sharedPreferences = Get.find();
  static const String _onBoardingPage = '/onBoardingScreen';
  static const String _signUpPage = '/signUpPage';
  static const String _signInPage = '/signInPage';
  static const String _initialPage = '/initialPage';

  static getOnBoardingPage() => _onBoardingPage;
  static getSignUpPage() => _signUpPage;
  static getSignInPage() => _signInPage;
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
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: getSignInPage(),
      page: () => const SignInPage(),
      transition: Transition.rightToLeft,
    ),
  ];
}
