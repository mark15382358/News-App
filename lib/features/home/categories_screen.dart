import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/constant/app_sizes.dart';
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
                  padding: EdgeInsets.only(
                    top: AppSizes.ph16,
                    left: AppSizes.pw16,
                    bottom: AppSizes.ph16,
                  ),
                  child: SizedBox(
                    height: AppSizes.h36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: ClampingScrollPhysics(),
                      itemCount: category.length,
                      padding: EdgeInsets.only(right: AppSizes.pw16),
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
                                    fontSize: AppSizes.sp16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff363636),
                                  ),
                                ),
                                if (isSelected) ...[
                                  SizedBox(height: AppSizes.h6),
                                  Container(
                                    height: AppSizes.h2,
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
                          horizontal: AppSizes.pw16,
                          vertical: AppSizes.ph8,
                        ),
                        child: Row(
                          children: [
                            model.urlToImage != null &&
                                    model.urlToImage!.isNotEmpty &&
                                    model.urlToImage!.startsWith("http")
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      AppSizes.r8,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: model.urlToImage!,
                                      height: AppSizes.h80,
                                      width: AppSizes.w140,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        height: AppSizes.h80,
                                        width: AppSizes.w140,
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
                                            height: AppSizes.h80,
                                            width: AppSizes.w140,
                                            fit: BoxFit.cover,
                                          ),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      "assets/images/background.png",
                                      height: AppSizes.h80,
                                      width: AppSizes.w140,
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
                                      fontSize: AppSizes.sp16,
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
                                      SizedBox(width: AppSizes.w6),
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
                                            fontSize: AppSizes.sp12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff141414),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: AppSizes.w8),
                                      Expanded(
                                        child: Text(
                                          model.publishedAt != null
                                              ? DateTime.parse(
                                                  model.publishedAt!,
                                                ).formateDateTime()
                                              : "",
                                          style: TextStyle(
                                            fontSize: AppSizes.sp12,
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
