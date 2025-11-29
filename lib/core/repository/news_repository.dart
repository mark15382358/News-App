import 'package:equatable/equatable.dart';
import 'package:news_app/core/datasource/remote_data/api_services.dart';
import 'package:news_app/core/datasource/remote_data/apoi_config.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/features/home/model/new_article_model.dart';

class NewsRepository {
  ApiServices apiservices = ApiServices.instance;

  Future<List<newsArticleModel>> getTopHeadline({
    String? selectedCategory = "general",
  }) async {
    Map<String, dynamic> result = await apiservices.get(
      "${ApiConfig.topHeadline}",
      params: {"country": "us", "category": selectedCategory},
    );

    return (result["articles"] as List)
        .map((e) => newsArticleModel.fromJson(e))
        .toList();
  }

  Future<List<newsArticleModel>> getEveryThing({String? query="news"}) async {
    Map<String, dynamic> result = await apiservices.get(
      '${ApiConfig.everyThing}',
      params: {"q": query,},
    );
    return await (result["articles"] as List)
        .map((e) => newsArticleModel.fromJson(e))
        .toList();
  }
}
