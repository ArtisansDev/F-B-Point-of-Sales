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

          ///Enter Name
          Container(
              height: 20.sp,
              margin: EdgeInsets.only(left: 13.sp, right: 13.sp, top: 10.sp),
              child: TextInputWidget(
                placeHolder: sEnterName.tr,
                controller: controller.enterNameController.value,
                errorText: null,
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
                      RegExp(AppUtilConstants.patternOnlyString)),
                ],
              )),

          ///Phone Number
          Container(
              height: 20.sp,
              margin: EdgeInsets.only(left: 13.sp, right: 13.sp, top: 10.sp),
              child: TextInputWidget(
                placeHolder: sPhoneNumber.tr,
                controller: controller.sPhoneNumberController.value,
                errorText: null,
                textInputType: TextInputType.phone,
                hintText: sPhoneNumber.tr,
                showFloatingLabel: false,
                topPadding: 5.sp,
                hintTextSize: 11.sp,
                textSize: 11.sp,
                hintTextColor: ColorConstants.black.withOpacity(0.80),
                prefixIcon: Icons.phone,
                prefixHeight: 13.sp,
                onFilteringTextInputFormatter: [
                  FilteringTextInputFormatter.allow(
                      RegExp(AppUtilConstants.patternOnlyNumber)),
                  LengthLimitingTextInputFormatter(10)
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
