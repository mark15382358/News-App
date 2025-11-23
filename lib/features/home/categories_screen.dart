import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider, Consumer;

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});
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
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeController(),
      child: Scaffold(
        appBar: AppBar(title: Text("Categories"), centerTitle: true),
        body: Consumer<HomeController>(
          builder: (BuildContext context, controller, Widget? child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    bottom: 16.0,
                  ),
                  child: SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: ClampingScrollPhysics(),
                      itemCount: category.length,
                      padding: EdgeInsets.only(right: 16),
                      itemBuilder: (BuildContext context, int index) {
                        bool isSelected =
                            category[index] == controller.selectedCategory;
                        return GestureDetector(
                          onTap: () {
                            controller.updatedSelectedCategory(category[index]);
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
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.NewsTopHeadlineList?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
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
                                    child: CachedNetworkImage(
                                      imageUrl: model.urlToImage!,
                                      height: 80,
                                      width: 140,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        height: 80,
                                        width: 140,
                                        color: Colors.grey[300],
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                            "assets/images/background.png",
                                            height: 80,
                                            width: 140,
                                            fit: BoxFit.cover,
                                          ),
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
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            model.urlToImage != null &&
                                                model.urlToImage!.isNotEmpty &&
                                                model.urlToImage!.startsWith(
                                                  "http",
                                                )
                                            ? NetworkImage(model.urlToImage!)
                                            : const AssetImage(
                                                    "assets/images/background.png",
                                                  )
                                                  as ImageProvider,
                                      ),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          "${model.author ?? ""}".substring(
                                            0,
                                            min(
                                              (model.author ?? "").length,
                                              10,
                                            ),
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
                                          model.publishedAt != null
                                              ? DateTime.parse(
                                                  model.publishedAt!,
                                                ).formateDateTime()
                                              : "",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff141414),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      CustomSvgPicture(
                                        path: "assets/images/book_mark.svg",
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
