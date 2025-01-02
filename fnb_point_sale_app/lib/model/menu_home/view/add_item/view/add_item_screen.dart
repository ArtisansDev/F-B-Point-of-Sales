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
import 'package:fnb_point_sale_base/data/mode/product/get_all_modifier/get_all_modifier_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_variant/get_all_variant_response.dart';
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
                                        controller.mCartItem.value?.mSelectVariantListData
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
                                    child: incDecView(
                                        count:
                                            controller.mCartItem.value?.count,
                                        priceIncDec: (value) {
                                          controller.priceIncDec(value);
                                        })),
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

                        ///addon
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      top: 11.sp,
                                      bottom: 11.sp,
                                      left: 15.sp,
                                      right: 15.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Variant',
                                        style: getText600(
                                          size: 11.8.sp,
                                          colors: ColorConstants.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: (controller.mCartItem.value
                                                    ?.mVariantListData ??
                                                [])
                                            .length,
                                        itemBuilder: (context, index) {
                                          VariantListData mVariantListData =
                                              (controller.mCartItem.value
                                                      ?.mVariantListData ??
                                                  [])[index];
                                          return GestureDetector(
                                            onTap: () {
                                              controller.selectVariant(
                                                  mVariantListData);
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              margin: EdgeInsets.only(
                                                  bottom: (controller
                                                                          .mCartItem
                                                                          .value
                                                                          ?.mVariantListData ??
                                                                      [])
                                                                  .length -
                                                              1 ==
                                                          index
                                                      ? 0
                                                      : 12.sp),
                                              child: Row(
                                                children: [
                                                  selectCheckBox(
                                                      isRound: false,
                                                      isSelect: controller
                                                          .isSelectVariant(
                                                              mVariantListData)),
                                                  SizedBox(width: 10.sp),
                                                  Text(
                                                    '${mVariantListData.quantitySpecification}',
                                                    style: getTextRegular(
                                                      size: 10.5.sp,
                                                      colors: ColorConstants
                                                          .cAppCancelDilogColour,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8.sp,
                                                  ),
                                                  Visibility(
                                                      visible: (mVariantListData
                                                                  .discountPercentage ??
                                                              0) >
                                                          0,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            '(${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${(mVariantListData.price??0).toStringAsFixed(2)})',
                                                            style:
                                                                getTextRegularLineThrough(
                                                              size: 10.5.sp,
                                                              colors:
                                                                  ColorConstants
                                                                      .red,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5.sp,
                                                          ),
                                                          Text(
                                                            '(${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${(mVariantListData.discountedPrice??0).toStringAsFixed(2)})',
                                                            style:
                                                                getTextRegular(
                                                              size: 10.5.sp,
                                                              colors: ColorConstants
                                                                  .cAppTextInviceColour,
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                  const Expanded(
                                                      child: SizedBox()),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${(mVariantListData.discountedPrice??0).toStringAsFixed(2)}',
                                                      style: getText500(
                                                          colors: ColorConstants
                                                              .black,
                                                          size: 11.5.sp),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  )),
                              Container(
                                width: double.infinity,
                                height: 3.sp,
                                color:
                                    ColorConstants.cAppCancelDilogDeviderColour,
                                margin: EdgeInsets.only(
                                    top: 9.sp,
                                    bottom: 9.sp,
                                    left: 15.sp,
                                    right: 15.sp),
                              ),

                              ///Addons
                              Visibility(
                                  visible: (controller
                                              .mCartItem.value?.mModifierList ??
                                          [])
                                      .isNotEmpty,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: 11.sp,
                                        bottom: 11.sp,
                                        left: 15.sp,
                                        right: 15.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: (controller.mCartItem.value
                                                      ?.mModifierList ??
                                                  [])
                                              .length,
                                          itemBuilder: (context, index) {
                                            ModifierList mModifierList =
                                                (controller.mCartItem.value
                                                        ?.mModifierList ??
                                                    [])[index];
                                            return GestureDetector(
                                              onTap: () {
                                                controller.selectModifier(
                                                    mModifierList);
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                margin: EdgeInsets.only(
                                                    bottom: 6.sp),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 10,
                                                        child: Row(
                                                          children: [
                                                            selectCheckBox(
                                                                isRound: false,
                                                                isSelect: controller
                                                                    .isSelectModifier(
                                                                        mModifierList)),
                                                            SizedBox(
                                                                width: 10.sp),
                                                            Text(
                                                              mModifierList
                                                                      .modifierName ??
                                                                  '',
                                                              style:
                                                                  getTextRegular(
                                                                size: 10.5.sp,
                                                                colors: ColorConstants
                                                                    .cAppCancelDilogColour,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 8.sp),
                                                            Text(
                                                              '(${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${(mModifierList.price??0).toStringAsFixed(2)})',
                                                              style:
                                                                  getTextRegular(
                                                                size: 10.5.sp,
                                                                colors: ColorConstants
                                                                    .cAppButtonColour,
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                    SizedBox(
                                                      width: 10.sp,
                                                      height: 4.h,
                                                    ),
                                                    // Expanded(
                                                    //     flex: 3,
                                                    //     child:
                                                    //     incDecView(
                                                    //         count: mModifierList
                                                    //             .count,
                                                    //         priceIncDec:
                                                    //             (value) {
                                                    //           if (controller
                                                    //               .isSelectModifier(
                                                    //                   mModifierList)) {
                                                    //             controller
                                                    //                 .priceModifierIncDec(
                                                    //                     value,
                                                    //                     index,
                                                    //                     mModifierList);
                                                    //           }
                                                    //         })
                                                    // ),
                                                    Expanded(
                                                        flex: 3,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            '${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${((mModifierList.price ?? 0) * (mModifierList.count ?? 1)).toStringAsFixed(2)}',
                                                            style: getText500(
                                                                colors:
                                                                    ColorConstants
                                                                        .black,
                                                                size: 11.5.sp),
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  )),
                              Visibility(
                                  visible: (controller
                                              .mCartItem.value?.mModifierList ??
                                          [])
                                      .isNotEmpty,
                                  child: Container(
                                    width: double.infinity,
                                    height: 3.sp,
                                    color: ColorConstants
                                        .cAppCancelDilogDeviderColour,
                                    margin: EdgeInsets.only(
                                        top: 4.sp,
                                        bottom: 11.sp,
                                        left: 15.sp,
                                        right: 15.sp),
                                  )),
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
                              hintTextColor:
                                  ColorConstants.black.withOpacity(0.80),
                              onFilteringTextInputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(AppUtilConstants.patternOnlyString)),
                              ],
                            )),

                        ///Tax: RM 18.00
                        Visibility(
                            visible:
                                (controller.mCartItem.value?.taxAmount ?? 0) >
                                    0,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin:
                                      EdgeInsets.only(top: 11.sp, right: 15.sp),
                                  child: Text(
                                    'TAX: ${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${((controller.mCartItem.value?.taxAmount ?? 0) * (controller.mCartItem.value?.count ?? 1)).toStringAsFixed(2)}',
                                    style: getText600(
                                      size: 11.8.sp,
                                      colors: ColorConstants.appTextSalesHader,
                                    ),
                                  ),
                                ))),

                        ///TOTAL: RM 18.00
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: (controller.mCartItem.value?.taxAmount ??
                                              0) >
                                          0
                                      ? 5.sp
                                      : 11.sp,
                                  right: 15.sp),
                              child: Text(
                                'TOTAL: ${controller.mDashboardScreenController.value?.mCurrencyData.currencySymbol ?? ''} ${(controller.mCartItem.value?.totalPrice ?? 0).toStringAsFixed(2)}',
                                style: getText600(
                                  size: 11.8.sp,
                                  colors: ColorConstants.cAppTextInviceColour,
                                ),
                              ),
                            )),

                        ///button
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                              width: 13.w,
                              margin: EdgeInsets.only(
                                  left: 13.sp,
                                  right: 13.sp,
                                  top: 11.sp,
                                  bottom: 13.sp),
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
                    );
            },
          ),
        ));
  }

  incDecView({int? count, Function? priceIncDec}) {
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
                  if ((count ?? 1) > 1) {
                    priceIncDec!((count ?? 1) - 1);
                  }
                },
                color: ColorConstants.white,
                iconSize: 11.5.sp,
              ),
            ),

            // Counter display
            Text(
              '${count ?? 1}',
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
                    priceIncDec!((count ?? 1) + 1);
                  },
                  color: ColorConstants.white,
                  iconSize: 11.5.sp,
                )),
          ],
        ));
  }
}
