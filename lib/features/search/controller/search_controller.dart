import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/core/mixines/safe_notify_mixines.dart';
import 'package:news_app/core/repository/news_repository.dart';
import 'package:news_app/features/home/model/new_article_model.dart';
import 'package:provider/provider.dart';

class SearchScreenController extends ChangeNotifier with SafeNotifyMixines {
    TextEditingController searchController = TextEditingController();
  final NewsRepository newsRepository;
  SearchScreenController({required this.newsRepository});
  String? errorMessage;
  bool evertThingLoading = true;
  List<newsArticleModel>? newsEveryThingList = [];
  RequestStatusEnum everyThingStatus = RequestStatusEnum.loading;

  void getEverything() async {
    try {
      everyThingStatus = RequestStatusEnum.loading;
      notify;
      newsEveryThingList = await newsRepository.getEveryThing(query: searchController.text);
      print("===================================0");
      print(newsEveryThingList);
      everyThingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      everyThingStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    notify();
  }
}
