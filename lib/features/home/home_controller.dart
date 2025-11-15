import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_services.dart';
import 'package:news_app/core/datasource/remote_data/apoi_config.dart';
import 'package:news_app/features/home/model/new_article_model.dart';

class HomeController extends ChangeNotifier {
  bool topHeadlineLoading = true;
  bool evertThingLoading = true;
  String? errorMessage;
  // bool isloading = true;
  List<newsArticleModel>? NewsTopHeadlineList = [];
  List<newsArticleModel>? newsEveryThingList = [];
  ApiServices apiservices = ApiServices();
  HomeController() {
    getEverything();
    getTopHeadline();
  }
  // void initData() {
  //   getEverything();
  //   getTopHeadline();
  // }

  void getTopHeadline() async {
    try {
      Map<String, dynamic> result = await apiservices.get(
        "${ApiConfig.topHeadline}",
        params: {"country": "us"},
      );

      NewsTopHeadlineList = (result["articles"] as List)
          .map((e) => newsArticleModel.fromJson(e))
          .toList();
      topHeadlineLoading = false;
      errorMessage = null;
      // notifyListeners();
    } catch (e) {
      topHeadlineLoading = false;
      errorMessage = e.toString();
    }
          notifyListeners();

  }

  void getEverything() async {
    try {
      Map<String, dynamic> result = await apiservices.get(
        '${ApiConfig.everyThing}',
        params: {"q": "tesla"},
      );
      print("result:  $result");

      ///Map<key,value>->List<Map>=>
      print(result["articles"][1]["description"]);
      newsEveryThingList = (result["articles"] as List)
          .map((e) => newsArticleModel.fromJson(e))
          .toList();
      evertThingLoading = false;
      errorMessage = null;
    } catch (e) {
      evertThingLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
