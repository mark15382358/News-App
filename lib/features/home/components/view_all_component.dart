import 'package:flutter/material.dart';
import 'package:news_app/core/constant/app_sizes.dart';

class ViewAllComponent extends StatelessWidget {
  ViewAllComponent({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
  });
  final String title;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {},
            child: Text(
              "$title",
              style: TextStyle(
                fontSize: AppSizes.sp16,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              "View all ",
              style: TextStyle(
                fontSize: AppSizes.sp16,
                fontWeight: FontWeight.w400,
                color: color,
                decoration: TextDecoration.underline,
                decorationColor: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
