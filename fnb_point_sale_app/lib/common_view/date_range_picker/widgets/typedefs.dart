import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/common_view/date_range_picker/models.dart';

/// A function that builds a widget that will be used to display the selected date range.
typedef DateRangerPickerWidgetBuilder = Widget Function(
  BuildContext context,
  Function(DateRangeModel? dateRange) onDateRangeChanged,
);
