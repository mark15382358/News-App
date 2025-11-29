import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_services.dart';
import 'package:news_app/core/datasource/remote_data/apoi_config.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/core/mixines/safe_notify_mixines.dart';
import 'package:news_app/features/home/model/new_article_model.dart';
import 'package:news_app/core/repository/news_repository.dart';

class HomeController extends ChangeNotifier with SafeNotifyMixines{
  RequestStatusEnum everyThingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadlineStatus = RequestStatusEnum.loading;
  bool topHeadlineLoading = true;
  bool evertThingLoading = true;
  bool isDispose = false;
  String? errorMessage;
  String? selectedCategory = "general";
  NewsRepository newsRepository = NewsRepository();
  // bool isloading = true;
  List<newsArticleModel>? NewsTopHeadlineList = [];
  List<newsArticleModel>? newsEveryThingList = [];
  ApiServices apiservices = ApiServices();
  HomeController() {
    getEverything();
    getTopHeadline();
  }
 

  void getTopHeadline({String? category}) async {
    try {
      topHeadlineStatus = RequestStatusEnum.loaded;
      errorMessage = null;
      notify();
      NewsTopHeadlineList = await newsRepository.getTopHeadline(
        selectedCategory: category,
      );
    } catch (e) {
      topHeadlineStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    notify();
  }

  void getEverything() async {
    try {
      everyThingStatus = RequestStatusEnum.loading;
      notify;
      newsEveryThingList = await newsRepository.getEveryThing();
      everyThingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      everyThingStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    notify();
  }

  updatedSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadline(category: category);
    notify();
  }

  
}
