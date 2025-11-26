import 'package:flutter/material.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/home/categories_screen.dart';
import 'package:news_app/features/home/components/top_headline.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});

  final List<String> category = [
    "general",
    "business",
    "entertainment",
    "health",
    "science ",
    "sports",
    "technology",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewAllComponent(
          title: "Categories",
          color: Color(0xff141414),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CategoriesScreen();
                },
              ),
            );
          },
        ),
        Padding(
          padding:  EdgeInsets.only(top: AppSizes.ph16, left: AppSizes.sp16, bottom: AppSizes.ph16),
          child: SizedBox(
            height: AppSizes.h36,
            child: Consumer<HomeController>(
              builder: (BuildContext context, Controller, Widget? child) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  itemCount: category.length,
                  padding: EdgeInsets.only(right: AppSizes.pw16),
                  itemBuilder: (BuildContext context, int index) {
                    bool isSelected =
                        category[index] == Controller.selectedCategory;
                    return GestureDetector(
                      onTap: () {
                        Controller.updatedSelectedCategory(category[index]);
                      },
                      child: IntrinsicWidth(
                        child: Column(
                          children: [
                            Text(
                              "${category[index][0].toUpperCase() + category[index].substring(1)}",
                              style: TextStyle(
                                fontSize: AppSizes.sp16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff363636),
                              ),
                            ),
                            if (isSelected) ...[
                              SizedBox(height: AppSizes.ph6),
                              Container(
                                height: AppSizes.ph2,
                                color: LightColor.primaryColor,
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: AppSizes.pw12);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
