import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/utils/date_time_utils.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/item_summary_controller.dart';
import 'item_summary_bottom_view.dart';
import 'item_summary_order_list.dart';

class ItemSummaryOrderScreen extends GetView<ItemSummaryController> {
  final OrderHistoryData mOrderData;

  const ItemSummaryOrderScreen(this.mOrderData, {super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ItemSummaryController(mOrderData));
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
                                  controller
                                          .mOrderPlace.value.trackingOrderID ??
                                      '',
                                  style: getText500(
                                      size: 11.5.sp,
                                      colors: ColorConstants.black),
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
                                      size: 11.5.sp,
                                      colors: ColorConstants.black),
                                ),
                                SizedBox(
                                  width: 8.sp,
                                ),
                                Text(
                                  controller.mOrderPlace.value?.tableNo ?? '',
                                  style: getText500(
                                      size: 11.5.sp,
                                      colors: ColorConstants.black),
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
                                getUTCToLocalDateTime(
                                    controller.mOrderPlace.value.orderDate ??
                                        ''),
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

              // ///OrderList
              // Expanded(child: ItemSummaryOrderList()),
              //
              // ///BottomView
              // ItemSummaryBottomView()
            ],
          ),
        ));
  }
}
