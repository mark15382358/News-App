import 'package:flutter/material.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/home/components/categories_list.dart';
import 'package:news_app/features/home/components/top_headline.dart';
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
                    height: AppSizes.h340,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: AppSizes.h240,
                          width: double.infinity,
                          child: Image.asset(
                            "assets/images/background.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          top: AppSizes.ph70,
                          child: Column(
                            children: [
                              Text(
                                "NEWST",
                                style: TextStyle(
                                  fontSize: AppSizes.sp40,
                                  fontWeight: FontWeight.w400,
                                  color: LightColor.primaryColor,
                                ),
                              ),
                              SizedBox(height: AppSizes.ph6),
                              ViewAllComponent(
                                title: "Trending News",
                                color: Colors.white,
                                onTap: () {},
                              ),
                              SizedBox(height: AppSizes.ph12),
                              TrendingNews(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: CategoriesList()),
                TopHeadline(),
              ],
            ),
          );
        },
      ),
    );
  }
}