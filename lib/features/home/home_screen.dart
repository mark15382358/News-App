
import 'package:flutter/material.dart';
import 'package:news_app/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeController(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, controller , Widget? child) {
          return Scaffold(
            body: controller.evertThingLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller. NewsTopHeadlineList?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: Text(
                                 controller. NewsTopHeadlineList![index].title ??
                                      " mokaaaa",
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            
            // child: controller
            //     ? Center(child: CircularProgressIndicator())
            //     : Column(
            //         children: [
            //           Expanded(
            //             child: ListView.builder(
            //               itemCount: controller. NewsTopHeadlineList?.length,
            //               itemBuilder: (BuildContext context, int index) {
            //                 return Container(
            //                   child: Text(
            //                     controller.NewsTopHeadlineList![index].title ?? " mokaaaa",
            //                   ),
            //                 );
            //               },
            //             ),
            //           ),
            //         ],
            //       ),
          );
  }),
    );

    // (errorMessage?.isNotEmpty??false)?Center(child: Text(errorMessage!),
}}