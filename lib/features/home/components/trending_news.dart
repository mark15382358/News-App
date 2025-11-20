import 'package:news_app/core/enum/request_status_enum.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:news_app/features/home/model/new_article_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, controller, Widget? child) {
        switch (controller.everyThingStatus) {
          case RequestStatusEnum.loading:
            return Center(child: CircularProgressIndicator());
          case RequestStatusEnum.error:
            return Center(child: Text(controller.errorMessage ?? "Error"));
          case RequestStatusEnum.loaded:
            return SizedBox(
              height: 140,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount:
                    controller.NewsTopHeadlineList?.take(5).length ?? 0,
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(width: 12),
    
                itemBuilder: (BuildContext context, int index) {
                  final item = controller.NewsTopHeadlineList![index];
    
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: 240,
                        child: Stack(
                          children: [
                            Image.network(
                              item.urlToImage ?? "",
                              height: 140,
                              width: 240,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 140,
                                  width: 240,
                                  color: Colors.grey,
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.1),
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // bottom: 12,
                              top: 12,
                              right: 12,
                              left: 12,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title ?? "",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            (item.urlToImage != null &&
                                                item.urlToImage!.isNotEmpty)
                                            ? NetworkImage(item.urlToImage!)
                                            : null,
                                        backgroundColor: Colors.grey,
                                        radius: 10,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        item.author ?? "",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${item.formateDateTime()}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
        }
      },
    );
  }

  
}
