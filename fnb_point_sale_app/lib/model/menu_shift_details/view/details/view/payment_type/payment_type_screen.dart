import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/update_balance/shift_details/payment_type_data.dart';
import 'package:fnb_point_sale_base/data/mode/update_balance/shift_details/shift_details_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controller/details_screen_controller.dart';

class PaymentTypeScreen extends StatelessWidget {
  late DetailsScreenController controller;

  PaymentTypeScreen({super.key}) {
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
                  sPaymentType.tr,
                  style: getText500(
                      size: 11.sp, colors: ColorConstants.cAppButtonColour),
                ),
                SizedBox(
                  width: 13.w,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 13.sp, right: 13.sp, top: 10.sp),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Name',
                    style:
                        getText500(size: 11.sp, colors: ColorConstants.black),
                  ),
                ),
                SizedBox(
                  width: 7.sp,
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Total Count',
                          style: getText500(
                              size: 11.sp, colors: ColorConstants.black),
                        ))),
                SizedBox(
                  width: 7.sp,
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Refund Count',
                          style: getText500(
                              size: 11.sp, colors: ColorConstants.black),
                        ))),
                SizedBox(
                  width: 7.sp,
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Total Amount',
                          style: getText500(
                              size: 11.sp, colors: ColorConstants.black),
                        ))),
                SizedBox(
                  width: 7.sp,
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Refund Amount',
                          style: getText500(
                              size: 11.sp, colors: ColorConstants.black),
                        ))),
                SizedBox(
                  width: 7.sp,
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Net Amount',
                          style: getText500(
                              size: 11.sp, colors: ColorConstants.black),
                        )))
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 13.sp, right: 13.sp, top: 10.sp),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (controller.mShiftDetailsController
                              .mShiftDetailsResponse.value.data?.paymentType ??
                          [])
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    PaymentTypeData mPaymentType = (controller
                            .mShiftDetailsController
                            .mShiftDetailsResponse
                            .value
                            .data
                            ?.paymentType ??
                        [])[index];
                    return Container(
                      margin: EdgeInsets.all(5.sp),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(mPaymentType.name ?? ''),
                          ),
                          SizedBox(
                            width: 7.sp,
                          ),
                          Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${mPaymentType.totalCount ?? 0}',
                                ),
                              )),
                          SizedBox(
                            width: 7.sp,
                          ),
                          Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${mPaymentType.refundCount ?? 0}',
                                ),
                              )),
                          SizedBox(
                            width: 7.sp,
                          ),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      '${controller.mShiftDetailsController.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''}  ${getNumberFormat(getDoubleValue(mPaymentType.netAmount ?? 0))}'))),
                          SizedBox(
                            width: 7.sp,
                          ),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      '${controller.mShiftDetailsController.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''}  ${getNumberFormat(getDoubleValue(mPaymentType.netAmount ?? 0))}'))),
                          SizedBox(
                            width: 7.sp,
                          ),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      '${controller.mShiftDetailsController.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''}  ${getNumberFormat(getDoubleValue(mPaymentType.netAmount ?? 0))}')))
                        ],
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
