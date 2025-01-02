import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/item_payment_screen_controller.dart';
import 'item_payment_order_list.dart';
import 'item_payment_type_list.dart';

class ItemPaymentScreen extends GetView<ItemPaymentScreenController> {
  final OrderHistoryData mOrderPlace;
  final Function onPayment;

  const ItemPaymentScreen(this.mOrderPlace,
      {super.key, required this.onPayment});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ItemPaymentScreenController(mOrderPlace, onPayment));
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: Obx(
          () => Container(
            height: 88.h,
            width: 40.w,
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
                Container(
                    padding: EdgeInsets.only(
                        top: 11.sp, bottom: 11.sp, left: 14.sp, right: 14.sp),
                    decoration: BoxDecoration(
                      color: ColorConstants.cAppButtonLightColour,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(11.sp),
                        topRight: Radius.circular(11.sp),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Order #: ${controller.mOrderPlace.value?.trackingOrderID ?? '--'}',
                          style: getText600(
                            size: 11.8.sp,
                            colors: ColorConstants.cAppButtonColour,
                          ),
                        )),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10.sp),
                            height: 16.5.sp,
                            width: 16.5.sp,
                            padding: EdgeInsets.all(4.5.sp),
                            decoration: BoxDecoration(
                              color: ColorConstants.cAppButtonColour,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.sp),
                              ),
                            ),
                            child: Icon(
                              Icons.clear,
                              color: ColorConstants.white,
                              size: 11.sp,
                            ),
                          ),
                        )
                      ],
                    )),

                ///Phone Number
                Container(
                  height: 20.sp,
                  margin: EdgeInsets.only(
                      left: 13.sp, right: 13.sp, bottom: 10.sp, top: 11.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35.sp),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.22),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ], // use instead of BorderRadius.all(Radius.circular(20))
                  ),
                  child: TextInputWidget(
                    controller: controller.phoneNumberController.value,
                    showFloatingLabel: false,
                    isPhone: true,
                    isReadOnly: true,
                    sPrefixText: controller.phoneCode.value,
                    placeHolder: sPhoneNumber.tr,
                    topPadding: 5.sp,
                    prefixPadding: 11.sp,
                    hintTextSize: 11.sp,
                    textSize: 11.sp,
                    onClick: (value) {
                      if (value == 'prefixIcon') {
                        if ((controller.mOrderPlace.value?.phoneCountryCode ??
                                    '')
                                .isEmpty &&
                            (controller.mOrderPlace.value?.name ?? '')
                                .isEmpty) {
                          showCountryPicker(
                            context: Get.context!,
                            countryListTheme: CountryListThemeData(
                              backgroundColor: Colors.white,
                              textStyle: getText500(
                                  colors: ColorConstants.black, size: 12.sp),
                              bottomSheetHeight: 69.h,
                              bottomSheetWidth: 40.w,
                              // Optional. Country list modal height
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.sp),
                                topRight: Radius.circular(8.sp),
                              ),
                            ),
                            showPhoneCode: true,
                            // optional. Shows phone code before the country name.
                            onSelect: (Country country) {
                              controller.phoneCode.value = country.phoneCode;
                            },
                          );
                        }
                      } else {
                        if ((controller.mOrderPlace.value?.phoneNumber ?? '')
                                .isEmpty &&
                            (controller.mOrderPlace.value?.name ?? '')
                                .isEmpty) {
                          controller.getAllCustomer(showCustomer: true);
                        }
                      }
                    },
                    hintText: sPhoneNumber.tr,
                    errorText: null,
                    prefixHeight: 20.sp,
                    hintTextColor: ColorConstants.black.withOpacity(0.80),
                    onFilteringTextInputFormatter: [
                      FilteringTextInputFormatter.allow(
                        RegExp(AppUtilConstants.patternOnlyNumber),
                      ),
                      LengthLimitingTextInputFormatter(10)
                    ],
                  ),
                ),

                ///Enter Name
                Container(
                    height: 20.sp,
                    margin: EdgeInsets.only(left: 13.sp, right: 13.sp),
                    child: TextInputWidget(
                      placeHolder: sEnterName.tr,
                      controller: controller.nameController.value,
                      isReadOnly:
                          (controller.mOrderPlace.value?.name ?? '').isNotEmpty,
                      errorText: null,
                      textInputType: TextInputType.emailAddress,
                      hintText: sEnterName.tr,
                      hintTextColor: ColorConstants.black.withOpacity(0.80),
                      showFloatingLabel: false,
                      topPadding: 5.sp,
                      hintTextSize: 10.5.sp,
                      textSize: 10.5.sp,
                      onFilteringTextInputFormatter: [
                        FilteringTextInputFormatter.allow(
                            RegExp(AppUtilConstants.patternOnlyString)),
                      ],
                    )),

                // Container(
                //     height: 19.5.sp,
                //     margin: EdgeInsets.only(left: 13.sp, right: 13.sp),
                //     child: TextInputWidget(
                //       placeHolder: sPhoneNumber.tr,
                //       controller: controller.phoneNumberController.value,
                //       errorText: null,
                //       textInputType: TextInputType.emailAddress,
                //       hintText: sPhoneNumber.tr,
                //       showFloatingLabel: false,
                //       topPadding: 5.sp,
                //       hintTextSize: 10.5.sp,
                //       hintTextColor: ColorConstants.black.withOpacity(0.80),
                //       textSize: 10.5.sp,
                //       onFilteringTextInputFormatter: [
                //         FilteringTextInputFormatter.allow(
                //             RegExp(AppUtilConstants.patternOnlyString)),
                //       ],
                //     )),

                ///order list
                Expanded(child: ItemPaymentOrderList()),

                ///amount
                Container(
                    margin: EdgeInsets.only(
                        top: 11.sp, bottom: 11.sp, left: 13.sp, right: 13.sp),
                    padding: EdgeInsets.only(
                        top: 11.sp, bottom: 11.sp, left: 14.sp, right: 14.sp),
                    decoration: BoxDecoration(
                      color: ColorConstants.cAppCancelDilogBackgroundColour,
                      borderRadius: BorderRadius.all(
                        Radius.circular(3.sp),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Sub Total',
                              style: getText600(
                                size: 10.sp,
                                colors: ColorConstants.cAppCancelDilogColour,
                              ),
                            )),
                            Expanded(
                                child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${controller.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''} ${(controller.mOrderPlace.value?.subTotal ?? 0).toStringAsFixed(2)}',
                                style: getText600(
                                  size: 10.sp,
                                  colors: ColorConstants.cAppCancelDilogColour,
                                ),
                              ),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount:
                                (controller.mDashboardScreenController.taxData)
                                    .length,
                            itemBuilder: (BuildContext context, int index) {
                              TaxData mTaxData = (controller
                                  .mDashboardScreenController.taxData)[index];
                              return Column(
                                children: [
                                  Container(
                                      // margin: EdgeInsets.all(
                                      //   8.sp,
                                      // ),
                                      padding: EdgeInsets.only(bottom: 5.sp),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              '${mTaxData.taxName ?? ''}+ (${mTaxData.taxPercentage}%)',
                                              style: getText600(
                                                size: 10.sp,
                                                colors: ColorConstants
                                                    .cAppCancelDilogColour,
                                              )),
                                          Text(
                                              '${controller.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''} ${calculatePercentageOf(getDoubleValue(controller.mOrderPlace.value?.subTotal ?? 0), getDoubleValue(mTaxData.taxPercentage)).toStringAsFixed(2)}',
                                              style: getText600(
                                                size: 10.sp,
                                                colors: ColorConstants
                                                    .cAppCancelDilogColour,
                                              )),
                                        ],
                                      )),
                                  // Container(
                                  //   height: 3.sp,
                                  //   margin: EdgeInsets.only(left: 8.sp, right: 8.sp),
                                  //   color: Colors.grey.shade300,
                                  // ),
                                ],
                              );
                            }),
                        Container(
                          margin: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                          width: double.infinity,
                          height: 3.sp,
                          color: ColorConstants.cAppCancelDilogDeviderColour,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Total Amount',
                              style: getText600(
                                size: 10.5.sp,
                                colors: ColorConstants.cAppCancelDilogColour,
                              ),
                            )),
                            Expanded(
                                child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${controller.mDashboardScreenController.mCurrencyData.currencySymbol ?? ''} ${(controller.mOrderPlace.value?.totalAmount ?? 0.0).toStringAsFixed(2)}',
                                style: getText600(
                                  size: 10.5.sp,
                                  colors: ColorConstants.cAppCancelDilogColour,
                                ),
                              ),
                            ))
                          ],
                        ),
                      ],
                    )),

                ///payment list
                Expanded(child: ItemPaymentTypeList()),

                ///Print Invoice button
                Container(
                    margin: EdgeInsets.only(
                        left: 25.sp, right: 25.sp, top: 12.sp, bottom: 13.sp),
                    child: controller.isSelectPayment.value
                        ? rectangleCornerButtonText600(
                            height: 19.5.sp,
                            textSize: 11.7.sp,
                            sPrintInvoice.tr,
                            () {
                              controller.onPrint();
                            },
                          )
                        : const SizedBox(
                            height: 42.5,
                          )),
              ],
            ),
          ),
        ));
  }
}
