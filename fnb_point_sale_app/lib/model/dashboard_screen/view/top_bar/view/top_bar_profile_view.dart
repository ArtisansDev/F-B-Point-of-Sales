/*
 * Project      : fnb_point_sale_app
 * File         : top_bar_profile_view.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-08
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/top_bar_controller.dart';

class TopBarProfileView extends StatelessWidget {
  late TopBarController controller;

  TopBarProfileView({super.key}) {
    controller = Get.find<TopBarController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15.w,
      height: 6.w,
      alignment: Alignment.center,
      child: Row(
        children: [
          ///profile Image
          _profileImage(),
          SizedBox(
            width: 11.sp,
          ),

          ///Profile name
          Expanded(
            child: _profileNameView(),
          ),

          ///dropdown menu
          _profilePopUp()
        ],
      ),
    );
  }

  _profileImage() {
    return Container(
      width: 2.8.w,
      height: 2.8.w,
      decoration: const BoxDecoration(
        color: ColorConstants.appEditTextHint,
        shape: BoxShape.circle,
      ),
    );
  }

  _profileNameView() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Joe Doe  ',
            style: getText600(size: 11.sp),
          ),
          TextSpan(
            text: '(5206)',
            style: getTextRegular(
                size: 11.sp, colors: ColorConstants.appEditTextHint),
          ),
        ],
      ),
    );
  }

  Widget _profilePopUp() => PopupMenuButton<int>(
        padding: const EdgeInsets.all(0.0),
        itemBuilder: (context) => [
          PopupMenuItem(
            key: const Key('ProfileDetailsKey'),
            value: 0,
            child: Text(
              'Profile details',
              style:
                  getTextRegular(size: 12.5.sp, colors: ColorConstants.cAppColors),
            ),
          ),
          PopupMenuItem(
            value: 1,
            child: Text(
              'Logout',
              style:
              getTextRegular(size: 12.5.sp, colors: ColorConstants.cAppColors),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(
              'Exit',
              style:
              getTextRegular(size: 12.5.sp, colors: ColorConstants.cAppColors),
            ),
          ),
        ],
        offset: Offset(0, 10.h),
        tooltip: 'Menu',
        onSelected: (value) {
          controller.onSelectedProfileMenu(value);
        },
        child: Container(
          margin: EdgeInsets.only(
              top: 13.sp, left: 13.sp, right: 13.sp, bottom: 13.sp),
          child: const Icon(
            Icons.keyboard_arrow_down_outlined,
            color: ColorConstants.white,
          ),
        ),
      );
}
