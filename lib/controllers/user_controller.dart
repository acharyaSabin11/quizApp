import 'dart:convert';

import 'package:get/get.dart';
import 'package:quizapp/models/user_model.dart';
import 'package:quizapp/utilities/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  UserModel? _userModel;
  SharedPreferences sharedPreferences;
  UserController({required this.sharedPreferences}) {
    setUserModelFromLocalStorage();
  }

  UserModel? get userModel => _userModel;

  void setUserModelFromLocalStorage() {
    if (sharedPreferences.containsKey(AppConstants.userDataKey)) {
      _userModel = UserModel.fromJson(
          jsonDecode(sharedPreferences.getString(AppConstants.userDataKey)!)!);
      update();
    }
  }
}
