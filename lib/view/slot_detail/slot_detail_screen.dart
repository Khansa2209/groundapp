import 'package:flutter/material.dart';
import 'package:pitchgo/common_widget/container/review_card.dart';

import '../../app_constant/app_color.dart';

class SlotDetailScreen extends StatelessWidget {
  const SlotDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              centerTitle: true,
              title: const Text("Slot Details"),
            ),
            body: Column(children: [
              const ReviewCard(),
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppColors.whiteFFFFFF,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      )
                    ]),
                child: const Column(
                  // spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Booking Details",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.black20222C),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TitleAndValueRow(
                      title: "Name",
                      value: "Aqua Megumin",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TitleAndValueRow(
                      title: "Email",
                      value: "aqua@adventurer.com",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TitleAndValueRow(
                      title: "Duration",
                      value: "2 Hours",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TitleAndValueRow(
                      title: "Start Date",
                      value: "12:00 pm - 02:00 pm",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TitleAndValueRow(
                      title: "Date",
                      value: "Aqua Megumin",
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppColors.whiteFFFFFF,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      )
                    ]),
                child: const Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Details",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.black20222C),
                    ),
                    TitleAndValueRow(
                      title: "Payment Options",
                      value: "Easypaisa",
                    ),
                    TitleAndValueRow(
                      title: "Subtotal",
                      value: "2000 Rs",
                    ),
                    TitleAndValueRow(
                      title: "Promo code",
                      value: "#101201",
                    ),
                    Divider(
                      color: AppColors.greyD3D3D3,
                    ),
                    TitleAndValueRow(
                      title: "Total",
                      titleWeight: FontWeight.w600,
                      value: "1000 Rs",
                    ),
                  ],
                ),
              )
            ])));
  }
}

class TitleAndValueRow extends StatelessWidget {
  const TitleAndValueRow(
      {super.key,
      required this.title,
      required this.value,
      this.titleWeight = FontWeight.w400});

  final String title;
  final String value;
  final FontWeight titleWeight;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: TextStyle(
            fontWeight: titleWeight, fontSize: 14, color: AppColors.grey667085),
      ),
      Text(
        value,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.grey667085),
      ),
    ]);
  }
}
