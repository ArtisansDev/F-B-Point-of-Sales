import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/date_range_picker/models.dart';
import 'package:fnb_point_sale_base/common/date_range_picker/widgets/dialogs.dart';
import 'package:fnb_point_sale_base/common/date_range_picker/widgets/inputs/field.dart';
import 'package:fnb_point_sale_base/common/date_range_picker/widgets/typedefs.dart';

/// A [FormField] that wraps a [DateRangeField] and integrates with a form.
class DateRangeFormField extends FormField<DateRangeModel> {
  /// Creates a [DateRangeFormField].
  ///
  /// * [decoration] - The decoration to show around the field. If null, defaults to [InputDecoration].
  /// * [enabled] - Whether the field is enabled or not.
  /// * [initialValue] - The initial [DateRange] for the field.
  /// * [pickerBuilder] - A builder to construct the date range picker widget.
  /// * [onSaved] - Called when the form is saved.
  /// * [validator] - Called to validate the field value when the form is submitted.
  /// * [builder] - A builder to construct the child widget of the field.
  /// * [dialogFooterBuilder] - A builder to construct the footer widget of the dialog.
  /// * [showDateRangePicker] - A function to show the date range picker dialog, defaults to [showDateRangePickerDialogOnWidget].
  DateRangeFormField({
    Key? key,
    InputDecoration? decoration,
    bool enabled = true,
    DateRangeModel? initialValue,
    required DateRangerPickerWidgetBuilder pickerBuilder,
    FormFieldSetter<DateRangeModel>? onSaved,
    FormFieldValidator<DateRangeModel>? validator,
    Future<DateRangeModel?> Function({
      required BuildContext widgetContext,
      required DateRangerPickerWidgetBuilder pickerBuilder,
    }) showDateRangePicker = showDateRangePickerDialogOnWidget,
    Widget Function({DateRangeModel? selectedDateRange})? dialogFooterBuilder,
    Widget Function(BuildContext, DateRangeModel?)? builder,
  }) : super(
          key: key,
          initialValue:
              initialValue ?? DateRangeModel(DateTime.now(), DateTime.now()),
          onSaved: onSaved,
          validator: validator,
          builder: (FormFieldState<DateRangeModel> state) {
            final selectedDateRange = state.value;
            final inputDecoration =
                (decoration ?? const InputDecoration()).applyDefaults(
              Theme.of(state.context).inputDecorationTheme,
            );

            return DateRangeField(
              showDateRangePicker: showDateRangePicker,
              dialogFooterBuilder: dialogFooterBuilder,
              // decoration: inputDecoration.copyWith(errorText: state.errorText),
              enabled: enabled,
              selectedDateRange: selectedDateRange,
              onDateRangeSelected: enabled
                  ? (dateRange) {
                      state.didChange(dateRange);
                    }
                  : null,
              childBuilder: builder,
              pickerBuilder: pickerBuilder,
            );
          },
        );
}
