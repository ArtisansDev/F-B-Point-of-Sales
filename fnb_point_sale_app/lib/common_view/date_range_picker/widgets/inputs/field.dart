import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/common_view/date_range_picker/models.dart';
import 'package:fnb_point_sale_app/common_view/date_range_picker/widgets/dialogs.dart';
import 'package:fnb_point_sale_app/common_view/date_range_picker/widgets/typedefs.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

/// A [StatelessWidget] that provides a field to select a date range dateRange.
class DateRangeField extends StatelessWidget {
  /// Creates a [DateRangeField].
  ///
  /// * [decoration] - The decoration to show around the field. If null, defaults to [InputDecoration].
  /// * [selectedDateRange] - The selected date range for the field.
  /// * [onDateRangeSelected] - Called when a date range is selected.
  /// * [childBuilder] - A builder to construct the child widget of the field.
  /// * [enabled] - Whether the field is enabled or not.
  /// * [pickerBuilder] - A builder to construct the date range picker widget.
  /// * [dialogFooterBuilder] - A builder to construct the footer widget of the dialog.
  /// * [showDateRangePicker] - A function to show the date range picker dialog, defaults to [showDateRangePickerDialogOnWidget].
  const DateRangeField({
    super.key,
    this.imageString,
    this.selectedDateRange,
    this.onDateRangeSelected,
    this.childBuilder,
    this.dialogFooterBuilder,
    this.enabled = true,
    required this.pickerBuilder,
    this.showDateRangePicker = showDateRangePickerDialogOnWidget,
  });

  final Widget Function({DateRangeModel? selectedDateRange})?
      dialogFooterBuilder;
  final DateRangerPickerWidgetBuilder pickerBuilder;
  final String? imageString;

  // final InputDecoration? decoration;
  final bool enabled;
  final DateRangeModel? selectedDateRange;
  final ValueChanged<DateRangeModel?>? onDateRangeSelected;
  final Widget Function(BuildContext, DateRangeModel?)? childBuilder;
  final Future<DateRangeModel?> Function({
    required BuildContext widgetContext,
    required DateRangerPickerWidgetBuilder pickerBuilder,
  }) showDateRangePicker;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: generateOnTap(context),
        child: Container(
          margin: EdgeInsets.only(right: 5.sp),
          height: 21.sp,
          width: 21.sp,
          padding: EdgeInsets.all(9.5.sp),
          decoration: BoxDecoration(
            color: ColorConstants.cAppButtonColour,
            borderRadius: BorderRadius.all(
              Radius.circular(8.sp),
            ),
          ),
          child: Image.asset(
            imageString ?? '',
            height: 2.2.w,
            width: 2.2.w,
          ),
        ));
  }

  VoidCallback? generateOnTap(BuildContext context) {
    if (enabled) {
      return () async {
        final DateRangeModel? dateRange = await showDateRangePicker(
          widgetContext: context,
          pickerBuilder: pickerBuilder,
        );

        onDateRangeSelected?.call(dateRange);
      };
    } else {
      return null;
    }
  }
}
