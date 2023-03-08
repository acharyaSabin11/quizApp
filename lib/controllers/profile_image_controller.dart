import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizapp/controllers/user_controller.dart';
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
  //to save the information that the image is present or not
  SharedPreferences sharedPreferences = Get.find();

  //  to get the current user
  UserController userController = Get.find();

  //to pick the image from the gallery or camera
  final ImagePicker _imagePicker = ImagePicker();
  XFile? image; //to store the image picked from the gallery or camera

  //to store the cropped image data
  CroppedFile? croppedFile;

  //to store the compressed image data
  File? compressedFileToUpload;

  //Reference to the firebase storage image-storing folder(profileImage) along with the user id as the name of the file
  late Reference firebaseStorageImageRef;

  //Provides the image url of the image stored in device storage
  RxString profileImageUrl = "".obs;

  //List of titles to be shown in the bottom sheet
  List<String> titles = [
    'Camera',
    'Gallery',
  ];

  //List of path of the images to be shown in the bottom sheet
  List<String> imagePath = [
    'assets/images/camera.png',
    'assets/images/gallery.png',
  ];

  //constructor of the class to get the initial profile image
  ProfileImageController() {
    firebaseStorageImageRef = FirebaseStorage.instance
        .ref()
        .child("profileImages")
        .child(userController.userModel!.uid);
    getInitialProfileImage();
  }

  //when the app loads, it checks if the image is present in the device storage or not. If it is present, then it sets the profileImageUrl to the path of the image stored in the device storage. If it is not present, then it checks if the image is present in the firebase storage or not. If it is present, then it downloads the image and sets the profileImageUrl to the path of the image stored in the device storage. If it is not present in firebase storage, then it sets the profileImageUrl to an empty string.
  void getInitialProfileImage() async {
    //checking if the firebase sotrage reference exists or not
    if (sharedPreferences.containsKey(AppConstants.profileImagePresentKey)) {
      if (sharedPreferences.getBool(AppConstants.profileImagePresentKey)!) {
        profileImageUrl.value = Get.find<SharedPreferences>()
            .getString(AppConstants.profileImagePathKey)!;
      }
    } else {
      try {
        //getting path in device storage to store the image
        final newPath = path.join(
            (await getApplicationDocumentsDirectory()).path,
            "${userController.userModel!.uid}${DateTime.now()}.jpg");
        final file = File(newPath);
        //downloading the image from firebase storage directly to the device storage
        await firebaseStorageImageRef.writeToFile(
            file); //if image is not present it throws exception and goes to catch block which shows that the image is not present on firebase storage.
        //setting the profileImageUrl to the path of the image stored in the device storage
        profileImageUrl.value = newPath;
        //setting the profileImagePresentKey to true
        sharedPreferences.setBool(AppConstants.profileImagePresentKey, true);
        //setting the profileImagePathKey to the path of the image stored in the device storage
        sharedPreferences.setString(AppConstants.profileImagePathKey, newPath);
      } catch (e) {
        profileImageUrl.value = "";
      }
    }
  }

  //when user presses the edit image button, it shows the bottom sheet to choose between camera and gallery. It also sets the image variable to the image picked from the gallery or camera. If the user cancels the process, then it sets the image variable to null. If the user selects any image from camera or gallary, then it directs user to crop the image. If user cancels the cropping, then it sets the croppedFile variable to null. If user crops the image, then it compresses the image and uploads it to firebase storage. If the image is successfully uploaded to firebase storage, then it saves the compressed image to the device storage. If the image is successfully saved to the device storage, then it shows a snackbar to the user and sets the profileImageUrl to the path of the image stored in the device storage.
  void pickImage() async {
    image = null;
    croppedFile = null;
    compressedFileToUpload = null;
    await customShowBottomSheet();
    if (image != null) {
      await cropImage();
      if (croppedFile != null) {
        showProgressIndicatorDialog();
        compressedFileToUpload = await compressImage();
        if (compressedFileToUpload != null) {
          if (await uploadImageToFirebase()) {
            await saveCompressedFileLoacally();
            showAppSnackbar(
              title: "Success",
              description: "Profile Image Updated Successfully",
            );
          }
        }
        Navigator.of(Get.context!).pop();
      }
    }
  }

  // to show the bottom sheet to choose between camera and gallery. It also sets the image variable to the image picked from the gallery or camera. If the user cancels the process, then it sets the image variable to null.
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

  //to crop the image. If user cancels the cropping, then croppedFile variable is set to null.
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

  //to compress the image. If the image is successfully compressed, then it returns the compressed image. If the image is not compressed, then it returns null.
  Future<File?> compressImage() async {
    final newPath = path.join((await getTemporaryDirectory()).path,
        "${DateTime.now()}${path.extension(croppedFile!.path)}");
    try {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        croppedFile!.path,
        newPath,
        quality: 50,
      );
      return compressedImage;
    } catch (e) {
      return null;
    }
  }

  //to upload the image to firebase storage.
  Future<bool> uploadImageToFirebase() async {
    try {
      await firebaseStorageImageRef.putFile(File(compressedFileToUpload!.path));
      return true;
    } catch (e) {
      return false;
    }
  }

  //the compressed image during upload is stored in the device storage.
  Future<void> saveCompressedFileLoacally() async {
    final newPath = path.join(
        (await getApplicationDocumentsDirectory()).path,
        userController.userModel!.uid +
            DateTime.now().toString() +
            path.extension(croppedFile!.path));
    File file = File(newPath);
    await file.writeAsBytes(await compressedFileToUpload!.readAsBytes());
    Get.find<SharedPreferences>()
        .setBool(AppConstants.profileImagePresentKey, true);
    Get.find<SharedPreferences>()
        .setString(AppConstants.profileImagePathKey, newPath);
    profileImageUrl.value = newPath;
  }

  // this method deletes the image from the device storage and sets the profileImageUrl to an empty string. It is called when the user signs out. It also removes the profileImagePathKey and profileImagePresentKey from the shared preferences.
  void deleteProfileImageFromLocalStorage() {
    if (sharedPreferences.containsKey(AppConstants.profileImagePresentKey)) {
      final path =
          sharedPreferences.getString(AppConstants.profileImagePathKey);
      File pathFile = File(path!);
      pathFile.delete();
      sharedPreferences.remove(AppConstants.profileImagePathKey);
      sharedPreferences.remove(AppConstants.profileImagePresentKey);
      profileImageUrl.value = "";
    }
  }
}
