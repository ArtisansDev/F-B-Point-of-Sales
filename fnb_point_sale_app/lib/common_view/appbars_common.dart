import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class AppBarsCommon {
  AppBarsCommon._();

  static PreferredSizeWidget appNoBar() {
    return PreferredSize(
        preferredSize: Size.fromHeight(0.sp),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: ColorConstants.primaryBackgroundColor,

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: ColorConstants.primaryBackgroundColor,
        ));
  }

  static PreferredSizeWidget appBar({
    double dTitleSpacing = 0.0,
    Color backgroundColor = ColorConstants.cAppColors,
    Color iconColor = Colors.black,
    String title = "",
    Function? onClick,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(26.sp),
      child: AppBar(
        toolbarHeight: 26.sp,
        titleSpacing: dTitleSpacing,
        bottomOpacity: 0.6,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 20.sp,
            ),
            // Image.asset(
            //   ImageAssetsConstants.appLogo,
            //   fit: BoxFit.fitWidth,
            //   height: 25.5.sp,
            //   width: 25.5.sp,
            // ),
            SizedBox(
              width: 13.sp,
            ),
            Text(
              title,
              style: getText600(colors: Colors.black, size: 18.5.sp),
            ),
            Container(
              width: 50.sp,
            )
          ],
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(
          color: Colors.black, //// change your color here
        ),
        backgroundColor: ColorConstants.primaryBackgroundColor,
      ),
    );
  }

  static PreferredSizeWidget appBarNoBack({
    double dTitleSpacing = 0.0,
    Color backgroundColor = ColorConstants.cAppColors,
    Color iconColor = Colors.black,
    String title = "",
    Function? onClick,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(26.sp),
      child: AppBar(
        toolbarHeight: 26.sp,
        titleSpacing: dTitleSpacing,
        bottomOpacity: 0.6,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 13.sp,
            ),
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios_new),
            ),
            SizedBox(
              width: 10.sp,
            ),
            Image.asset(
              ImageAssetsConstants.appLogo,
              fit: BoxFit.fitWidth,
              height: 25.5.sp,
              width: 25.5.sp,
            ),
            SizedBox(
              width: 13.sp,
            ),
            Text(
              title,
              style: getText600(colors: Colors.black, size: 18.sp),
            ),
            Container(
              width: 50.sp,
            )
          ],
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(
          color: Colors.black, //// change your color here
        ),
        backgroundColor: ColorConstants.primaryBackgroundColor,
      ),
    );
  }

  static PreferredSizeWidget appBarNotification({
    double dTitleSpacing = 0.0,
    Color backgroundColor = ColorConstants.cAppColors,
    Color iconColor = Colors.black,
    String title = "",
    Function? onClick,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(26.sp),
      child: AppBar(
        toolbarHeight: 26.sp,
        titleSpacing: dTitleSpacing,
        bottomOpacity: 0.6,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 18.sp,
            ),
            Image.asset(
              ImageAssetsConstants.appLogo,
              fit: BoxFit.fitWidth,
              height: 25.5.sp,
              width: 25.5.sp,
            ),
            SizedBox(
              width: 13.sp,
            ),
            Expanded(
              child: Text(
                title,
                style: getText600(colors: Colors.black, size: 18.sp),
              ),
            ),
            GestureDetector(
              onTap: () {
                onClick!("notification");
              },
              // child: Image.asset(
              //   ImageAssetsConstants.notification,
              //   fit: BoxFit.fitWidth,
              //   height: 25.5.sp,
              //   width: 25.5.sp,
              // ),
            ),
            SizedBox(
              width: 13.sp,
            ),
          ],
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(
          color: Colors.black, //// change your color here
        ),
        backgroundColor: ColorConstants.primaryBackgroundColor,
      ),
    );
  }
}
