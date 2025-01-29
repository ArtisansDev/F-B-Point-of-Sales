import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/menu_table/view/table_view/item_summary/view/table_item_summary_bottom_view.dart';
import 'package:fnb_point_sale_app/model/menu_table/view/table_view/item_summary/view/table_item_summary_order_list.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/utils/date_time_utils.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/table_item_summary_controller.dart';

class TableItemSummaryOrderScreen extends GetView<TableItemSummaryController> {
  final OrderHistoryData mOrderData;
  final int index;

  const TableItemSummaryOrderScreen(this.mOrderData, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TableItemSummaryController(mOrderData, index));
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
              Visibility(
                  visible: controller.mOrderPlace.value != null,
                  child: Column(
                    children: [
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                  Expanded(
                                      child: Text(
                                    controller.mOrderPlace.value
                                            .trackingOrderID ??
                                        '',
                                    style: getText500(
                                        size: 11.5.sp,
                                        colors: ColorConstants.black),
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.sp,
                            ),
                            Expanded(
                                flex: 3,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${sSeatingNo.tr}:',
                                      style: getText300(
                                          size: 11.5.sp,
                                          colors: ColorConstants.black),
                                    ),
                                    SizedBox(
                                      width: 7.sp,
                                    ),
                                    Expanded(
                                        child: Text(
                                      controller.mOrderPlace.value.tableNo ??
                                          '',
                                      style: getText500(
                                          size: 11.5.sp,
                                          colors: ColorConstants.black),
                                    )),
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
                                getUTCToLocalDateTime(
                                    controller.mOrderPlace.value.orderDate ??
                                        ''),
                                style: getText500(
                                    size: 11.5.sp,
                                    colors: ColorConstants.black),
                              ),
                            ),

                            ///button cancel
                            Visibility(
                                visible: (controller.mOrderPlace.value
                                                .paymentStatus ==
                                            'P' ||
                                        controller.mOrderPlace.value
                                                .paymentStatus ==
                                            'F') &&
                                    (controller
                                            .mOrderPlace.value.paymentStatus !=
                                        'S'),
                                child: Container(
                                    width: 8.w,
                                    margin: EdgeInsets.only(
                                        left: 8.sp, right: 8.sp),
                                    child: rectangleCornerButtonText600(
                                      boderColor:
                                          ColorConstants.red.withOpacity(0.2),
                                      bgColor:
                                          ColorConstants.red.withOpacity(0.2),
                                      textColor: ColorConstants.red,
                                      height: 17.5.sp,
                                      textSize: 11.sp,
                                      sCancel.tr.toUpperCase(),
                                      () {
                                        controller.onCancelOrder();
                                      },
                                    ))),
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
              Expanded(child: TableItemSummaryOrderList()),

              /// Add More Items
              Visibility(
                  visible: (controller.mOrderPlace.value.paymentStatus == 'P'),
                  child: controller.mOrderPlace.value.orderSource.toString() ==
                          '2'
                      ? GestureDetector(
                          onTap: () {
                            controller.addMore();
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 8.sp, left: 8.sp, right: 8.sp),
                            padding: EdgeInsets.all(8.sp),
                            decoration: BoxDecoration(
                              color: ColorConstants.cAppButtonLightColour,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.sp),
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 13.sp,
                                ),
                                Text(
                                  sAddMoreItems.tr,
                                  style: getText500(
                                      size: 11.5.sp,
                                      colors: ColorConstants.cAppButtonColour),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const Text("You can't able to modify this order")),

              ///BottomView
              TableItemSummaryBottomView()
            ],
          ),
        ));
  }
}
