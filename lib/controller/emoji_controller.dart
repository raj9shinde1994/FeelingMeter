import 'package:feeling_meter/api_module/api_service.dart';
import 'package:feeling_meter/data_models/emotion_data_model.dart';
import 'package:get/get.dart';

class EmojiController extends GetxController {
  var isLoading = false.obs;
  var feelingPercentage = FeelingPercentage().obs;
  var feelingList = <FeelingList>[].obs;
  var videoArr = <VideoArr>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchFeelingsList(Map map) async {
    try {
      isLoading(true);
      EmojiDataModel emojiDataModel =
          await ApiService.getListOfUserFeeling(map);
      feelingPercentage.value = emojiDataModel.feelingPercentage;
      feelingList.value = emojiDataModel.feelingList;
      videoArr.value = emojiDataModel.videoArr;
    } finally {
      isLoading(false);
    }
  }
}
