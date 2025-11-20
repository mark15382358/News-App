import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});

  final List<String> category = [
    "business",
    "entertainment",
    "general",
    "health",
    "science ",
    "sports",
    "technology",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 16.0),
      child: SizedBox(
        height: 36,
        child: Consumer<HomeController>(
          builder: (BuildContext context, Controller, Widget? child) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: category.length,
              padding: EdgeInsets.only(right: 16),
              itemBuilder: (BuildContext context, int index) {
                bool isSelected =
                    category[index] == Controller.selectedCategory;
                return GestureDetector(
                  onTap: () {
                    Controller.updateSelectedCategory(category[index]);
                  },
                  child: IntrinsicWidth(
                    child: Column(
                      children: [
                        Text(
                          "${category[index][0].toUpperCase() + category[index].substring(1)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff363636),
                          ),
                        ),
                        if (isSelected) ...[
                          SizedBox(height: 6),
                          Container(
                            height: 2,
                            color: LightColor.primaryColor,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 12);
              },
            );
          },
        ),
      ),
    );
  }
}
