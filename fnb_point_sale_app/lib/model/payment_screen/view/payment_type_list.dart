/*
 * Project      : fnb_point_sale_app
 * File         : table_summary_order_list.dart.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-20
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/check_box_create/coustom_check_box.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/payment_screen_controller.dart';

class PaymentTypeList extends StatelessWidget {
  late PaymentScreenController controller;

  PaymentTypeList({super.key}) {
    controller = Get.find<PaymentScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///title of order list
          Container(
              padding: EdgeInsets.only(left: 13.sp, right: 11.sp),
              child: Text(
                'Select Payment Method',
                style: getText600(
                  size: 10.sp,
                  colors: ColorConstants.cAppCancelDilogColour,
                ),
              )),

          ///Order listing
          Expanded(
            child: Container(
                margin: EdgeInsets.only(
                  top: 0.sp,
                  left: 8.sp,
                  right: 8.sp,
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: (controller.mGetAllPaymentTypeData ?? []).length,
                  itemBuilder: (BuildContext context, int index) {
                    GetAllPaymentTypeData mGetAllPaymentTypeData =
                        (controller.mGetAllPaymentTypeData ?? [])[index];
                    return GestureDetector(
                      onTap: () {
                        controller.isSelectPaymentType(index);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 11.sp, right: 11.sp, top: 10.sp),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 9,
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: 10.sp,
                                      bottom: 10.sp,
                                      left: 11.sp,
                                      right: 11.sp),
                                  decoration: BoxDecoration(
                                    color: ColorConstants.cAppButtonLightColour,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(11.sp),
                                      topRight: Radius.circular(11.sp),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      selectCheckBox(
                                          size: 12.5.sp,
                                          isRound: true,
                                          isSelect:
                                              mGetAllPaymentTypeData.isSelect ??
                                                  false),
                                      SizedBox(width: 10.sp),
                                      Icon(
                                        Icons.payment,
                                        color: ColorConstants.cAppButtonColour,
                                        size: 12.sp,
                                      ),
                                      SizedBox(
                                        width: 10.sp,
                                      ),
                                      Expanded(
                                          child: Text(
                                        mGetAllPaymentTypeData
                                                .paymentGatewayName ??
                                            '',
                                        maxLines: 1,
                                        style: getText500(
                                          size: 10.5.sp,
                                          colors:
                                              ColorConstants.cAppButtonColour,
                                        ),
                                      ))
                                    ],
                                  )),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${getDoubleValue(roundToNearestPossible(getDoubleValue(controller.mOrderPlace.value?.totalPrice.toStringAsFixed(2)))).toStringAsFixed(2)}',
                                      style: getText500(
                                          size: 10.5.sp,
                                          colors: ColorConstants.black),
                                    ))),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}
