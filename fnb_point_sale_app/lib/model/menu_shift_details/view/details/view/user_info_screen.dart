import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/details_screen_controller.dart';

class UserInfoScreen extends StatelessWidget {
  late DetailsScreenController controller;

  UserInfoScreen({super.key}) {
    controller = Get.find<DetailsScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 13.sp, right: 13.sp, top: 12.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sUserInfo.tr,
                  style: getText500(
                      size: 11.sp, colors: ColorConstants.cAppButtonColour),
                ),
                SizedBox(
                  width: 13.w,
                  child: rectangleCornerButtonText600(
                    sImage: ImageAssetsConstants.appPrint,
                    textSize: 10.5.sp,
                    height: 18.sp,
                    sPrintOpeningBalance.tr,
                    () {},
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 13.sp, right: 13.sp, top: 12.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(11.sp),
                  decoration: BoxDecoration(
                    color: ColorConstants.cShiftDetailsColour1,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.sp),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sCounter.tr,
                        style: getText500(
                            size: 11.sp, colors: ColorConstants.black),
                      ),
                      SizedBox(
                        height: 8.sp,
                      ),
                      Text(
                        controller
                                .mShiftDetailsController
                                .mConfigurationResponse
                                .value
                                .configurationData
                                ?.counterData
                                ?.first
                                .counterName ??
                            '',
                        style: getText300(
                            size: 11.sp, colors: ColorConstants.black),
                      ),
                    ],
                  ),
                )),
                SizedBox(
                  width: 10.sp,
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(11.sp),
                  decoration: BoxDecoration(
                    color: ColorConstants.cShiftDetailsColour2,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.sp),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sCashier.tr,
                        style: getText500(
                            size: 11.sp, colors: ColorConstants.black),
                      ),
                      SizedBox(
                        height: 8.sp,
                      ),
                      Text(
                        'FB-Cashier 01',
                        style: getText300(
                            size: 11.sp, colors: ColorConstants.black),
                      ),
                    ],
                  ),
                )),
                SizedBox(
                  width: 10.sp,
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(11.sp),
                  decoration: BoxDecoration(
                    color: ColorConstants.cShiftDetailsColour3,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.sp),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sBusinessDay.tr,
                        style: getText500(
                            size: 11.sp, colors: ColorConstants.black),
                      ),
                      SizedBox(
                        height: 8.sp,
                      ),
                      Text(
                        '2024-11-18  10:13:51',
                        style: getText300(
                            size: 11.sp, colors: ColorConstants.black),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
