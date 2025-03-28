import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/keyboard_widget.dart';
import 'package:fnb_point_sale_base/common/numeric_cash_keyboard.dart';
import 'package:fnb_point_sale_base/common/numeric_keyboard.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/cash_view_controller.dart';

///partha paul
///KeypadScreen
///27/03/25

class KeypadScreen extends StatelessWidget {
  late CashViewController controller;

  KeypadScreen({super.key}) {
    controller = Get.find<CashViewController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.w,
        margin: EdgeInsets.only(top: 15.sp),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 3.sp),
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10.sp),
        ),
      child: KeyboardWidget(
          requestFocus: false,
          child: NumericCashKeyboard(
              onKeyboardTap: controller.onKeyboardTap,
              textColor: ColorConstants.appNumberText,
              rightDeleteButtonFn: () {
                controller.onDeletePress();
              },
              rightDeleteIcon: Icon(
                Icons.backspace,
                size: 14.sp,
                color: ColorConstants.white,
              ),
              onClearFn: () {controller.onClear();},
              onExactFn: () {controller.onExact();},
              // leftButtonFn: () {
              //   controller.onDeletePress();
              // },
              // leftIcon:  Icon(
              //   Icons.backspace,
              //   color: ColorConstants.white,
              //   size: 14.sp,
              // ),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly),
          onEsc: () {},
          onNumber: (value) {
            controller.onKeyboardTap('$value');
          },
          onDecimal: () {},
          onPeriod: () {
            controller.onKeyboardTap('.');
          },
          onDelete: () {
            controller.onDeletePress();
          },
          onEnter: () {
            controller.isPinCheck();
          }),
    )
      ;
  }
}
