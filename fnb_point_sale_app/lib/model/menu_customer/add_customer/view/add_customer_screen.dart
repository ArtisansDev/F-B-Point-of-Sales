import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/add_customer_controller.dart';

class AddCustomerScreen extends GetView<AddCustomerController> {
  final GetAllCustomerList mCustomer;

  const AddCustomerScreen({super.key, required this.mCustomer});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddCustomerController(mCustomer));
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: Obx(
          () => Container(
            height: 67.h,
            width: 30.w,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color: ColorConstants.white,
              borderRadius: BorderRadius.all(
                Radius.circular(11.sp),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: 10.sp, left: 11.sp, right: 11.sp, bottom: 10.sp),
                  decoration: BoxDecoration(
                    color: ColorConstants.cAppButtonLightColour,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.sp),
                      topLeft: Radius.circular(8.sp),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15.sp,
                      ),
                      Expanded(
                          child: Text(
                        controller.mEditCustomer.value == null
                            ? sAddCustomer.tr
                            : sEditCustomer.tr,
                        style: getText600(
                            colors: ColorConstants.appTextSalesHader,
                            size: 12.sp),
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
                  ),
                ),

                ///Phone Number
                Container(
                  height: 20.sp,
                  margin:
                      EdgeInsets.only(left: 13.sp, right: 13.sp, top: 12.sp),
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
                    controller: controller.sPhoneNumberController.value,
                    showFloatingLabel: false,
                    isPhone: true,
                    isReadOnly:
                        controller.mEditCustomer.value?.phoneNumber != null,
                    sPrefixText: controller.phoneCode.value,
                    placeHolder: sPhoneNumber.tr,
                    topPadding: 5.sp,
                    hintTextSize: 11.sp,
                    textSize: 11.sp,
                    onClick: (value) {
                      if (value == 'prefixIcon') {
                        if (controller.mEditCustomer.value?.customerIDP ==
                            null) {
                          showCountryPicker(
                            context: Get.context!,
                            countryListTheme: CountryListThemeData(
                              backgroundColor: Colors.white,
                              textStyle: getText500(
                                  colors: ColorConstants.black, size: 12.sp),
                              bottomSheetHeight: 69.h,
                              // Optional. Country list modal height
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(11.sp),
                                topRight: Radius.circular(11.sp),
                              ),
                            ),
                            showPhoneCode: true,
                            // optional. Shows phone code before the country name.
                            onSelect: (Country country) {
                              controller.phoneCode.value = country.phoneCode;
                            },
                          );
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
                    margin:
                        EdgeInsets.only(left: 13.sp, right: 13.sp, top: 10.sp),
                    child: TextInputWidget(
                      placeHolder: sEnterName.tr,
                      controller: controller.enterNameController.value,
                      errorText: null,
                      textInputType: TextInputType.name,
                      hintText: sEnterName.tr,
                      showFloatingLabel: false,
                      topPadding: 5.sp,
                      hintTextSize: 11.sp,
                      textSize: 11.sp,
                      hintTextColor: ColorConstants.black.withOpacity(0.80),
                      prefixIcon: Icons.person_rounded,
                      prefixHeight: 13.sp,
                      onFilteringTextInputFormatter: [
                        FilteringTextInputFormatter.allow(
                            RegExp(AppUtilConstants.patternStringAndSpace)),
                      ],
                    )),

                ///Email Name
                Container(
                    height: 20.sp,
                    margin:
                        EdgeInsets.only(left: 13.sp, right: 13.sp, top: 10.sp),
                    child: TextInputWidget(
                      placeHolder: sEnterEmail.tr,
                      controller: controller.enterEmailController.value,
                      errorText: null,
                      textInputType: TextInputType.emailAddress,
                      hintText: sEnterEmail.tr,
                      showFloatingLabel: false,
                      topPadding: 5.sp,
                      hintTextSize: 11.sp,
                      textSize: 11.sp,
                      hintTextColor: ColorConstants.black.withOpacity(0.80),
                      prefixIcon: Icons.email,
                      prefixHeight: 13.sp,
                      onFilteringTextInputFormatter: [
                        FilteringTextInputFormatter.allow(
                            RegExp(AppUtilConstants.patternEmailStringAtDot)),
                      ],
                    )),

                // ///dob Name
                // Container(
                //     height: 20.sp,
                //     margin:
                //         EdgeInsets.only(left: 13.sp, right: 13.sp, top: 10.sp),
                //     child: TextInputWidget(
                //       placeHolder: sEnterDob.tr,
                //       controller: controller.enterDobController.value,
                //       errorText: null,
                //       onClick: (value) {
                //         controller.selectDate(context);
                //       },
                //       hintText: sEnterDob.tr,
                //       showFloatingLabel: false,
                //       isReadOnly: true,
                //       topPadding: 5.sp,
                //       hintTextSize: 11.sp,
                //       textSize: 11.sp,
                //       hintTextColor: ColorConstants.black.withOpacity(0.80),
                //       prefixIcon: Icons.date_range,
                //       prefixHeight: 13.sp,
                //       onFilteringTextInputFormatter: [
                //         FilteringTextInputFormatter.allow(
                //             RegExp(AppUtilConstants.patternEmailStringAtDot)),
                //       ],
                //     )),

                ///address
                Container(
                    margin:
                        EdgeInsets.only(left: 13.sp, right: 13.sp, top: 10.sp),
                    child: TextInputWidget(
                      placeHolder: sEnterAddress.tr,
                      controller: controller.enterAddressController.value,
                      errorText: null,
                      textInputType: TextInputType.text,
                      hintText: sEnterAddress.tr,
                      showFloatingLabel: false,
                      topPadding: 12.sp,
                      maxLines: 4,
                      hintTextSize: 11.sp,
                      textSize: 11.sp,
                      hintTextColor: ColorConstants.black.withOpacity(0.80),
                      onFilteringTextInputFormatter: [
                        FilteringTextInputFormatter.allow(
                            RegExp(AppUtilConstants.patternStringAndSpace)),
                      ],
                    )),

                const Expanded(child: SizedBox()),

                ///button
                Container(
                    margin: EdgeInsets.only(
                        left: 13.sp, right: 13.sp, top: 12.sp, bottom: 13.sp),
                    child: rectangleCornerButtonText600(
                      height: 19.5.sp,
                      textSize: 11.7.sp,
                      controller.mEditCustomer.value == null
                          ? sSubmit.tr
                          : sUpdate.tr,
                      () {
                        controller.onSubmit();
                      },
                    )),
              ],
            ),
          ),
        ));
  }
}
