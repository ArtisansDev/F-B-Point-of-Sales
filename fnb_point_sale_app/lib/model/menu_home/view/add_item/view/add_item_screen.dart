import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/check_box_create/coustom_check_box.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../home_base_controller/home_base_controller.dart';
import '../controller/add_item_controller.dart';

class AddItemScreen extends GetView<AddItemController> {
  final HomeBaseController mHomeBaseController;

  const AddItemScreen(this.mHomeBaseController, {super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddItemController(mHomeBaseController));
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: Container(
          height: Platform.isWindows ? 80.h : 75.h,
          width: 50.w,
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
                      top: 12.sp, bottom: 12.sp, left: 15.sp, right: 15.sp),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Margherita pizza',
                              style: getText600(
                                size: 11.8.sp,
                                colors: ColorConstants.cAppButtonColour,
                              ),
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                              style: getTextRegular(
                                size: 10.5.sp,
                                colors: ColorConstants.cAppCancelDilogColour,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Expanded(flex: 3, child: incDecView()),
                      Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'RM 14.00',
                              style: getText500(
                                  colors: ColorConstants.black, size: 11.5.sp),
                            ),
                          ))
                    ],
                  )),

              ///addon
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 11.sp, bottom: 11.sp, left: 15.sp, right: 15.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Extra Cheese',
                            style: getText600(
                              size: 11.8.sp,
                              colors: ColorConstants.black,
                            ),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    selectCheckBox(
                                        isRound: false, isSelect: true),
                                    SizedBox(
                                      width: 10.sp,
                                    ),
                                    Text(
                                      'Single Topping',
                                      style: getTextRegular(
                                        size: 10.5.sp,
                                        colors: ColorConstants.black
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 12.sp,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    selectCheckBox(
                                        isRound: false, isSelect: false),
                                    SizedBox(
                                      width: 10.sp,
                                    ),
                                    Text(
                                      'Double Topping',
                                      style: getTextRegular(
                                        size: 10.5.sp,
                                        colors: ColorConstants.black
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                    Text(
                                      ' (RM 2.00)',
                                      style: getTextRegular(
                                        size: 10.5.sp,
                                        colors: ColorConstants.cAppButtonColour,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 3.sp,
                      color: ColorConstants.cAppCancelDilogDeviderColour,
                      margin: EdgeInsets.only(
                          top: 9.sp, bottom: 9.sp, left: 15.sp, right: 15.sp),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            top: 11.sp,
                            bottom: 11.sp,
                            left: 15.sp,
                            right: 15.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cheese Dip',
                              style: getText600(
                                size: 11.8.sp,
                                colors: ColorConstants.black,
                              ),
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Row(
                              children: [
                                selectCheckBox(isRound: false, isSelect: false),
                                SizedBox(width: 10.sp),
                                Text(
                                  'Swiss Cheese',
                                  style: getTextRegular(
                                    size: 10.5.sp,
                                    colors:
                                        ColorConstants.cAppCancelDilogColour,
                                  ),
                                ),
                                Text(
                                  ' (RM 1.50)',
                                  style: getTextRegular(
                                    size: 10.5.sp,
                                    colors: ColorConstants.cAppButtonColour,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'RM 1.50',
                                    style: getText500(
                                        colors: ColorConstants.black,
                                        size: 11.5.sp),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 11.5.sp,
                            ),
                            Row(
                              children: [
                                selectCheckBox(isRound: false, isSelect: true),
                                SizedBox(width: 10.sp),
                                Text(
                                  'Classic Swiss Cheese',
                                  style: getTextRegular(
                                    size: 10.5.sp,
                                    colors:
                                        ColorConstants.cAppCancelDilogColour,
                                  ),
                                ),
                                Text(
                                  ' (RM 2.00)',
                                  style: getTextRegular(
                                    size: 10.5.sp,
                                    colors: ColorConstants.cAppButtonColour,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'RM 2.00',
                                    style: getText500(
                                        colors: ColorConstants.black,
                                        size: 11.5.sp),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                    Container(
                      width: double.infinity,
                      height: 3.sp,
                      color: ColorConstants.cAppCancelDilogDeviderColour,
                      margin: EdgeInsets.only(
                          top: 9.sp, bottom: 9.sp, left: 15.sp, right: 15.sp),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 11.sp, bottom: 11.sp, left: 15.sp, right: 15.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Addons',
                            style: getText600(
                              size: 11.8.sp,
                              colors: ColorConstants.black,
                            ),
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 10,
                                  child: Row(
                                    children: [
                                      selectCheckBox(
                                          isRound: false, isSelect: true),
                                      SizedBox(width: 10.sp),
                                      Text(
                                        'Addons-1',
                                        style: getTextRegular(
                                          size: 10.5.sp,
                                          colors: ColorConstants
                                              .cAppCancelDilogColour,
                                        ),
                                      ),
                                      Text(
                                        ' (RM 2.00)',
                                        style: getTextRegular(
                                          size: 10.5.sp,
                                          colors:
                                              ColorConstants.cAppButtonColour,
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Expanded(flex: 3, child: incDecView()),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'RM 2.00',
                                      style: getText500(
                                          colors: ColorConstants.black,
                                          size: 11.5.sp),
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 7.sp,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 10,
                                  child: Row(
                                    children: [
                                      selectCheckBox(
                                          isRound: false, isSelect: false),
                                      SizedBox(width: 10.sp),
                                      Text(
                                        'Addons-2',
                                        style: getTextRegular(
                                          size: 10.5.sp,
                                          colors: ColorConstants
                                              .cAppCancelDilogColour,
                                        ),
                                      ),
                                      Text(
                                        ' (RM 2.50)',
                                        style: getTextRegular(
                                          size: 10.5.sp,
                                          colors:
                                              ColorConstants.cAppButtonColour,
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Expanded(flex: 3, child: incDecView()),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'RM 2.50',
                                      style: getText500(
                                          colors: ColorConstants.black,
                                          size: 11.5.sp),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 3.sp,
                      color: ColorConstants.cAppCancelDilogDeviderColour,
                      margin: EdgeInsets.only(
                          top: 9.sp, bottom: 11.sp, left: 15.sp, right: 15.sp),
                    ),
                  ],
                ),
              )),

              ///sAddRemarks
              Container(
                  margin: EdgeInsets.only(left: 13.sp, right: 13.sp),
                  child: TextInputWidget(
                    placeHolder: sAddRemarks.tr,
                    controller: controller.remarkController.value,
                    errorText: null,
                    textInputType: TextInputType.emailAddress,
                    hintText: sAddRemarks.tr,
                    showFloatingLabel: false,
                    topPadding: 12.sp,
                    maxLines: 3,
                    hintTextSize: 11.sp,
                    textSize: 11.5.sp,
                    hintTextColor: ColorConstants.black.withOpacity(0.80),
                    onFilteringTextInputFormatter: [
                      FilteringTextInputFormatter.allow(
                          RegExp(AppUtilConstants.patternOnlyString)),
                    ],
                  )),

              ///TOTAL: RM 18.00
              Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 11.sp, right: 15.sp),
                    child: Text(
                      'TOTAL: RM 18.00',
                      style: getText600(
                        size: 11.8.sp,
                        colors: ColorConstants.cAppButtonColour,
                      ),
                    ),
                  )),

              ///button
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                    width: 13.w,
                    margin: EdgeInsets.only(
                        left: 13.sp, right: 13.sp, top: 11.sp, bottom: 13.sp),
                    child: rectangleCornerButtonText600(
                      height: 19.5.sp,
                      textSize: 11.5.sp,
                      sAddItem.tr,
                      () {
                        controller.onAddItem();
                      },
                    )),
              )
            ],
          ),
        ));
  }

  incDecView() {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(5.sp),
        margin: EdgeInsets.only(left: 8.sp, right: 8.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.sp),
            color: ColorConstants.cAppQtyColour),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Decrement button
            Container(
              height: 15.5.sp,
              width: 15.5.sp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: ColorConstants.cAppButtonColour),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.remove),
                onPressed: () {
                  // if ((mGetItemDetailsData.count ?? 0) > 1) {
                  //   controller.priceIncDec(mGetItemDetailsData, index,
                  //       (mGetItemDetailsData.count ?? 0) - 1);
                  // }
                },
                color: ColorConstants.white,
                iconSize: 11.5.sp,
              ),
            ),

            // Counter display
            Text(
              '1',
              style: getText500(colors: ColorConstants.black, size: 11.sp),
            ),

            // Increment button
            Container(
                height: 15.5.sp,
                width: 15.5.sp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: ColorConstants.cAppButtonColour),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // controller.priceIncDec(mGetItemDetailsData, index,
                    //     (mGetItemDetailsData.count ?? 0) + 1);
                  },
                  color: ColorConstants.white,
                  iconSize: 11.5.sp,
                )),
          ],
        ));
  }
}
