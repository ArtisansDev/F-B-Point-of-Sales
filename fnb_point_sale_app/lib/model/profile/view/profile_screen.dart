import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileController());
    controller.getAllDetails();
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: Obx(() => Container(
              height: 65.h,
              width: 40.w,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(11.sp),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 40.w,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          top: 11.sp, bottom: 11.sp, left: 14.sp, right: 14.sp),
                      decoration: BoxDecoration(
                        color: ColorConstants.cAppButtonLightColour,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(11.sp),
                          topRight: Radius.circular(11.sp),
                        ),
                      ),
                      child: Text(
                        'Profile Details',
                        style: getText600(
                          size: 11.8.sp,
                          colors: ColorConstants.cAppButtonColour,
                        ),
                      )),

                  ///UserDetails
                  Container(
                      width: 40.w,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.only(top: 8.sp, left: 14.sp, right: 14.sp),
                      child: Text(
                        'User Details',
                        style: getText600(
                          size: 11.8.sp,
                          colors: ColorConstants.cAppButtonColour,
                        ),
                      )),
                  Container(
                      width: 40.w,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.only(top: 5.sp, left: 14.sp, right: 14.sp),
                      child: Text(
                        (controller
                                        .mConfigurationResponse
                                        .value
                                        .configurationData
                                        ?.loggedInUserDetails ??
                                    [])
                                .isEmpty
                            ? ""
                            : controller
                                    .mConfigurationResponse
                                    .value
                                    .configurationData
                                    ?.loggedInUserDetails
                                    ?.first
                                    .name ??
                                '',
                        style: getText500(
                          size: 11.8.sp,
                          colors: ColorConstants.appTextSalesHader,
                        ),
                      )),
                  Container(
                      width: 40.w,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.only(top: 5.sp, left: 14.sp, right: 14.sp),
                      child: Text(
                        (controller
                                        .mConfigurationResponse
                                        .value
                                        .configurationData
                                        ?.loggedInUserDetails ??
                                    [])
                                .isEmpty
                            ? ""
                            : controller
                                    .mConfigurationResponse
                                    .value
                                    .configurationData
                                    ?.loggedInUserDetails
                                    ?.first
                                    .email ??
                                '',
                        style: getText500(
                          size: 11.8.sp,
                          colors: ColorConstants.appTextSalesHader,
                        ),
                      )),

                  ///Restaurant
                  Container(
                      width: 40.w,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.only(top: 8.sp, left: 14.sp, right: 14.sp),
                      child: Text(
                        'Restaurant Details',
                        style: getText600(
                          size: 11.8.sp,
                          colors: ColorConstants.cAppButtonColour,
                        ),
                      )),

                  Container(
                      width: 40.w,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.only(top: 5.sp, left: 14.sp, right: 14.sp),
                      child: Text(
                        controller
                                .mConfigurationResponse
                                .value
                                .configurationData
                                ?.restaurantData
                                ?.first
                                .restaurantName ??
                            '',
                        style: getText500(
                          size: 11.8.sp,
                          colors: ColorConstants.appTextSalesHader,
                        ),
                      )),
                  Container(
                      width: 40.w,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.only(top: 5.sp, left: 14.sp, right: 14.sp),
                      child: Text(
                        controller
                                .mConfigurationResponse
                                .value
                                .configurationData
                                ?.restaurantData
                                ?.first
                                .contactEmail ??
                            '',
                        style: getText500(
                          size: 11.8.sp,
                          colors: ColorConstants.appTextSalesHader,
                        ),
                      )),
                  Container(
                      width: 40.w,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.only(top: 5.sp, left: 14.sp, right: 14.sp),
                      child: Text(
                        controller
                                .mConfigurationResponse
                                .value
                                .configurationData
                                ?.restaurantData
                                ?.first
                                .contactNumber ??
                            '',
                        style: getText500(
                          size: 11.8.sp,
                          colors: ColorConstants.appTextSalesHader,
                        ),
                      )),
                  Container(
                      width: 40.w,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.only(top: 5.sp, left: 14.sp, right: 14.sp),
                      child: Text(
                        controller
                                .mConfigurationResponse
                                .value
                                .configurationData
                                ?.restaurantData
                                ?.first
                                .address ??
                            '',
                        style: getText500(
                          size: 11.8.sp,
                          colors: ColorConstants.appTextSalesHader,
                        ),
                      )),

                  ///branch
                  Container(
                      width: 40.w,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.only(top: 8.sp, left: 14.sp, right: 14.sp),
                      child: Text(
                        'Branch Details',
                        style: getText600(
                          size: 11.8.sp,
                          colors: ColorConstants.cAppButtonColour,
                        ),
                      )),

                  Container(
                      width: 40.w,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.only(top: 5.sp, left: 14.sp, right: 14.sp),
                      child: Text(
                        controller
                                .mConfigurationResponse
                                .value
                                .configurationData
                                ?.branchData
                                ?.first
                                .branchName ??
                            '',
                        style: getText500(
                          size: 11.8.sp,
                          colors: ColorConstants.appTextSalesHader,
                        ),
                      )),
                  Container(
                      width: 40.w,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.only(top: 5.sp, left: 14.sp, right: 14.sp),
                      child: Text(
                        controller.mConfigurationResponse.value
                                .configurationData?.branchData?.first.email ??
                            '',
                        style: getText500(
                          size: 11.8.sp,
                          colors: ColorConstants.appTextSalesHader,
                        ),
                      )),
                  Container(
                      width: 40.w,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.only(top: 5.sp, left: 14.sp, right: 14.sp),
                      child: Text(
                        controller
                                .mConfigurationResponse
                                .value
                                .configurationData
                                ?.branchData
                                ?.first
                                .mobileNumber ??
                            '',
                        style: getText500(
                          size: 11.8.sp,
                          colors: ColorConstants.appTextSalesHader,
                        ),
                      )),
                  Container(
                      width: 40.w,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.only(top: 5.sp, left: 14.sp, right: 14.sp),
                      child: Text(
                        controller
                                .mConfigurationResponse
                                .value
                                .configurationData
                                ?.branchData
                                ?.first
                                .branchAddress ??
                            '',
                        style: getText500(
                          size: 11.8.sp,
                          colors: ColorConstants.appTextSalesHader,
                        ),
                      )),

                  ///counter
                  Container(
                      width: 40.w,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.only(top: 8.sp, left: 14.sp, right: 14.sp),
                      child: Text(
                        'Counter Details',
                        style: getText600(
                          size: 11.8.sp,
                          colors: ColorConstants.cAppButtonColour,
                        ),
                      )),
                  Container(
                      width: 40.w,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.only(top: 5.sp, left: 14.sp, right: 14.sp),
                      child: Text(
                        controller
                                .mConfigurationResponse
                                .value
                                .configurationData
                                ?.counterData
                                ?.first
                                .counterName ??
                            '',
                        style: getText500(
                          size: 11.8.sp,
                          colors: ColorConstants.appTextSalesHader,
                        ),
                      )),

                  const Expanded(child: SizedBox()),

                  ///button
                  Container(
                      margin: EdgeInsets.only(
                          left: 35.sp, right: 35.sp, top: 12.sp, bottom: 13.sp),
                      child: rectangleCornerButtonText600(
                        height: 19.5.sp,
                        textSize: 11.7.sp,
                        sClose.tr,
                        () {
                          Get.back();
                        },
                      )),
                ],
              ),
            )));
  }
}
