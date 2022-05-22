import 'dart:convert';

import 'package:feeling_meter/data_models/emotion_data_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static var client = http.Client();
  static String fetchUrl =
      'https://www.qubehealth.com/qube_services/api/testservice/getListOfUserFeeling';
  static String authKey = 'f6d646a6c2f2df883ea0cccaa4097358ede98284';
  static String authToken = 'X-Api-Key';
  //static Map map = {"user_id": 3206161992, "feeling_date": "15-04-2022"};

  static Future<EmojiDataModel> getListOfUserFeeling(Map map) async {
    var response = await client.post(Uri.parse(fetchUrl),
        headers: {authToken: authKey}, body: jsonEncode(map));
    if(response.statusCode==200 ){
      var jsonString = response.body;
      return emojiDataModelFromJson(jsonString);
    }else{
      return EmojiDataModel();
    }


  }


}
