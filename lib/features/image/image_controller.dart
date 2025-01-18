import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pitchgo/resource/utils.dart';

class SelectMediaController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  var selectedImagesForButton = <File>[].obs;
  var selectedImagesForUploadRow = <File>[].obs;

  var selectedImagesForRow = <File>[].obs;

  Rx<File?> selectedSingleImage = Rx<File?>(null);
  Rx<File?> profileImage = Rx<File?>(null);

  final int maxImages = 5;

  Future<void> pickProfileImage({required ImageSource source}) async {
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 5);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  void resetSelectedImage() {
    profileImage.value = null;
    selectedSingleImage.value = null;
    selectedImagesForButton.value = [];
    selectedImagesForUploadRow.value = [];
    selectedImagesForRow.value = [];
  }

  Future<File> pickImageForButtons({required ImageSource source}) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: source, imageQuality: 5);
    if (pickedFile != null) {
      // selectedImagesForButton.add(File(pickedFile.path));

      return File(pickedFile.path);
    } else {
      return File('');
    }
  }

  Future<void> pickImageForUploadRow({required ImageSource source}) async {
    if (selectedImagesForUploadRow.length >= maxImages) {
      Utils.showInfo('You cannot select more than 5 images');
      return;
    }

    final XFile? pickedFile =
        await _picker.pickImage(source: source, imageQuality: 5);
    if (pickedFile != null) {
      selectedImagesForUploadRow.add(File(pickedFile.path));
    }
  }

  Future<void> pickImageForRow({required ImageSource source}) async {
    if (selectedImagesForRow.length >= maxImages) {
      Utils.showInfo('You cannot select more than 4 images');
      return;
    }

    final XFile? pickedFile =
        await _picker.pickImage(source: source, imageQuality: 5);
    if (pickedFile != null) {
      selectedImagesForRow.add(File(pickedFile.path));
    }
  }

  void pickSingleImage({required ImageSource source}) async {
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 5);
    if (pickedFile != null) {
      print("Picked File ${pickedFile.path}");
      selectedSingleImage.value = File(pickedFile.path);
    }
  }
  //  Future<void> pickProfileImage() async {
  //   // Pick image from gallery or camera
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 5);
  //   if (pickedFile != null) {
  //     authController.userProfileImage.value = pickedFile.path;
  //   }
  // }

  void removeSelectedImage() {
    selectedSingleImage.value = null;
  }

  void removeImageFromButton(int index) {
    if (index >= 0 && index < selectedImagesForButton.length) {
      selectedImagesForButton.removeAt(index);
    }
  }

  void removeImageFromUploadRow(int index) {
    if (index >= 0 && index < selectedImagesForUploadRow.length) {
      selectedImagesForUploadRow.removeAt(index);
    }
  }

  void removeImageFromRow(int index) {
    if (index >= 0 && index < selectedImagesForRow.length) {
      selectedImagesForRow.removeAt(index);
    }
  }
}
