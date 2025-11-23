import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/home/components/top_headline_shimer.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, controller, Widget? child) {
        if (controller.topHeadlineStatus == RequestStatusEnum.loading) {
          return const TopHeadlineShimmer();
        }

        if (controller.topHeadlineStatus == RequestStatusEnum.error) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  controller.errorMessage ?? "Error!",
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          );
        } else {
          return SliverList.builder(
            itemCount: controller.NewsTopHeadlineList?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final model = controller.NewsTopHeadlineList![index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                              errorWidget: (context, url, error) => Image.asset(
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
                                        model.urlToImage!.startsWith("http")
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
          );
        }
      },
    );
  }
}
