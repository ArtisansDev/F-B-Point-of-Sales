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
import 'package:responsive_sizer/responsive_sizer.dart';

import 'keyboard_widget.dart';

typedef KeyboardTapCallback = void Function(String text);

class NumericKeyboard extends StatefulWidget {
  /// Color of the text [default = Colors.black]
  final Color textColor;

  /// Display a custom right icon
  final Icon? rightIcon;

  /// Action to trigger when right button is pressed
  final Function()? rightButtonFn;

  /// Display a custom left icon
  final Icon? leftIcon;

  /// Action to trigger when left button is pressed
  final Function()? leftButtonFn;

  /// Callback when an item is pressed
  final KeyboardTapCallback onKeyboardTap;

  /// Main axis alignment [default = MainAxisAlignment.spaceEvenly]
  final MainAxisAlignment mainAxisAlignment;

  NumericKeyboard(
      {Key? key,
      required this.onKeyboardTap,
      this.textColor = Colors.black,
      this.rightButtonFn,
      this.rightIcon,
      this.leftButtonFn,
      this.leftIcon,
      this.mainAxisAlignment = MainAxisAlignment.spaceEvenly})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NumericKeyboardState();
  }
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.only(left: 32, right: 32, top: 20),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              ButtonBar(
                alignment: widget.mainAxisAlignment,
                children: <Widget>[
                  _calcButton('1'),
                  _calcButton('2'),
                  _calcButton('3'),
                ],
              ),
              ButtonBar(
                alignment: widget.mainAxisAlignment,
                children: <Widget>[
                  _calcButton('4'),
                  _calcButton('5'),
                  _calcButton('6'),
                ],
              ),
              ButtonBar(
                alignment: widget.mainAxisAlignment,
                children: <Widget>[
                  _calcButton('7'),
                  _calcButton('8'),
                  _calcButton('9'),
                ],
              ),
              ButtonBar(
                alignment: widget.mainAxisAlignment,
                children: <Widget>[
                  InkWell(
                      onTap: widget.leftButtonFn,
                      child:Container(
                        alignment: Alignment.center,
                        width: 21.sp,
                        height: 21.sp,
                        decoration: BoxDecoration(
                          color: ColorConstants.cAppButtonColour,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: widget.leftIcon,
                      )
                     ),
                  _calcButton('0'),
                  InkWell(
                      onTap: widget.rightButtonFn,
                      child: Container(
                          alignment: Alignment.center,
                          width: 21.sp,
                          height: 21.sp,
                          decoration: BoxDecoration(
                            color: ColorConstants.cAppButtonColour,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child:  widget.rightIcon))
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
           color: ColorConstants.white,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Text(
            value,
            style: getText600(
              size: 14.sp,
              colors: widget.textColor
            )
          ),
        ));
  }
}
