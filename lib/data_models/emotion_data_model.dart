// To parse this JSON data, do
//
//     final emojiDataModel = emojiDataModelFromJson(jsonString);

import 'dart:convert';

EmojiDataModel emojiDataModelFromJson(String str) =>
    EmojiDataModel.fromJson(json.decode(str)['data']);

String emojiDataModelToJson(EmojiDataModel data) => json.encode(data.toJson());

class EmojiDataModel {
  EmojiDataModel({
    this.feelingPercentage,
    this.feelingList,
    this.videoArr,
  });

  FeelingPercentage feelingPercentage;
  List<FeelingList> feelingList;
  List<VideoArr> videoArr;

  factory EmojiDataModel.fromJson(Map<String, dynamic> json) => EmojiDataModel(
        feelingPercentage:
            FeelingPercentage.fromJson(json["feeling_percentage"]),
        feelingList: List<FeelingList>.from(
            json["feeling_list"].map((x) => FeelingList.fromJson(x))),
        videoArr: List<VideoArr>.from(
            json["video_arr"].map((x) => VideoArr.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "feeling_percentage": feelingPercentage.toJson(),
        "feeling_list": List<dynamic>.from(feelingList.map((x) => x.toJson())),
        "video_arr": List<dynamic>.from(videoArr.map((x) => x.toJson())),
      };
}

class FeelingList {
  FeelingList({
    this.userFeelingId,
    this.feelingId,
    this.feelingName,
    this.submitTime,
  });

  String userFeelingId;
  String feelingId;
  String feelingName;
  DateTime submitTime;

  factory FeelingList.fromJson(Map<String, dynamic> json) => FeelingList(
        userFeelingId: json["user_feeling_id"] as String,
        feelingId: json["feeling_id"] as String,
        feelingName: json["feeling_name"] as String,
        submitTime: DateTime.parse(json["submit_time"] as String),
      );

  Map<String, dynamic> toJson() => {
        "user_feeling_id": userFeelingId,
        "feeling_id": feelingId,
        "feeling_name": feelingName,
        "submit_time": submitTime.toIso8601String(),
      };
}

class FeelingPercentage {
  FeelingPercentage({
    this.happy = "",
    this.sad = "",
    this.energetic = "",
    this.calm = "",
    this.angry = "",
    this.bored = "",
  });

  String happy;
  String sad;
  String energetic;
  String calm;
  String angry;
  String bored;

  factory FeelingPercentage.fromJson(json) => FeelingPercentage(
        happy: json["Happy"] as String,
        sad: json["Sad"] as String,
        energetic: json["Energetic"] as String,
        calm: json["Calm"] as String,
        angry: json["Angry"] as String,
        bored: json["Bored"] as String,
      );

  Map<String, dynamic> toJson() => {
        "Happy": happy,
        "Sad": sad,
        "Energetic": energetic,
        "Calm": calm,
        "Angry": angry,
        "Bored": bored,
      };
}

class VideoArr {
  VideoArr({
    this.title,
    this.description,
    this.youtubeUrl,
  });

  String title;
  String description;
  String youtubeUrl;

  factory VideoArr.fromJson(Map<String, dynamic> json) => VideoArr(
        title: json["title"],
        description: json["description"],
        youtubeUrl: json["youtube_url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "youtube_url": youtubeUrl,
      };
}
