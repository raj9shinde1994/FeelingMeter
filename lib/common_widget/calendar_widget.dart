import 'package:feeling_meter/const/color_const.dart';
import 'package:feeling_meter/controller/emoji_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class Calendar extends StatelessWidget {
  final Controller c = Get.put(Controller());

  // TO tracking date
  ScrollController scrollController =
      ScrollController(); //To Track Scroll of ListView

  final List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  List<String> listOfDays = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];

  Calendar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //To Show Current Date
        Align(
          alignment: Alignment.topLeft,
          child: Obx(() => dateLabelSelection(
              c.selectedDate.value.day.toString() +
                  " " +
                  listOfMonths[c.selectedDate.value.month - 1] +
                  ', ' +
                  c.selectedDate.value.year.toString())),
        ),
        const SizedBox(height: 20),
        //To show Calendar Widget
        Container(
            height: 80,
            margin: const EdgeInsets.symmetric(horizontal: 22),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 10);
              },
              itemCount: 365,
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Obx(() => InkWell(
                      onTap: () {
                        c.setSelectedDate(
                            DateTime.now().add(Duration(days: index)));
                        c.setIndex(index);

                        Map map = {
                          "user_id": 3206161992,
                          "feeling_date": c.selectedDate.value.day.toString() +
                              "-" +
                              listOfMonths[c.selectedDate.value.month - 1] +
                              '-' +
                              c.selectedDate.value.year.toString()
                        };
                        Get.find<EmojiController>().fetchFeelingsList(map);
                      },
                      child: Container(
                        height: 70,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: c.selectedIndex.value == index
                                ? Color(0xFF4F4F4F)
                                : Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              listOfDays[DateTime.now()
                                          .add(Duration(days: index))
                                          .weekday -
                                      1]
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'SF Pro Rounded',
                                  height: 0.083,
                                  color: Color(0xFFA7A7A7)),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              DateTime.now()
                                  .add(Duration(days: index))
                                  .day
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w200,
                                  color: c.selectedIndex.value == index
                                      ? const Color(0xFFF1F2F3)
                                      : const Color(0XFF121212)),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ));
              },
            )),
      ],
    );
  }

  Widget dateLabelSelection(String date) {
    return Container(
      height: 28,
      width: 78,
      margin: const EdgeInsets.only(left: 20, top: 10),
      decoration: const BoxDecoration(
        color: Color(0XFFC6E5F7),
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
      child: Center(
        child: Text(
          date,
          style: TextStyle(
            fontFamily: 'SF Pro Rounded',
            height: 0.85,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Controller extends GetxController {
  var selectedIndex = 0.obs;
  var selectedDate = DateTime.now().obs;

  setIndex(int index) {
    selectedIndex.value = index;
  }

  setSelectedDate(date) {
    selectedDate.value = date;
  }
}
