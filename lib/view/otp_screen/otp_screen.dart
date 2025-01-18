import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../app_constant/app_color.dart';
import '../../controller/signin_controller.dart';
import '../../controller/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.profile});

  final String profile;

  @override
  Widget build(BuildContext context) {
    final timeController = Get.put(OtpController());
    final controller = Get.put(LoginController());

    final defaultPinTheme = PinTheme(
      width: 74,
      height: 45,
      textStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
      decoration: BoxDecoration(
        color: AppColors.greyD3D3D3,
        border: Border.all(color: AppColors.black1F1F1F),
        borderRadius: BorderRadius.circular(10),
      ),
    );
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: context.width * 0.1,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.width * 0.1 + 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Enter code",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: .69),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Check your email! We’ve sent a one-time verification code to ${controller.email.text.trim()}. Enter the code below to verify your account.",
                    style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.grey8F8F8F,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Pinput(
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyDecorationWith(
                      color: const Color.fromRGBO(199, 234, 255, 1)),
                  length: 4,
                  showCursor: true,
                  onCompleted: (pin) {
                    timeController.pinValue = pin;
                    timeController.checkpin(
                        controller.email.text.trim(), profile);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                          text: 'You can resend the code in ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins")),
                      TextSpan(
                        text: "${timeController.seconds.value}",
                        style: const TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: AppColors.green0CAB0C),
                      ),
                      const TextSpan(
                          text: ' seconds!',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins")),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: controller.login,
              child: Obx(
                () => Center(
                    child: timeController.seconds.value == 0
                        ? const Text(
                            "Resend code",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins"),
                          )
                        : Container()),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
