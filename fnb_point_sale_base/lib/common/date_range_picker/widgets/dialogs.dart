import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/date_range_picker/models.dart';
import 'package:fnb_point_sale_base/common/date_range_picker/widgets/typedefs.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


/// A function to show the dateRange picker dialog.
///
/// * [context] - The context of the dialog.
/// * [builder] - A builder to construct the date range picker widget.
///  * [barrierColor] - The color of the barrier.
///  * [footerBuilder] - A builder to construct the footer widget of the dialog.
///  * [offset] - The offset of the dialog from the widget.
///  * [onDateRangeSelected] - Called when a date range is selected.
Future<DateRangeModel?> showDateRangePickerDialog({
  required BuildContext context,
  required DateRangerPickerWidgetBuilder builder,
  Color barrierColor = Colors.grey,
  Widget Function({DateRangeModel? selectedDateRange})? footerBuilder,
  Offset? offset,
}) {
  return showGeneralDialog(
    context: context,
    barrierLabel: 'DateRangePickerDialogBarrier',
    // barrierColor: const Color(0xd3000000),
    barrierDismissible: true,
    pageBuilder: (_, __, ___) {
      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
            child: Container(
                color: Colors.black
                    .withOpacity(0.2)), // Optional: Add overlay color
          ),
          Center(
            child: DateRangePickerDialog(
              builder: builder,
              footerBuilder: footerBuilder ?? DateRangePickerDialogFooter.new,
            ),
          ),
        ],
      );
    },
  );
}

/// A function to show the dateRange picker dialog on a widget.
/// * [widgetContext] - The context of the widget that will be used to show the dialog.
/// * [context] - The context of the dialog. If null, the [widgetContext] will be used.
/// * [dialogFooterBuilder] - A builder to construct the footer widget of the dialog.
/// * [pickerBuilder] - A builder to construct the date range picker widget.
/// * [delta] - The offset of the dialog from the widget.
/// * [onDateRangeSelected] - Called when a date range is selected.
/// * [barrierColor] - The color of the barrier.
Future<DateRangeModel?> showDateRangePickerDialogOnWidget({
  required BuildContext widgetContext,
  required DateRangerPickerWidgetBuilder pickerBuilder,
  BuildContext? context,
  Color barrierColor = Colors.transparent,
  Widget Function({DateRangeModel? selectedDateRange})? dialogFooterBuilder,
  Offset delta = const Offset(0, 60),
}) async {
  // Compute widget position on screen
  final RenderBox renderBox = widgetContext.findRenderObject() as RenderBox;
  final Offset offset = renderBox.localToGlobal(Offset.zero);

  // Show the dateRange picker dialog and get the selected date range
  final dateRange = await showDateRangePickerDialog(
    context: context ?? widgetContext,
    footerBuilder: dialogFooterBuilder,
    barrierColor: ColorConstants.cAppTaxColour.withOpacity(0.05),
    builder: pickerBuilder,
    offset: offset + delta,
  );

  return dateRange;
}

/// A dialog for selecting a date range dateRange.
class DateRangePickerDialog extends StatefulWidget {
  const DateRangePickerDialog({
    super.key,
    required this.builder,
    required this.footerBuilder,
  });

  /// A function that builds a widget that will be used to display the date range picker.
  final DateRangerPickerWidgetBuilder builder;

  /// A function that builds a widget that will be used to display the footer.
  /// The selected dateRange will be passed to the footer builder. It can be null if
  /// no dateRange is selected yet.
  final Widget Function({DateRangeModel? selectedDateRange}) footerBuilder;

  @override
  State<DateRangePickerDialog> createState() => _DateRangePickerDialogState();
}

class _DateRangePickerDialogState extends State<DateRangePickerDialog> {
  DateRangeModel? dateRange;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 0,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // The date range picker widget
                SizedBox(height: 10.sp,),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                  ),
                  child: widget.builder(context, (dateRange) {
                    setState(() {
                      this.dateRange = dateRange;
                    });
                  }),
                ),
                widget.footerBuilder(selectedDateRange: dateRange),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// The default footer for the dateRange picker dialog.
class DateRangePickerDialogFooter extends StatelessWidget {
  const DateRangePickerDialogFooter({
    super.key,
    this.selectedDateRange,
    this.cancelText = "Cancel",
    this.confirmText = "Confirm",
  });

  final String cancelText;
  final String confirmText;
  final DateRangeModel? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 12.w,
            height: 18.sp,
            child:  rectangleCornerButtonText500(
              cancelText,
              textSize: 11.sp,
                  () {
                Navigator.of(context).pop(selectedDateRange);
              },
            )
            ,)
          ,
          SizedBox(
            width: 20.sp,
          ), SizedBox(width: 12.w,
              height: 18.sp,
              child:
              rectangleCornerButtonText500(
                confirmText,
                textSize: 11.sp,
                    () {
                      Navigator.of(context).pop(selectedDateRange);
                },
              )
          ),
        ],
      ),
    );
  }
}
