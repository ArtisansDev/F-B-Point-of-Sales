// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:jakel_base/utils/app_text_styles.dart';
//
// import '../../constants/size_constants.dart';
// import '../../theme/colors/my_colors.dart';
// import '../../utils/colors/color_constants.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
//
// class MyTextQtyFieldWidget extends StatefulWidget {
//   final TextEditingController controller;
//   final FocusNode node;
//   final String hint;
//   final TextInputType keyboardType;
//   final ValueChanged<String>? onChanged;
//   final ValueChanged<String>? onSubmitted;
//   final TextAlign? textAlign;
//   final bool? obscureText;
//   final bool? enabled;
//   final bool? borderVisibility;
//   final Color? borderColor;
//   final Color? fillColor;
//   final TextStyle? textStyle;
//   final Function? onTap;
//   final FilteringTextInputFormatter? onFilteringTextInputFormatter;
//
//   const MyTextQtyFieldWidget(
//       {Key? key,
//       required this.controller,
//       required this.node,
//       required this.hint,
//       this.keyboardType = TextInputType.text,
//       this.textAlign = TextAlign.start,
//       this.onChanged,
//       this.onFilteringTextInputFormatter,
//       this.enabled = true,
//       this.obscureText = false,
//       this.textStyle,
//       this.borderColor,
//       this.fillColor,
//       this.borderVisibility,
//       this.onTap,
//       this.onSubmitted})
//       : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _MyTextQtyFieldWidget();
//   }
// }
//
// class _MyTextQtyFieldWidget extends State<MyTextQtyFieldWidget> {
//   late Color primaryColor;
//
//   @override
//   Widget build(BuildContext context) {
//     primaryColor = getPrimaryColor(context);
//     return TextField(
//         controller: widget.controller,
//         focusNode: widget.node,
//         textAlign:
//             widget.textAlign == null ? TextAlign.start : widget.textAlign!,
//         onChanged: widget.onChanged,
//         onSubmitted: widget.onSubmitted,
//         keyboardType: widget.keyboardType,
//         obscureText: widget.obscureText!,
//         enabled: widget.enabled,
//         style: widget.textStyle ??
//             getTextNormal(colors: Colors.black, size: 10.8.sp),
//         inputFormatters: (widget.onFilteringTextInputFormatter == null)
//             ? <TextInputFormatter>[]
//             : <TextInputFormatter>[widget.onFilteringTextInputFormatter!],
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.fromLTRB(5.px, 0, 5.px, 0),
//             filled: true,
//             fillColor:
//                 widget.fillColor ?? ColorConstants.scaffoldBackgroundColor,
//             hintText: widget.hint,
//             hintStyle: getTextNormal(
//                 colors: ColorConstants.cAppTextHint, size: 10.7.sp),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(8.sp)),
//                 borderSide: BorderSide(
//                     color: widget.borderColor ?? ColorConstants.cAppColors)),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(8.sp)),
//                 borderSide: BorderSide(
//                     color: widget.borderColor ?? ColorConstants.cAppColors)),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(8.sp)),
//                 borderSide: BorderSide(
//                     color: widget.borderColor ?? ColorConstants.cAppColors)),
//             focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(8.sp)),
//                 borderSide: BorderSide(
//                     color: widget.borderColor ?? ColorConstants.cAppColors)),
//             disabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(8.sp)),
//                 borderSide: BorderSide(
//                     color: widget.borderColor ?? ColorConstants.cAppColors))),
//         onTap: () {
//           if( widget.onTap !=null){
//             widget.onTap!();
//           }
//
//         });
//   }
// }
