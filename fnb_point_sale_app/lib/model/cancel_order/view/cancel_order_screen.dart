import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/cancel_order_controller.dart';
import 'cancel_order_list.dart';

class CancelOrderScreen extends GetView<CancelOrderController> {
  const CancelOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CancelOrderController());
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: Container(
          height: 70.h,
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
                  padding: EdgeInsets.only(
                      top: 11.sp, bottom: 11.sp, left: 14.sp, right: 14.sp),
                  decoration: BoxDecoration(
                    color: ColorConstants.cAppButtonLightColour,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(11.sp),
                      topRight: Radius.circular(11.sp),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Order #: 25897',
                        style: getText600(
                          size: 11.8.sp,
                          colors: ColorConstants.cAppButtonColour,
                        ),
                      )),
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Dine-In',
                          style: getText600(
                            size: 11.7.sp,
                            colors: ColorConstants.cAppCancelDilogColour,
                          ),
                        ),
                      ))
                    ],
                  )),
              Expanded(child: CancelOrderList()),
              Container(
                  margin: EdgeInsets.only(
                      top: 11.sp, bottom: 11.sp, left: 13.sp, right: 13.sp),
                  padding: EdgeInsets.only(
                      top: 11.sp, bottom: 11.sp, left: 14.sp, right: 14.sp),
                  decoration: BoxDecoration(
                    color: ColorConstants.cAppCancelDilogBackgroundColour,
                    borderRadius: BorderRadius.all(
                      Radius.circular(3.sp),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                'Sub Total',
                                style: getText600(
                                  size: 11.sp,
                                  colors: ColorConstants.cAppCancelDilogColour,
                                ),
                              )),
                          Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'RM 80.00',
                                  style: getText600(
                                    size: 11.sp,
                                    colors: ColorConstants.cAppCancelDilogColour,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      SizedBox(height: 5.sp,),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                'Tax 5%',
                                style: getText600(
                                  size: 11.sp,
                                  colors: ColorConstants.cAppCancelDilogColour,
                                ),
                              )),
                          Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'RM 4.00',
                                  style: getText600(
                                    size: 11.sp,
                                    colors: ColorConstants.cAppCancelDilogColour,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.sp,bottom: 10.sp),
                        width: double.infinity,
                        height: 3.sp,
                        color: ColorConstants.cAppCancelDilogDeviderColour,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                'Total Amount',
                                style: getText600(
                                  size: 11.5.sp,
                                  colors: ColorConstants.cAppCancelDilogColour,
                                ),
                              )),
                          Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'RM 84.00',
                                  style: getText600(
                                    size: 11.5.sp,
                                    colors: ColorConstants.cAppCancelDilogColour,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ],
                  )),
              ///remark
              Container(
                  margin: EdgeInsets.only(left: 13.sp, right: 13.sp),
                  child: TextInputWidget(
                    placeHolder: sReasonCancel.tr,
                    controller: controller.remarkController.value,
                    errorText: null,
                    textInputType: TextInputType.emailAddress,
                    hintText: sReasonCancel.tr,
                    showFloatingLabel: false,
                    topPadding: 12.sp,
                    maxLines: 4,
                    hintTextSize: 11.sp,
                    textSize: 11.5.sp,
                    hintTextColor: ColorConstants.black.withOpacity(0.80),
                    onFilteringTextInputFormatter: [
                      FilteringTextInputFormatter.allow(
                          RegExp(AppUtilConstants.patternOnlyString)),
                    ],
                  )),

              ///cancel button
              Container(
                  margin: EdgeInsets.only(left: 13.sp, right: 13.sp, top: 12.sp,bottom: 13.sp),
                  child: rectangleCornerButtonText600(
                    height: 19.5.sp,
                    textSize: 11.7.sp,
                    sCancelOrder.tr,
                        () {
                      controller.onCancel();
                        },
                  )),
            ],
          ),
        ));
  }
}
