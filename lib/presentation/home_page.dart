import 'package:feeling_meter/common_widget/calendar_widget.dart';
import 'package:feeling_meter/common_widget/common_widget_in_app.dart';
import 'package:feeling_meter/common_widget/video_player.dart';
import 'package:feeling_meter/const/color_const.dart';
import 'package:feeling_meter/const/img_const.dart';
import 'package:feeling_meter/controller/emoji_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final EmojiController emojiController = Get.put(EmojiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: WF.getThemeAppBar(
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            feelingForLast30Days(),
            const SizedBox(
              height: 12,
            ),
            feelingListWidget(),
            const SizedBox(
              height: 10,
            ),
            seperator(),
            Calendar(),
            const SizedBox(
              height: 24,
            ),
            seperator(),
            if (emojiController.feelingList != null &&
                emojiController.feelingList.isNotEmpty)
              Column(
                children: [
                  listOfEmotionsOnDayWidget(),
                  seperator(),
                ],
              ),
            const SizedBox(
              height: 32,
            ),
            Obx(() => emojiController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.green,
                  ))
                : videoWidget()),
            const SizedBox(
              height: 72,
            ),
          ],
        ),
      ),
    );
  }

  Widget listOfEmotionsOnDayWidget() {
    return Container(
      height: 138,
      margin: const EdgeInsets.fromLTRB(25, 16, 0, 16),
      child: ListView.builder(
          itemCount: emojiController.feelingList.length,
          itemBuilder: (BuildContext context, int index) {
            var feeling = emojiController.feelingList[index];
            return emotionsItemForDay(feeling.submitTime.toString(),
                feeling.feelingName, getUiImage(feeling.feelingName));
          }),
    );
  }

  String getUiImage(String feeling) {
    if (feeling.toLowerCase() == 'calm') {
      return UIImage.CALM_EMOJI;
    } else if (feeling.toLowerCase() == 'energetic') {
      return UIImage.ENERGY_EMOJI;
    } else if (feeling.toLowerCase() == 'sad') {
      return UIImage.SAD_EMOJI;
    } else if (feeling.toLowerCase() == 'happy') {
      return UIImage.HAPPY_EMOJI;
    } else if (feeling.toLowerCase() == 'angry') {
      return UIImage.ANGRY_EMOJI;
    } else if (feeling.toLowerCase() == 'bored') {
      return UIImage.BORED_EMOJI;
    } else if (feeling.toLowerCase() == 'love') {
      return UIImage.LOVE_EMOJI;
    } else {
      return "";
    }
  }

  Widget videoWidget() {
    return SizedBox(
      height: 245,
      child: ListView.builder(
        reverse: true,
        itemCount: emojiController.videoArr.length,
        itemBuilder: (context, position) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  emojiController.videoArr[position].title ?? "",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'SF Pro Rounded',
                    fontSize: 18,
                    color: AppColors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  emojiController.videoArr[position].description ?? "",
                  maxLines: 4,
                  style: TextStyle(
                    fontFamily: 'SF Pro Rounded',
                    fontSize: 14,
                    color: AppColors.black.withOpacity(0.4),
                  ),
                ),
              ),
              Container(
                height: 130,
                margin:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: emojiController.videoArr.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                            color: Colors.grey,
                            height: 128,
                            width: 208,
                            child: VideoPlayer(
                              videoId:
                                  emojiController.videoArr[index].youtubeUrl,
                            )),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget emotionsItemForDay(String time, String feelings, String uiImage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 38.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 38.0),
            child: Text(
              time,
              style: TextStyle(
                fontFamily: 'SF Pro Rounded',
                height: 0.85,
                fontSize: 12,
                color: AppColors.black,
              ),
            ),
          ),
          Row(
            children: [
              if (uiImage.isNotEmpty) Image.asset(uiImage),
              const SizedBox(
                width: 4,
              ),
              Text(
                feelings,
                style: TextStyle(
                  fontFamily: 'SF Pro Rounded',
                  height: 0.85,
                  fontSize: 14,
                  color: AppColors.black,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget seperator() {
    return Container(
      height: 1,
      width: double.infinity,
      color: const Color(0xFFE5E5E5).withOpacity(0.9),
    );
  }

  Widget feelingForLast30Days() {
    return Padding(
      padding: const EdgeInsets.only(left: 22, top: 20),
      child: Text(
        'Your feelings from last 30 days',
        style: TextStyle(
          fontFamily: 'SF Pro Rounded',
          height: 0.85,
          fontSize: 16,
          color: AppColors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget feelingListWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.5),
      child: SizedBox(
        height: 120,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            feelingItemWidget(
                percent: emojiController.feelingPercentage.value.energetic,
                imgUrl: UIImage.ENERGY_EMOJI,
                emotion: 'Energetic'),
            feelingItemWidget(
                percent: emojiController.feelingPercentage.value.sad,
                imgUrl: UIImage.SAD_EMOJI,
                emotion: 'Sad'),
            feelingItemWidget(
                percent: emojiController.feelingPercentage.value.happy,
                imgUrl: UIImage.HAPPY_EMOJI,
                emotion: 'Happy'),
            feelingItemWidget(
                percent: emojiController.feelingPercentage.value.angry,
                imgUrl: UIImage.ANGRY_EMOJI,
                emotion: 'Angry'),
            feelingItemWidget(
                percent: emojiController.feelingPercentage.value.calm,
                imgUrl: UIImage.CALM_EMOJI,
                emotion: 'Calm'),
            feelingItemWidget(
                percent: emojiController.feelingPercentage.value.bored,
                imgUrl: UIImage.BORED_EMOJI,
                emotion: 'Bored'),
            feelingItemWidget(
                percent: '', imgUrl: UIImage.LOVE_EMOJI, emotion: 'Love'),
          ],
        ),
      ),
    );
  }

  Widget feelingItemWidget(
      {String percent = '', String imgUrl = '', String emotion = ''}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.5),
      child: Stack(
        children: [
          SizedBox(
            height: 98,
            width: 50,
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 80,
                  margin: EdgeInsets.only(bottom: 4),
                  child: Stack(
                    children: [
                      Container(
                        height: 80,
                        width: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F2F3),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 1,
                              spreadRadius: 2,
                              color: Color(0xFFE5E5E5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            percent.isNotEmpty && percent != '0'
                                ? '$percent%'
                                : '',
                            style: TextStyle(
                              fontFamily: 'SF Pro Rounded',
                              height: 0.85,
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                              color: AppColors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 40,
                          height: 40,
                          child: Stack(
                            children: [
                              Image.asset(UIImage.GREEN_CIRCLE),
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(imgUrl),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    emotion,
                    style: TextStyle(
                      fontFamily: 'SF Pro Rounded',
                      height: 0.85,
                      fontSize: 12,
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          if (percent.isEmpty || percent == '0') maskingWidget()
        ],
      ),
    );
  }

  Widget maskingWidget() {
    return Opacity(
      opacity: 0.7,
      child: Container(
        height: 98,
        width: 50,
        color: AppColors.white.withOpacity(0.98),
      ),
    );
  }
}
