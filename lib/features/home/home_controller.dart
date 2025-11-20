import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_services.dart';
import 'package:news_app/core/datasource/remote_data/apoi_config.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/features/home/model/new_article_model.dart';

class HomeController extends ChangeNotifier {
  RequestStatusEnum everyThingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadlineStatus = RequestStatusEnum.loading;
  bool topHeadlineLoading = true;
  bool evertThingLoading = true;
  String? errorMessage;
  String? selectedCategory;

  // bool isloading = true;
  List<newsArticleModel>? NewsTopHeadlineList = [];
  List<newsArticleModel>? newsEveryThingList = [];
  ApiServices apiservices = ApiServices();
  HomeController() {
    getEverything();
    getTopHeadline();
  }
  void updateSelectedCategory(String category) {
    selectedCategory = category;
    // getTopHeadline(category: category);
    notifyListeners();
  }

  void getTopHeadline({String? category}) async {
    try {
      Map<String, dynamic> result = await apiservices.get(
        "${ApiConfig.topHeadline}",
        params: {"country": "us","category":selectedCategory},
      );

      NewsTopHeadlineList = (result["articles"] as List)
          .map((e) => newsArticleModel.fromJson(e))
          .toList();
      topHeadlineStatus = RequestStatusEnum.loaded;
      errorMessage = null;
      // notifyListeners();
    } catch (e) {
      topHeadlineStatus = RequestStatusEnum.error;
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
      everyThingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      everyThingStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
