import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:pitchgo/app_constant/app_color.dart';
import 'package:pitchgo/app_constant/app_string.dart';
import 'package:pitchgo/common_widget/common_botton.dart';

import '../../common_widget/container/review_card.dart';
import '../../common_widget/container/time_box_container.dart';
import '../../common_widget/section/section_heading.dart';
import '../edit_slot/edit_slote_screen.dart';

class EditGroundDetailScreen extends StatefulWidget {
  const EditGroundDetailScreen({super.key});

  @override
  State<EditGroundDetailScreen> createState() => _EditGroundDetailScreenState();
}

class _EditGroundDetailScreenState extends State<EditGroundDetailScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedMonth = DateFormat.MMMM().format(DateTime.now());
  List<DateTime> daysInMonth = [];

  final List<String> bookedSlot = [
    "13:30",
    "14:00",
    "15:00",
  ];

  final List<String> availableSlot = [
    "11:30",
    "15:30",
    "14:30",
    "16:30",
    "17:30",
  ];

  @override
  void initState() {
    super.initState();
    _generateDaysInMonth();
  }

  void _generateDaysInMonth() {
    // Generate all dates for the selected month
    final DateTime firstDay =
        DateTime(selectedDate.year, selectedDate.month, 1);
    final DateTime lastDay =
        DateTime(selectedDate.year, selectedDate.month + 1, 0);
    daysInMonth = List.generate(
      lastDay.day,
      (index) => DateTime(selectedDate.year, selectedDate.month, index + 1),
    );
    setState(() {});
  }

  void _onMonthChanged(String newMonth) {
    setState(() {
      final int monthIndex = DateFormat.MMMM().parse(newMonth).month;
      selectedDate = DateTime(selectedDate.year, monthIndex, 1);
      selectedMonth = newMonth;
      _generateDaysInMonth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text("Edit Ground Detail"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ReviewCard(),
          // Description
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: AppColors.redE73725,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 2), // changes position of shadow
                  )
                ]),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description",
                  style: TextStyle(
                      color: AppColors.whiteFFFFFF,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Paris Saint-Germain are set to test Tottenham's resolve this summer with an audacious bid to sign striker Harry Kane. According to reports in France, Kane has been earmarked by PSG hierarchy as the man to finally land Champions League honours at the Parc des Princes.",
                  style: TextStyle(
                      color: AppColors.whiteFFFFFF,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          // Calender
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionHeading1(
                  title: "Choose Date",
                ),
                // Dropdown Button
                Container(
                  height: 35,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: AppColors.black0C0507, width: 2), // Black border
                    borderRadius: BorderRadius.circular(4), // Rounded corners
                  ),
                  child: DropdownButton<String>(
                    underline: Container(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.black0C0507,
                    ),
                    value: selectedMonth,
                    items: List.generate(12, (index) {
                      String month =
                          DateFormat.MMMM().format(DateTime(0, index + 1));
                      return DropdownMenuItem(
                        value: month,
                        child: Text(
                          month,
                          style: const TextStyle(color: AppColors.black0C0507),
                        ),
                      );
                    }),
                    onChanged: (newMonth) {
                      if (newMonth != null) {
                        _onMonthChanged(newMonth);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          // Horizontal Date Picker
          Container(
              height: 90,
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: daysInMonth.length,
                itemBuilder: (context, index) {
                  final DateTime day = daysInMonth[index];
                  final bool isSelected = selectedDate.day == day.day &&
                      selectedDate.month == day.month &&
                      selectedDate.year == day.year;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = day;
                      });
                    },
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.red : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat.d().format(day), // Day
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected ? Colors.white : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat.E().format(day).toUpperCase(), // Weekday
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionHeading1(
                  title: "Price Per slot",
                ),
                SizedBox(
                    height: 30,
                    width: 80, // Set the width of the TextFormField
                    child: TextFormField(
                        decoration: InputDecoration(
                      hintText: "1200 Rs",
                      contentPadding: const EdgeInsets.all(4),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(4), // Rounded corners
                        borderSide: const BorderSide(
                          color: AppColors.black0C0507, // Black border
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(4), // Rounded corners
                        borderSide: const BorderSide(
                          color: AppColors.black0C0507, // Black border
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(4), // Rounded corners
                        borderSide: const BorderSide(
                          color: AppColors
                              .black0C0507, // Black border when focused
                          width: 2,
                        ),
                      ),
                    )))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionHeading1(
                  title: "Apply price to every slot",
                ),
                Transform.scale(
                  scale: 0.6,
                  alignment: Alignment.centerRight,
                  child: Switch(
                      trackOutlineColor:
                          const WidgetStatePropertyAll(Colors.black),
                      trackOutlineWidth: const WidgetStatePropertyAll(2.5),
                      padding: const EdgeInsets.all(0),
                      inactiveTrackColor: Colors.white,
                      inactiveThumbColor: AppColors.black0C0507,
                      value: false,
                      onChanged: (value) {}),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeading1(
                  title: "Available Slots",
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: availableSlot.length,
                      itemBuilder: (context, index) {
                        return TimeBoxContainer(
                          showIcon: true,
                          item: availableSlot[index],
                          containerColor: AppColors.whiteFFFFFF,
                          textColor: AppColors.green0CAB0C,
                          borderColor: AppColors.green0CAB0C,
                          iconColor: AppColors.black000000,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    ConfirmationDialog(
                                      heading: "View More Info",
                                      subHeading:
                                          "Mark ${availableSlot[index]} Slot as Booked",
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ));
                          },
                        );
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                const SectionHeading1(
                  title: "Booked Slots",
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: bookedSlot.length,
                      itemBuilder: (context, index) {
                        return TimeBoxContainer(
                          showIcon: true,
                          item: bookedSlot[index],
                          containerColor: AppColors.redE73725,
                          borderColor: AppColors.redE73725,
                          textColor: AppColors.whiteFFFFFF,
                          iconColor: AppColors.whiteFFFFFF,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    ConfirmationDialog(
                                      heading: "View More Info",
                                      subHeading:
                                          "Mark ${bookedSlot[index]} Slot as Available",
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ));
                          },
                        );
                      }),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CommonButton(
              radius: 4,
              title: "Save",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditSlotScreen()));
              })
        ],
      ),
    ));
  }
}
