import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../home_base_controller/home_base_controller.dart';
import '../controller/stock_item_controller.dart';

class StockItemScreen extends GetView<StockItemController> {
  final HomeBaseController mHomeBaseController;

  const StockItemScreen(this.mHomeBaseController, {super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => StockItemController(mHomeBaseController));
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: Container(
          height: 28.h,
          width: 30.w,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: ColorConstants.white,
            borderRadius: BorderRadius.all(
              Radius.circular(11.sp),
            ),
          ),
          child: Obx(
            () {
              return controller.mCartItem.value == null
                  ? const Center(
                      child: Text("Loading..."),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///main item
                        Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.cAppButtonLightColour,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(11.sp),
                                topRight: Radius.circular(11.sp),
                              ),
                            ),
                            padding: EdgeInsets.only(
                                top: 12.sp,
                                bottom: 12.sp,
                                left: 15.sp,
                                right: 15.sp),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        sStockOut.tr,
                                        style: getText600(
                                          size: 11.8.sp,
                                          colors:
                                              ColorConstants.cAppButtonColour,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),


                        ///main item
                        Container(
                            padding: EdgeInsets.only(
                                top: 12.sp,
                                bottom: 12.sp,
                                left: 15.sp,
                                right: 15.sp),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.mCartItem.value
                                                ?.mMenuItemData?.itemName ??
                                            '',
                                        style: getText600(
                                          size: 11.8.sp,
                                          colors:
                                              ColorConstants.cAppButtonColour,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.sp,
                                      ),
                                      Text(
                                        controller
                                                .mCartItem
                                                .value
                                                ?.mSelectVariantListData
                                                ?.quantitySpecification ??
                                            '',
                                        style: getTextRegular(
                                          size: 10.5.sp,
                                          colors: ColorConstants
                                              .cAppCancelDilogColour,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10.sp,
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${(controller.mCartItem.value?.price ?? 0).toStringAsFixed(2)}',
                                        style: getText500(
                                            colors: ColorConstants.black,
                                            size: 11.5.sp),
                                      ),
                                    ))
                              ],
                            )),
                        const Expanded(child: SizedBox()),
                        ///button
                        Align(
                            alignment: Alignment.center,
                            child: Wrap(
                              children: [
                                Container(
                                    width: 10.w,
                                    margin: EdgeInsets.only(
                                        left: 13.sp,
                                        right: 13.sp,
                                        top: 11.sp,
                                        bottom: 13.sp),
                                    child: rectangleCornerButtonText600(
                                      height: 19.5.sp,
                                      textSize: 11.5.sp,
                                      sStockOut.tr,
                                      () async {
                                       await controller.onStockInOutItem();
                                       // await controller.onStockItem();
                                      },
                                    )),
                                Container(
                                    width: 10.w,
                                    margin: EdgeInsets.only(
                                        right: 13.sp,
                                        top: 11.sp,
                                        bottom: 13.sp),
                                    child: rectangleCornerButtonText600(
                                      height: 19.5.sp,
                                      textSize: 11.7.sp,
                                      sClose.tr,
                                      () {
                                        Get.back();
                                      },
                                    )),
                              ],
                            ))
                      ],
                    );
            },
          ),
        ));
  }
}
