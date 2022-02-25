import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/api.dart';
import 'dart:developer' as developer; //TO DELETE DEBUG

import 'package:news_app/model/news_info.dart';

class NewsApiController {

  Future<NewsModel> getNews() async{
    final http.Client client = http.Client();
    var newsModel;

    try {
      final response = await client.get(Uri.parse(Api.apiUrl));
      if(response.statusCode == 200) {
        String jsonString = response.body;
        newsModel = newsModelFromJson(jsonString);
      }
    } catch(e) {
      developer.log("ERROR $newsModel");
      return newsModel;
    }

    return newsModel;
  }

}