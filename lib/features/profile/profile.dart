import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/auth/login.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/profile/controller/profile_controller.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProfileController(),
      child: Scaffold(
        appBar: AppBar(title: Text("Profile"), centerTitle: true),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSizes.h24,
              horizontal: AppSizes.w16,
            ),
            child: Consumer<ProfileController>(
              builder: (BuildContext context, controller, Widget? child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: AppSizes.r60,
                            backgroundColor: Colors.transparent,
                            backgroundImage: controller.getImageFile() != null
                                ? FileImage(controller.getImageFile()!)
                                      as ImageProvider
                                : const AssetImage("assets/images/logo.png"),
                          ),

                          GestureDetector(
                            onTap: () {
                              showImageSourceDialog(context);
                            },
                            child: Container(
                              height: AppSizes.w45,
                              width: AppSizes.h45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(Icons.camera_alt),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSizes.h8),
                    Center(
                      child: Text(
                        PreferencesManager().getString("user_email") ?? "",
                        style: TextStyle(
                          color: Color(0xff161F1B),
                          fontWeight: FontWeight.w400,
                          fontSize: AppSizes.sp16,
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizes.h16),
                    Text(
                      "Profile Info",
                      style: TextStyle(
                        fontSize: AppSizes.sp14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: AppSizes.h16),
                    _buildItem(
                      "Personal Info",
                      "assets/images/person_icon.svg",
                      () {},
                    ),
                    _buildItem("Language", "assets/images/country.svg", () {}),
                    _buildItem("Country", "assets/images/flag.svg", () {}),
                    _buildItem(
                      "Logout",
                      "assets/images/log_out.svg",
                      () async {
                        await PreferencesManager().clear();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen(),
                          ),
                        );
                      },
                      color: Color(0xffC53030),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void showImageSourceDialog(BuildContext context) {
    final controller = context.read<ProfileController>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            "Select Image Source",
            style: TextStyle(fontSize: AppSizes.sp16),
          ),

          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                controller.pickImage(ImageSource.camera);
              },
              padding: EdgeInsets.all(AppSizes.pw16),
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: AppSizes.pw8),
                  Text("Camera"),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.gallery);
              },
              padding: EdgeInsets.all(AppSizes.pw16),
              child: Row(
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: AppSizes.pw8),
                  Text("Galley"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildItem(
    String title,
    String path,
    Function onTap, {
    Color color = const Color(0xff161F1B),
  }) {
    return Column(
      children: [
        ListTile(
          onTap: () => onTap(),
          contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
          title: Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w400,
              fontSize: AppSizes.sp16,
            ),
          ),
          leading: CustomSvgPicture.withoutColor(path: path),
          trailing: CustomSvgPicture.withoutColor(
            path: "assets/images/r_row.svg",
            height: AppSizes.h16,
            width: AppSizes.w16,
          ),
        ),
        Divider(color: Colors.grey.shade500),
      ],
    );
  }
}
