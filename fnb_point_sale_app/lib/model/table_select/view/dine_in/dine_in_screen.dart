import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/table_select_controller.dart';

class DineInScreen extends StatelessWidget {
  late TableSelectController controller;

  DineInScreen({super.key}) {
    controller = Get.find<TableSelectController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Table No
          Container(
              height: 20.sp,
              margin: EdgeInsets.only(left: 13.sp, right: 13.sp, top: 5.sp),
              child: TextInputWidget(
                isReadOnly: controller.sTableNumber.value != null,
                placeHolder: sTableNo.tr,
                controller: controller.sTableNoController.value,
                errorText: null,
                textInputType: TextInputType.emailAddress,
                hintText: sTableNo.tr,
                prefixIcon: Icons.table_bar,
                prefixHeight: 13.sp,
                showFloatingLabel: false,
                topPadding: 5.sp,
                hintTextSize: 11.sp,
                textSize: 11.sp,
                textColor: ColorConstants.cAppButtonColour,
                hintTextColor: ColorConstants.black.withOpacity(0.80),
                onFilteringTextInputFormatter: [
                  FilteringTextInputFormatter.allow(
                      RegExp(AppUtilConstants.patternOnlyString)),
                ],
              )),

          ///Phone Number
          Container(
            height: 20.sp,
            margin: EdgeInsets.only(left: 13.sp, right: 13.sp, top: 10.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.sp),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.12),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ], // use instead of BorderRadius.all(Radius.circular(20))
            ),
            child: TextInputWidget(
              controller: controller.sPhoneNumberController.value,
              showFloatingLabel: false,
              isPhone: true,
              isReadOnly: true,
              sPrefixText: controller.phoneCode.value,
              placeHolder: sPhoneNumber.tr,
              topPadding: 5.sp,
              hintTextSize: 11.sp,
              textSize: 11.sp,
              onClick: (value) {
                if (value == 'prefixIcon') {
                  showCountryPicker(
                    context: Get.context!,
                    countryListTheme: CountryListThemeData(
                      backgroundColor: Colors.white,
                      textStyle:
                      getText500(colors: ColorConstants.black, size: 12.sp),
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
                }else {
                  controller.getAllCustomer(showCustomer: true);
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
              margin: EdgeInsets.only(left: 13.sp, right: 13.sp, top: 10.sp),
              child: TextInputWidget(
                placeHolder: sEnterName.tr,
                controller: controller.enterNameController.value,
                errorText: null,
                isReadOnly: (controller.mSelectCustomer.value?.name??'_new_').toString()!='_new_',
                textInputType: TextInputType.emailAddress,
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

          ///notes
          Container(
              margin: EdgeInsets.only(left: 13.sp, right: 13.sp, top: 10.sp),
              child: TextInputWidget(
                placeHolder: sNotes.tr,
                controller: controller.notesController.value,
                errorText: null,
                textInputType: TextInputType.emailAddress,
                hintText: sNotes.tr,
                showFloatingLabel: false,
                topPadding: 12.sp,
                maxLines: 4,
                hintTextSize: 11.sp,
                textSize: 11.sp,
                hintTextColor: ColorConstants.black.withOpacity(0.80),
                onFilteringTextInputFormatter: [
                  FilteringTextInputFormatter.allow(
                      RegExp(AppUtilConstants.patternOnlyString)),
                ],
              )),
        ],
      ),
    );
  }
}
