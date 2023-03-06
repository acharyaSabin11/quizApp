import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizapp/controllers/auth_controller.dart';
import 'package:quizapp/utilities/app_colors.dart';
import 'package:quizapp/utilities/app_constants.dart';
import 'package:quizapp/utilities/common_ui_functions.dart';
import 'package:quizapp/utilities/dimensions.dart';
import 'package:quizapp/widgets/big_text.dart';
import 'package:quizapp/widgets/effects/button_press_effect_container.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImageController extends GetxController {
  SharedPreferences sharedPreferences = Get.find();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? image;
  CroppedFile? croppedFile;
  File? compressedFileToUpload;
  Reference firebaseStorageRef = FirebaseStorage.instance
      .ref()
      .child("profileImages")
      .child(Get.find<AuthController>().currentUser!.uid);

  RxString profileImageUrl = "".obs;

  void getInitialProfileImage() async {
    if (sharedPreferences.containsKey(AppConstants.profileImagePresentKey)) {
      if (sharedPreferences.getBool(AppConstants.profileImagePresentKey)!) {
        profileImageUrl.value = Get.find<SharedPreferences>()
            .getString(AppConstants.profileImagePathKey)!;
      }
    }
  }

  void saveFileLoacally() async {
    final newPath = path.join(
        (await getApplicationDocumentsDirectory()).path,
        Get.find<AuthController>().currentUser!.uid +
            path.extension(croppedFile!.path));
    print(newPath);
    File file = File(newPath);
    await file.writeAsBytes(await compressedFileToUpload!.readAsBytes());
    Get.find<SharedPreferences>()
        .setBool(AppConstants.profileImagePresentKey, true);
    Get.find<SharedPreferences>()
        .setString(AppConstants.profileImagePathKey, newPath);
  }

  ProfileImageController() {
    getInitialProfileImage();
  }
  void pickImage() async {
    image = null;
    await customShowBottomSheet();
    if (image != null) {
      await cropImage();
      if (croppedFile != null) {
        showProgressIndicatorDialog();
        compressedFileToUpload = await compressImage();
        if (compressedFileToUpload != null) {
          await uploadImageToFirebase();
          saveFileLoacally();
        }
        Get.back();
      }
    }
  }

  List<IconData> icons = [
    Icons.camera,
    Icons.image,
  ];

  List<String> titles = [
    'Camera',
    'Gallery',
  ];

  List<String> imagePath = [
    'assets/images/camera.png',
    'assets/images/gallery.png',
  ];

  Future<File> compressImage() async {
    final newPath = path.join((await getTemporaryDirectory()).path,
        "${DateTime.now()}", "${path.extension(croppedFile!.path)}");
    try {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        croppedFile!.path,
        newPath,
        quality: 50,
      );
      return compressedImage!;
    } catch (e) {
      print(e);
      return File(croppedFile!.path);
    }
  }

  Future<void> uploadImageToFirebase() async {
    final result =
        await firebaseStorageRef.putFile(File(compressedFileToUpload!.path));
    profileImageUrl.value = await result.ref.getDownloadURL();
  }

  Future<void> cropImage() async {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          backgroundColor: Colors.white,
          statusBarColor: AppColors.mainBlueColor,
          toolbarTitle: 'Crop Image - Quiz App',
          toolbarColor: AppColors.mainBlueColor,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
          hideBottomControls: true,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );
  }

  Future<void> customShowBottomSheet() async {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // barrierColor: Colors.transparent,
      context: Get.context!,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BigText(
                text: "Choose Image From",
                size: 20,
              ),
              SizedBox(height: Dimensions.height10),
              Container(
                padding: EdgeInsets.all(Dimensions.height10),
                margin: EdgeInsets.only(
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                height: Dimensions.height60 * 1.5,
                decoration: BoxDecoration(
                    color: AppColors.backgroundWhiteColor,
                    borderRadius: BorderRadius.circular(Dimensions.height15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int i = 0; i < 2; i++)
                      ButtonPressEffectContainer(
                        height: Dimensions.height60 * 1.5,
                        width: Dimensions.width30 * 3,
                        onTapFunction: () async {
                          if (i == 0) {
                            image = await _imagePicker.pickImage(
                                source: ImageSource.camera);
                          } else {
                            image = await _imagePicker.pickImage(
                                source: ImageSource.gallery);
                          }
                          Get.back();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(Dimensions.height5),
                              height: Dimensions.height40,
                              width: Dimensions.height40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.height10),
                                  border: Border.all(
                                      color: AppColors.mainBlueColor,
                                      width: 2)),
                              child: Image.asset(
                                imagePath[i],
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(height: Dimensions.height5),
                            BigText(
                              text: titles[i],
                              textColor: AppColors.mainBlueColor,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
