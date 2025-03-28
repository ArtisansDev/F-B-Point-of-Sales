/*
 * Project      : fnb_point_sale_app
 * File         : numeric_keyboard.dart.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-10-18
 * Version      : 1.0
 * Ticket       : 
 */

library numeric_keyboard;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../lang/translation_service_key.dart';
import 'button_constants.dart';
import 'keyboard_widget.dart';

typedef KeyboardTapCallback = void Function(String text);

class NumericCashKeyboard extends StatefulWidget {
  /// Color of the text [default = Colors.black]
  final Color textColor;

  /// Display a custom right icon
  final Icon? rightDeleteIcon;

  /// Action to trigger when right button is pressed
  final Function()? rightDeleteButtonFn;

  /// Display a custom left icon
  final Icon? leftIcon;

  /// Action to trigger when left button is pressed
  final Function()? leftButtonFn;

  /// Callback when an item is pressed
  final KeyboardTapCallback onKeyboardTap;

  /// Main axis alignment [default = MainAxisAlignment.spaceEvenly]
  final MainAxisAlignment mainAxisAlignment;

  /// Action to trigger when right button is pressed
  final Function()? onClearFn;
  final Function()? onExactFn;

  const NumericCashKeyboard({super.key,
    required this.onKeyboardTap,
    this.textColor = Colors.black,
    this.rightDeleteButtonFn,
    this.rightDeleteIcon,
    this.leftButtonFn,
    this.onClearFn,
    this.onExactFn,
    this.leftIcon,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly});

  @override
  State<StatefulWidget> createState() {
    return _NumericKeyboardState();
  }
}

class _NumericKeyboardState extends State<NumericCashKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 5.sp, right: 5.sp, top: 15.sp, bottom: 15.sp),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          OverflowBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('1'),
              _calcButton('2'),
              _calcButton('3'),
              _calcButton('4'),
            ],
          ),
          SizedBox(height: 13.sp,),
          OverflowBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('5'),
              _calcButton('6'),
              _calcButton('7'),
              _calcButton('8'),
            ],
          ),
          SizedBox(height: 13.sp,),

          OverflowBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('9'),
              _calcButton('0'),
              _calcButton('.'),
              InkWell(
                  onTap: widget.rightDeleteButtonFn,
                  child: Container(
                      alignment: Alignment.center,
                      width: 21.sp,
                      height: 21.sp,
                      decoration: BoxDecoration(
                        color: ColorConstants.cAppButtonColour,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: widget.rightDeleteIcon))
            ],
          ),
          SizedBox(height: 13.sp,),
          OverflowBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              SizedBox(
                width: 11.sp,
              ),
              SizedBox(
                  width: 8.w,
                  child: rectangleCornerButtonText500(
                    height: 19.5.sp,
                    textSize: 11.7.sp,
                    sClear.tr,
                        () {
                      widget.onClearFn!();
                    },
                  )),
              SizedBox(
                width: 15.sp,
              ),
              SizedBox(
                  width: 8.w,
                  child: rectangleCornerButtonText500(
                    height: 19.5.sp,
                    textSize: 11.7.sp,
                    sExact.tr,
                        () {
                      widget.onExactFn!();
                    },
                  )),
              SizedBox(
                width: 11.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _calcButton(String value) {
    return InkWell(
        onTap: () {
          widget.onKeyboardTap(value);
        },
        child: Container(
          alignment: Alignment.center,
          width: 21.sp,
          height: 21.sp,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 3.sp),
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Text(value,
              textAlign: TextAlign.center,
              style: getText600(size: 13.sp, colors: widget.textColor)),
        ));
  }
}
