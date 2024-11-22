import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

import '../controller/cash_model/cash_model.dart';
import '../controller/open_cash_drawer_screen_controller.dart';

class CashCalculateScreen extends StatelessWidget {
  late OpenCashDrawerScreenController controller;

  CashCalculateScreen({super.key}) {
    controller = Get.find<OpenCashDrawerScreenController>();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      margin: EdgeInsets.only(left: 13.sp, top: 12.sp, right: 13.sp),
      padding: EdgeInsets.only(bottom: 12.sp),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstants.primaryBackgroundColor,
        // color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(8.sp),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                left: 10.sp, top: 11.sp, right: 5.sp, bottom: 11.sp),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Denomination (RM)',
                      style: getText500(
                          size: 10.5.sp,
                          colors: ColorConstants.black),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Quantity',
                      style: getText500(
                          size: 10.5.sp,
                          colors: ColorConstants.black),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Total',
                      style: getText500(
                          size: 10.5.sp,
                          colors: ColorConstants.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemCount: controller.mCashModelList.value.length,
            itemBuilder: (BuildContext context, int index) {
              CashModel mCashModel =
              controller.mCashModelList.value[index];
              return Container(
                padding: EdgeInsets.only(
                    left: 10.sp,
                    top: 5.sp,
                    right: 5.sp,
                    bottom: 5.sp),
                child: Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          getDoubleValue(mCashModel.amount)
                              .toStringAsFixed(2),
                          style: getTextRegular(
                              size: 11.sp,
                              colors: ColorConstants.black),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                            margin: EdgeInsets.only(
                                left: 8.sp, right: 8.sp),
                            height: 16.5.sp,
                            child: TextInputWidget(
                              placeHolder: '0',
                              controller:
                              mCashModel.qtyController.value,
                              errorText: null,
                              textInputType:
                              TextInputType.emailAddress,
                              hintText: '0',
                              hintTextColor: ColorConstants.black
                                  .withOpacity(0.50),
                              onTextChange: (value){
                                controller.onTextQtyChange(index);
                              },
                              showFloatingLabel: false,
                              topPadding: 5.sp,
                              leftPadding: 10.sp,
                              hintTextSize: 11.sp,
                              textSize: 11.sp,
                              onFilteringTextInputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(AppUtilConstants
                                        .patternOnlyNumber)),
                              ],
                            )),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          getDoubleValue(mCashModel.totalAmount)
                              .toStringAsFixed(2),
                          style: getTextRegular(
                              size: 11.sp,
                              colors: ColorConstants.black),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ),);
  }
}
