import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';

class MyTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode node;
  final String hint;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextAlign? textAlign;
  final bool? obscureText;
  final bool? enabled;
  final bool? borderVisibility;
  final Color? borderColor;
  final Color? fillColor;
  final double? height;
  final TextStyle? textStyle;
  final FilteringTextInputFormatter? onFilteringTextInputFormatter;
  final bool? autofocus;
  final Function()? onTap;

  const MyTextFieldWidget({Key? key,
    required this.controller,
    required this.node,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.onFilteringTextInputFormatter,
    this.enabled = true,
    this.obscureText = false,
    this.textStyle,
    this.borderColor,
    this.fillColor,
    this.height,
    this.borderVisibility,
    this.onSubmitted,
    this.autofocus,
    this.onTap
  })

      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyTextFieldState();
  }
}

class _MyTextFieldState extends State<MyTextFieldWidget> {
  late Color primaryColor;

  @override
  void initState() {
    super.initState();
    widget.node.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    widget.node.removeListener(_handleFocusChange);
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    primaryColor = ColorConstants.cAppColors;
    return SizedBox(
      height: widget.height ?? 21.5.sp,
      child: TextField(
        controller: widget.controller,
        focusNode: widget.node,
        textAlign: widget.textAlign == null ? TextAlign.start : widget
            .textAlign!,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText!,
        enabled: widget.enabled,
        cursorColor: ColorConstants.cAppButtonColour,
        style: widget.textStyle ??
            getTextRegular(colors: Colors.black, size: 10.8.sp),
        inputFormatters: (widget.onFilteringTextInputFormatter == null)
            ? <TextInputFormatter>[]
            : <TextInputFormatter>[widget.onFilteringTextInputFormatter!],
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10.px, 0, 10.px, 0),
            filled: true,
            fillColor: widget.fillColor ??
                ColorConstants.white,
            hintText: widget.hint,
            hintStyle:
            getTextRegular(colors: ColorConstants.appEditTextHint, size: 10.7.sp),
            border:
            OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                borderSide: BorderSide(
                    color: widget.borderColor ?? ColorConstants.primaryBackgroundColor)
            ),
            focusedBorder:
            OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                borderSide: BorderSide(
                    color: widget.borderColor ?? ColorConstants.primaryBackgroundColor)
            ),
            enabledBorder:
            OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                borderSide: BorderSide(
                    color: widget.borderColor ?? ColorConstants.primaryBackgroundColor)
            ),
            focusedErrorBorder:
            OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                borderSide: BorderSide(
                    color: widget.borderColor ?? ColorConstants.primaryBackgroundColor)
            ),
            disabledBorder:
            OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                borderSide: BorderSide(
                    color: widget.borderColor ?? ColorConstants.primaryBackgroundColor)
            )

        ),
        autofocus: widget.autofocus ?? false,
        onTap: widget.onTap,
      ),
    );
  }
}

// Focus(
// onKey: (FocusNode node, RawKeyEvent event) {
// if (event is RawKeyDownEvent &&
// event.logicalKey == LogicalKeyboardKey.backspace) {
// print("Backspace pressed");
// // widget.controller.text = widget.controller.text.d
// return KeyEventResult.handled;
// }
// return KeyEventResult.ignored;
// },
// child:
//