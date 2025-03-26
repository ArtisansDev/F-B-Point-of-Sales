import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/check_box_create/coustom_check_box.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/payment_type_controller.dart';

class PaymentTypeScreen extends GetView<PaymentTypeController> {
  final OrderHistoryData mSelectOrderHistoryData;

  const PaymentTypeScreen({super.key, required this.mSelectOrderHistoryData});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PaymentTypeController(mSelectOrderHistoryData));
    controller.loadPaymentType();
    return Obx(
      () {
        return _paymentTypeView();
      },
    );
  }

  _paymentTypeView() {
    return FocusDetector(
      onVisibilityGained: () {},
      onVisibilityLost: () {},
      child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
              width: 30.w,
              padding: EdgeInsets.only(
                  top: 13.sp, bottom: 13.sp, left: 19.sp, right: 19.sp),
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.circular(11.sp),
                // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    // Shadow color
                    spreadRadius: 1,
                    // Spread radius
                    blurRadius: 3,
                    // Blur radius
                    offset: const Offset(
                        0, 0), // Shadow position (horizontal, vertical)
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.sp,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 13.sp, right: 11.sp),
                      child: Text(
                        'Select Payment Method',
                        style: getText600(
                          size: 13.sp,
                          colors: ColorConstants.cAppCancelDilogColour,
                        ),
                      )),
                  SizedBox(
                    height: 7.sp,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 10.sp,
                                  bottom: 10.sp,
                                  left: 11.sp,
                                  right: 11.sp),
                              decoration: BoxDecoration(
                                color: ColorConstants.cAppButtonLightColour,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.sp)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: Row(
                                      children: [
                                        selectCheckBox(
                                            size: 12.5.sp,
                                            isRound: true,
                                            isSelect: mGetAllPaymentTypeData
                                                    .isSelect ??
                                                false),
                                        SizedBox(width: 10.sp),
                                        Icon(
                                          Icons.payment,
                                          color:
                                              ColorConstants.cAppButtonColour,
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
                                            size: 12.sp,
                                            colors:
                                                ColorConstants.cAppButtonColour,
                                          ),
                                        ))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                      );
                    },
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 8.sp, right: 8.sp),
                      height: 19.5.sp,
                      child: TextInputWidget(
                        textColor: Colors.black,
                        placeHolder: sReason.tr,
                        controller: controller.reasonController.value,
                        errorText: null,
                        textInputType: TextInputType.emailAddress,
                        hintText: sReason.tr,
                        showFloatingLabel: false,
                        topPadding: 5.sp,
                        hintTextColor: ColorConstants.black.withOpacity(0.50),
                        hintTextSize: 11.sp,
                        textSize: 11.5.sp,
                        onFilteringTextInputFormatter: [
                          FilteringTextInputFormatter.allow(
                              RegExp(AppUtilConstants.patternStringAndSpace)),
                        ],
                      )),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: rectangleCornerButtonText600(
                        height: 19.5.sp,
                        textSize: 11.5.sp,
                        sDone.tr,
                        () {
                          controller.isCheck();
                        },
                      )),
                      SizedBox(
                        width: 15.sp,
                      ),
                      Expanded(
                          child: rectangleCornerButtonText600(
                        height: 19.5.sp,
                        textSize: 11.5.sp,
                        bgColor: Colors.white,
                        boderColor: ColorConstants.cAppButtonColour,
                        textColor: ColorConstants.cAppButtonColour,
                        sCancel.tr,
                        () {
                          Get.back();
                        },
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 13.sp,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
