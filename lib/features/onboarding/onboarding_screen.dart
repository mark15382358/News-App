import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:news_app/features/onboarding/controller/controller.dart';
import 'package:news_app/features/onboarding/models/onboarding_model.dart';
import 'package:news_app/auth/login.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  _onFinish(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
    );
    await PreferencesManager().setBool("onboarding_complete", true);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<onBoardingController>(
      create: (BuildContext context) => onBoardingController(),
      builder: (context, _) {
        final controller = context.watch<onBoardingController>();
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              backgroundColor: Color(0xffFCFCFC),
              actions: [
                controller.isLastPage
                    ? SizedBox()
                    : TextButton(
                        onPressed: () {
                          _onFinish(context);
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (int index) {
                      controller.onPageChanged(index);
                    },
                    controller: controller.pageController,
                    itemCount: OnboardingModel.onBoardingList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final model = OnboardingModel.onBoardingList[index];
                      return Column(
                        children: [
                          Image(image: AssetImage(model.image)),
                          SizedBox(height: 24),
                          Text(
                            model.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff4E4B66),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            model.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff6E7191),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                SmoothPageIndicator(
                  controller: controller.pageController,
                  count: OnboardingModel.onBoardingList.length,
                  effect: SwapEffect(
                    dotColor: Color(0xffD3D3D3),
                    activeDotColor: Color(0xffC53030),
                  ),
                  onDotClicked: (index) {},
                ),
                SizedBox(height: 112),
                Consumer(
                  builder:
                      (
                        BuildContext context,
                        onBoardingController value,
                        widget,
                      ) {
                        return Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!value.isLastPage) {
                                controller.pageController.nextPage(
                                  duration: Duration(milliseconds: 600),
                                  curve: Curves.easeOut,
                                );
                                print(value.pageController.page);
                              } else {
                                _onFinish(context);
                              }
                            },
                            child: Text(
                              controller.isLastPage ? "Get Started" : "Next",
                            ),
                          ),
                        );
                      },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
