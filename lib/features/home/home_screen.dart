import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/home/components/categories_list.dart';
import 'package:news_app/features/home/components/trending_news.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeController(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 340,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 240,
                          width: double.infinity,
                          child: Image.asset(
                            "assets/images/background.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          top: 70,
                          child: Column(
                            children: [
                              Text(
                                "NEWST",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400,
                                  color: LightColor.primaryColor,
                                ),
                              ),
                              SizedBox(height: 6),
                              ViewAllComponent(
                                title: "Trending News",
                                color: Colors.white,
                                onTap: () {},
                              ),
                              SizedBox(height: 12),
                              TrendingNews(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ViewAllComponent(
                    title: "Categories",
                    color: Color(0xff141414),
                    onTap: () {},
                  ),
                ),
                SliverToBoxAdapter(child: CategoriesList()),
                SliverList.builder(
                  itemCount: controller.NewsTopHeadlineList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    padding:
                    EdgeInsets.zero;

                    final model = controller.NewsTopHeadlineList![index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          model.urlToImage != null &&
                                  model.urlToImage!.isNotEmpty &&
                                  model.urlToImage!.startsWith("http")
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    model.urlToImage!,
                                    height: 80,
                                    width: 140,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8),

                                  child: Image.asset(
                                    "assets/images/background.png",
                                    height: 80,
                                    width: 140,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${model.title}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff141414),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 2,
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        model.urlToImage ?? "",
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        "${model.author ?? ""}".substring(
                                          0,
                                          min((model.author ?? "").length, 10),
                                        ),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff141414),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "${model.formateDateTime() ?? ""}",

                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff141414),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
