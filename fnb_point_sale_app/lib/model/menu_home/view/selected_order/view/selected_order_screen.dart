import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_app/model/menu_home/view/selected_order/view/selected_order_bottom_view.dart';
import 'package:fnb_point_sale_app/model/menu_home/view/selected_order/view/selected_order_list.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/selected_order_controller.dart';

class SelectedOrderScreen extends GetView<SelectedOrderController> {
  const SelectedOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SelectedOrderController());

    return FocusDetector(
        onVisibilityGained: () {
          controller.onOrderPlaceAnotherPage();
        },
        onVisibilityLost: () {
          if (Get.isRegistered<SelectedOrderController>()) {
            Get.delete<SelectedOrderController>();
          }
        },
        child: Obx(
          () => Container(
            height: 100.h,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(
                top: 11.sp, left: 5.5.sp, right: 8.sp, bottom: 8.sp),
            decoration: BoxDecoration(
              color: ColorConstants.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8.sp),
              ),
            ),
            child: Column(
              children: [
                ///select order title
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(top: 8.sp, left: 8.sp, right: 8.sp),
                    padding: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                      color: ColorConstants.cAppButtonLightColour,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.sp),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          ImageAssetsConstants.selectOrder,
                          fit: BoxFit.fitHeight,
                          height: 16.5.sp,
                        ),
                        SizedBox(
                          width: 8.sp,
                        ),
                        Expanded(
                            child: Text(
                          sOrderDetails.tr,
                          style: getText500(
                              size: 11.5.sp,
                              colors: ColorConstants.cAppButtonColour),
                        )),
                        Visibility(
                          visible: controller.mOrderPlace.value != null &&
                              (controller.mOrderPlace.value?.cartItem ?? [])
                                  .isNotEmpty &&
                              controller.placeOrder.value,
                          child: GestureDetector(
                            onTap: () {
                              controller.onHoldSale();
                            },
                            child: Container(
                                margin: EdgeInsets.only(right: 8.sp),
                                height: 16.5.sp,
                                width: 6.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorConstants.cAppButtonColour,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.sp)),
                                ),
                                child: Text(
                                  'HOLD',
                                  style: getText500(size: 10.5.sp),
                                )),
                          ),
                        ),
                        Visibility(
                          visible: controller.mOrderPlace.value != null &&
                              (controller.mOrderPlace.value?.cartItem ?? [])
                                  .isNotEmpty,
                          child: GestureDetector(
                            onTap: () {
                              controller.onCancelSale();
                            },
                            child: Container(
                                margin: EdgeInsets.only(right: 0.sp),
                                height: 16.5.sp,
                                width: 6.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorConstants.cAppButtonColour,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.sp)),
                                ),
                                child: Text(
                                  'CANCEL',
                                  style: getText500(size: 10.5.sp),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                Visibility(
                    visible: controller.mOrderPlace.value != null,
                    child: Column(
                      children: [
                        ///table no & order number
                        Container(
                          margin: EdgeInsets.only(
                              top: 10.sp,
                              left: 8.sp,
                              right: 8.sp,
                              bottom: 8.sp),
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                            color: ColorConstants.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.sp),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Row(
                                children: [
                                  Text(
                                    'Order No:',
                                    style: getText300(
                                        size: 11.5.sp,
                                        colors: ColorConstants.black),
                                  ),
                                  SizedBox(
                                    width: 8.sp,
                                  ),
                                  Text(
                                    controller.mOrderPlace.value?.sOrderNo ??
                                        '',
                                    style: getText500(
                                        size: 11.5.sp,
                                        colors: ColorConstants.black),
                                  ),
                                ],
                              )),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  if (!controller.isOrderHistory.value) {
                                    controller.selectTable();
                                  }
                                },
                                child: Container(
                                  height: 18.sp,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.sp),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.15),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ], // use instead of BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        sSeatingNo.tr,
                                        style: getText300(
                                            size: 11.5.sp,
                                            colors: ColorConstants.black),
                                      ),
                                      SizedBox(
                                        width: 8.sp,
                                      ),
                                      Text(
                                        controller.mOrderPlace.value?.tableNo ??
                                            '',
                                        style: getText500(
                                            size: 11.5.sp,
                                            colors: ColorConstants.black),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          height: 3.sp,
                          margin: EdgeInsets.only(left: 8.sp, right: 8.sp),
                          color: Colors.grey.shade300,
                        ),

                        ///date and time & Attendant
                        Container(
                          margin: EdgeInsets.all(
                            8.sp,
                          ),
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                            color: ColorConstants.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.sp),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  controller.mOrderPlace.value?.dateTime ?? '',
                                  style: getText500(
                                      size: 11.5.sp,
                                      colors: ColorConstants.black),
                                ),
                              ),
                              const Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Text(
                                  //   'Attendant:',
                                  //   style: getText300(
                                  //       size: 11.5.sp,
                                  //       colors: ColorConstants.black),
                                  // ),
                                  // SizedBox(
                                  //   width: 8.sp,
                                  // ),
                                  // Text(
                                  //   'Denny',
                                  //   style: getText500(
                                  //       size: 11.5.sp,
                                  //       colors: ColorConstants.black),
                                  // ),
                                ],
                              )),
                            ],
                          ),
                        ),
                        Container(
                          height: 3.sp,
                          margin: EdgeInsets.only(left: 8.sp, right: 8.sp),
                          color: Colors.grey.shade300,
                        ),
                      ],
                    )),

                ///OrderList
                Expanded(child: SelectedOrderList()),

                ///BottomView
                SelectedOrderBottomView()
              ],
            ),
          ),
        ));
  }
}
