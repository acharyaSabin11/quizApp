import 'package:get/get.dart';
import 'package:quizapp/screens/auth/sign_up_page.dart';
import 'package:quizapp/screens/boarding/on_boarding_screen.dart';
import 'package:quizapp/screens/create_quiz_page.dart';
import 'package:quizapp/screens/directors/auth_or_main_page_director.dart';
import 'package:quizapp/utilities/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/auth/sign_in_page.dart';
import '../screens/home/main_screen.dart';

class RouteHelper {
  static final SharedPreferences sharedPreferences = Get.find();
  static const String _onBoardingPage = '/onBoardingScreen';
  static const String _signUpPage = '/signUpPage';
  static const String _signInPage = '/signInPage';
  static const String _createQuizPage = '/createQuizPage';
  static const String _initialPage = '/';
  static const String _mainPage = '/mainPage';
  static const String _authOrMainPageDirector = '/authOrMainPageDirector';

  static getOnBoardingPage() => _onBoardingPage;
  static getSignUpPage() => _signUpPage;
  static getSignInPage() => _signInPage;
  static getCreateQuizPage() => _createQuizPage;
  static getMainPage() => _mainPage;
  static getAuthOrMainPageDirector() => _authOrMainPageDirector;
  static getInitialPage() {
    bool firstInitialize = true;
    if (sharedPreferences.containsKey(AppConstants.firstLoad)) {
      firstInitialize = sharedPreferences.getBool(AppConstants.firstLoad)!;
    }
    if (firstInitialize) {
      return _onBoardingPage;
    } else {
      return _authOrMainPageDirector;
    }
  }

  static List<GetPage> routes = [
    GetPage(
      name: getOnBoardingPage(),
      page: () => OnBoardingScreen(),
    ),
    GetPage(
      name: getSignUpPage(),
      page: () => SignUpPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: getSignInPage(),
      page: () => const SignInPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: getAuthOrMainPageDirector(),
      page: (() => AuthOrMainPageDirector()),
    ),
    GetPage(
      name: getMainPage(),
      page: () => const MainScreen(),
    ),
    GetPage(
      name: getCreateQuizPage(),
      page: () => const CreateQuizPage(),
    ),
  ];
}
