import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pitchgo/features/image/image_controller.dart';
import '../../app_constant/app_color.dart';
import '../../common_widget/common_botton.dart';
import '../../resource/utils.dart';

class SelectPhotoScreen extends StatelessWidget {
  const SelectPhotoScreen({super.key, this.image});

  final dynamic image;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectMediaController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Photo'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Would you like to add photos of Ground?',
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildButton(
                        context: context,
                        svgicon: 'assets/images/gallery.svg',
                        label: 'Use Gallery',
                        onPressed: () async {
                          if (image.length >= 5) {
                            Utils.showInfo(
                                'You cannot select more than 5 images');
                          } else {
                            final path = await controller.pickImageForButtons(
                                source: ImageSource.gallery);
                            if (path.path.isNotEmpty) {
                              image.add(path);
                            }
                          }
                        }),
                    const SizedBox(width: 15),
                    _buildButton(
                        context: context,
                        svgicon: 'assets/images/camera.svg',
                        label: 'Use Camera',
                        onPressed: () async {
                          if (image.length >= 5) {
                            Utils.showInfo(
                                'You cannot select more than 5 images');
                          } else {
                            final path = await controller.pickImageForButtons(
                                source: ImageSource.camera);
                            if (path.path.isNotEmpty) {
                              image.add(path);
                            }
                          }
                        }),
                  ],
                ),
                const SizedBox(height: 16),
                Obx(() {
                  if (image.isNotEmpty) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: image.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  image[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 4,
                              top: 4,
                              child: GestureDetector(
                                onTap: () {
                                  if (index >= 0 && index < image.length) {
                                    image.removeAt(index);
                                  }
                                },
                                child: const CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: CommonButton(
            onTap: () => Get.back(),
            title: 'Update',
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String svgicon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: AppColors.whiteFFFFFF,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgicon,
                color: AppColors.redE73725,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.black000000,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadRow({
    required BuildContext context,
    required String svgicon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: SvgPicture.asset(
              svgicon,
              color: const Color(0xFFFC6002),
              width: 35,
              height: 35,
            ),
          ),
          Expanded(
            child: Text(
              label,
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text(
              'Choose File',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColors.whiteFFFFFF,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
