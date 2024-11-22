import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_app/model/menu_home/view/selected_order/view/selected_order_list.dart';
import 'package:fnb_point_sale_app/model/menu_table/view/table_view/table_summary/view/table_summary_order_list.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/table_summary_controller.dart';

class TableSummaryOrderScreen extends GetView<TableSummaryController> {
  const TableSummaryOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TableSummaryController());
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: Container(
          height: 100.h,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: ColorConstants.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8.sp),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///select order title
                Container(
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
                        sTableSummary.tr,
                        style: getText500(
                            size: 11.5.sp,
                            colors: ColorConstants.cAppButtonColour),
                      )),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            margin: EdgeInsets.only(left: 8.sp),
                            padding: EdgeInsets.all(8.sp),
                            decoration: BoxDecoration(
                              color: ColorConstants.cAppButtonColour,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.sp),
                              ),
                            ),
                            child: Icon(
                              Icons.clear,
                              color: ColorConstants.white,
                              size: 12.5.sp,
                            )),
                      )
                    ],
                  ),
                ),

                ///table no & order number
                Container(
                  margin: EdgeInsets.only(
                      top: 10.sp, left: 8.sp, right: 8.sp, bottom: 8.sp),
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
                                size: 11.5.sp, colors: ColorConstants.black),
                          ),
                          SizedBox(
                            width: 8.sp,
                          ),
                          Text(
                            '0123456789',
                            style: getText500(
                                size: 11.5.sp, colors: ColorConstants.black),
                          ),
                        ],
                      )),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Table No:',
                            style: getText300(
                                size: 11.5.sp, colors: ColorConstants.black),
                          ),
                          SizedBox(
                            width: 8.sp,
                          ),
                          Text(
                            '15',
                            style: getText500(
                                size: 11.5.sp, colors: ColorConstants.black),
                          ),
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
                          '10-10-2024  09:45',
                          style: getText500(
                              size: 11.5.sp, colors: ColorConstants.black),
                        ),
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Attendant:',
                            style: getText300(
                                size: 11.5.sp, colors: ColorConstants.black),
                          ),
                          SizedBox(
                            width: 8.sp,
                          ),
                          Text(
                            'Denny',
                            style: getText500(
                                size: 11.5.sp, colors: ColorConstants.black),
                          ),
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

                ///OrderList
                TableSummaryOrderList(),

                ///Sub Total
                Container(
                    margin: EdgeInsets.all(
                      8.sp,
                    ),
                    padding: EdgeInsets.all(8.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sSubTotal.tr,
                          style: getTextRegular(
                              size: 12.sp,
                              colors: ColorConstants.cAppTaxColour),
                        ),
                        Text(
                          'RM 80.00',
                          style: getTextRegular(
                              size: 12.sp,
                              colors: ColorConstants.cAppTaxColour),
                        ),
                      ],
                    )),
                Container(
                  height: 3.sp,
                  margin: EdgeInsets.only(left: 8.sp, right: 8.sp),
                  color: Colors.grey.shade300,
                ),

                ///Tax
                Container(
                    margin: EdgeInsets.all(
                      8.sp,
                    ),
                    padding: EdgeInsets.all(8.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${sTax.tr}+ (5%)',
                          style: getTextRegular(
                              size: 12.sp,
                              colors: ColorConstants.cAppTaxColour),
                        ),
                        Text(
                          'RM 4.00',
                          style: getTextRegular(
                              size: 12.sp,
                              colors: ColorConstants.cAppTaxColour),
                        ),
                      ],
                    )),
                Container(
                  height: 3.sp,
                  margin: EdgeInsets.only(left: 8.sp, right: 8.sp),
                  color: Colors.grey.shade300,
                ),

                ///total
                Container(
                    margin: EdgeInsets.all(
                      8.sp,
                    ),
                    padding: EdgeInsets.only(
                        left: 8.sp, right: 8.sp, top: 5.sp, bottom: 5.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sTotal.tr,
                          style: getText500(
                              size: 13.sp,
                              colors: ColorConstants.cAppButtonColour),
                        ),
                        Text(
                          'RM 84.00',
                          style: getText500(
                              size: 13.sp,
                              colors: ColorConstants.cAppButtonColour),
                        ),
                      ],
                    )),
                Container(
                  height: 3.sp,
                  margin:
                      EdgeInsets.only(left: 8.sp, right: 8.sp, bottom: 12.sp),
                  color: Colors.grey.shade300,
                ),

                ///remark
                Container(
                    margin: EdgeInsets.only(left: 8.sp, right: 8.sp),
                    height: 19.5.sp,
                    child: TextInputWidget(
                      placeHolder: sRemark.tr,
                      controller: controller.remarkController.value,
                      errorText: null,
                      textInputType: TextInputType.emailAddress,
                      hintText: sRemark.tr,
                      hintTextColor: ColorConstants.black.withOpacity(0.50),
                      showFloatingLabel: false,
                      topPadding: 5.sp,
                      hintTextSize: 11.sp,
                      textSize: 11.5.sp,
                      onFilteringTextInputFormatter: [
                        FilteringTextInputFormatter.allow(
                            RegExp(AppUtilConstants.patternOnlyString)),
                      ],
                    )),

                ///button Place Order
                Container(
                    margin: EdgeInsets.only(left: 8.sp, right: 8.sp, top: 8.sp),
                    child: rectangleCornerButtonText600(
                      height: 19.5.sp,
                      textSize: 11.5.sp,
                      sPlaceOrder.tr,
                      () {},
                    )),

                ///button Pay and Invoice
                Container(
                    margin: EdgeInsets.only(left: 8.sp, right: 8.sp, top: 8.sp,bottom: 8.sp),
                    child: rectangleCornerButtonText600(
                      boderColor: ColorConstants.cAppButtonInviceColour,
                      bgColor: ColorConstants.cAppButtonInviceColour,
                      textColor: ColorConstants.cAppTextInviceColour,
                      height: 19.5.sp,
                      textSize: 11.5.sp,
                      sPayInvoice.tr,
                      () {
                        controller.onPayment();
                      },
                    )),
              ],
            ),
          ),
        ));
  }
}
