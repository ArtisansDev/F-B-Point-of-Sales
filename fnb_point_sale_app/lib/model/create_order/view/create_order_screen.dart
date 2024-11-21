import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_app/model/create_order/view/dine_in/dine_in_screen.dart';
import 'package:fnb_point_sale_app/model/create_order/view/take_away/take_away_screen.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/create_order_controller.dart';

class CreateOrderScreen extends GetView<CreateOrderController> {
  const CreateOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateOrderController());
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: Obx(() => Container(
              height: controller.isDineIn.value ? 67.h : 60.h,
              width: 25.w,
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
                      width: 25.w,
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
                        'Order #: 25897',
                        style: getText600(
                          size: 11.8.sp,
                          colors: ColorConstants.cAppButtonColour,
                        ),
                      )),

                  ///select Dine-In or Take Away
                  Container(
                    margin: EdgeInsets.all(12.sp),
                    padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            controller.isDineIn.value = false;
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 14.sp,
                                  height: 14.sp,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // Background color
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        // Shadow color
                                        spreadRadius: 2,
                                        // Spread area
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.all(6.sp),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: controller.isDineIn.value
                                          ? Colors.transparent
                                          : ColorConstants.cAppButtonColour,
                                      // Background color
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.sp,
                                ),
                                Text(
                                  sTakeAway.tr,
                                  style: getText500(
                                    size: 11.sp,
                                    colors:
                                        ColorConstants.black.withOpacity(0.8),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            controller.isDineIn.value = true;
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 14.sp,
                                  height: 14.sp,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // Background color
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        // Shadow color
                                        spreadRadius: 2,
                                        // Spread area
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.all(6.sp),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: controller.isDineIn.value
                                          ? ColorConstants.cAppButtonColour
                                          : Colors.transparent,
                                      // Background color
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.sp,
                                ),
                                Text(
                                  sDineIn.tr,
                                  style: getText500(
                                    size: 11.sp,
                                    colors:
                                        ColorConstants.black.withOpacity(0.8),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),

                  Expanded(
                      child: controller.isDineIn.value
                          ? DineInScreen()
                          : TakeAwayScreen()),

                  ///button
                  Container(
                      margin: EdgeInsets.only(
                          left: 13.sp, right: 13.sp, top: 12.sp, bottom: 13.sp),
                      child: rectangleCornerButtonText600(
                        height: 19.5.sp,
                        textSize: 11.7.sp,
                        controller.isDineIn.value
                            ? sReserveNow.tr
                            : sCreateOrder.tr,
                        () {
                          controller.onCreateOrder();
                        },
                      )),
                ],
              ),
            )));
  }
}
