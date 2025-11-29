import 'package:flutter/material.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:news_app/core/datasource/remote_data/api_services.dart';
import 'package:news_app/core/repository/news_repository.dart';
import 'package:news_app/features/search/controller/search_controller.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return SearchScreenController(newsRepository: NewsRepository());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Search",
            style: TextStyle(
              fontSize: AppSizes.sp16,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(AppSizes.ph16),
          child: Consumer<SearchScreenController>(
            builder: (BuildContext context, controller, Widget? child) {
              return Column(
                children: [
                  TextField(
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.getEverything();
                    },
                    decoration: InputDecoration(
                      hint: Text("Search"),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Color(0xffA0A0A0),
                        size: AppSizes.r30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.newsEveryThingList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        final model = controller.newsEveryThingList![index];
                        return Padding(
                          padding: EdgeInsets.all(AppSizes.ph8),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(
                                  Icons.search,
                                  color: Color(0xffA0A0A0),
                                  size: AppSizes.r20,
                                ),
                                title: Text(
                                  model.title ?? "No data",
                                  maxLines: 1,
                                ),
                              ),
                              Divider(color: Color(0xffA0A0A0)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
