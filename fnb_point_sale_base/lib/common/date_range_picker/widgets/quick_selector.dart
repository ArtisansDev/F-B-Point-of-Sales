import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/date_range_picker/models.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


/// A widget that displays a list of quick dateRanges that can be selected.
class QuickSelectorWidget extends StatelessWidget {
  const QuickSelectorWidget({
    Key? key,
    required this.selectedDateRange,
    required this.quickDateRanges,
    required this.onDateRangeChanged,
    required this.theme,
  }) : super(key: key);

  /// The dateRange that is currently selected. A line will be displayed on the left
  /// using the [CalendarTheme.selectedQuickDateRangeColor] color.
  final DateRangeModel? selectedDateRange;

  /// The list of quick dateRanges to display.
  final List<QuickDateRange> quickDateRanges;

  /// Called when a quick dateRange is selected.
  final ValueChanged<DateRangeModel?> onDateRangeChanged;

  /// The theme of the calendar.
  final CalendarTheme theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child:
        Column(
            children: [
              SizedBox(height: 2.h,),
              Expanded(child: ListView(
                children: [
                  for (final quickDateRange in quickDateRanges)
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(2)),
                            color: quickDateRange.dateRange == selectedDateRange
                                ? theme.selectedQuickDateRangeColor ??
                                Theme
                                    .of(context)
                                    .primaryColor
                                : Colors.transparent,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () =>
                                  onDateRangeChanged(quickDateRange.dateRange),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  quickDateRange.label,
                                  textAlign: TextAlign.left,
                                  style: getText500(
                                      colors: ColorConstants.black,
                                      size: 11.5.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              )),
            ])
    );
  }
}
