// ignore_for_file: avoid_dynamic_calls, cascade_invocations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/text_styles_constants.dart';
import '../../my_outline_button.dart';
import '../download_data_view_model.dart';

class DownloadDataWidget extends StatefulWidget {
  final Function onCompleted;
  final List<String> selectedOptions;
  final bool isLatestChangeOnly;

  const DownloadDataWidget(
      {super.key,
      required this.onCompleted,
      required this.selectedOptions,
      required this.isLatestChangeOnly});

  @override
  State<StatefulWidget> createState() => _DownloadDataWidgetState();
}

class _DownloadDataWidgetState extends State<DownloadDataWidget> {
  String message = 'Downloading products ...';
  String? errorMessage;
  bool isCompleted = false;
  final viewModel = DownloadDataViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.startDownloading(
        _updateMessage, _onCompleted, _onError, widget.selectedOptions,
        onlyLatestChange: widget.isLatestChangeOnly);
  }

  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
          height: 300,
          width: 300,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: getWidgets()),
        ),
      );

  Widget getWidgets() {
    final widgets = List<Widget>.empty(growable: true);

    widgets.add(Text(
      'Syncing data from cloud',
      style:
          getText500(size: 13.sp, colors: ColorConstants.cAppButtonColour),
    ));

    widgets.add(const SizedBox(
      height: 20,
    ));

    if (!isCompleted) {
      widgets.add(
        const SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Color(0xFF5591B2),
          ),
        ),
      );

      widgets.add(const SizedBox(
        height: 20,
      ));
    }

    widgets.add(Text(message));

    widgets.add(const SizedBox(
      height: 10,
    ));

    if (errorMessage != null) {
      widgets.add(Text(errorMessage!));

      widgets.add(const SizedBox(
        height: 10,
      ));
    }

    widgets.add(Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
        child: MyOutlineButton(
            text: 'Cancel',
            height: 19.sp,
            mTextStyle: getText500(colors: ColorConstants.white, size: 11.sp),
            backgroundColor:
                WidgetStateProperty.all(ColorConstants.cAppButtonColour),
            onClick: _onCompleted)));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widgets,
    );
  }

  void _updateMessage(String mes) {
    setState(() {
      message = mes;
    });
  }

  void _onCompleted() {
    widget.onCompleted();
    Get.back();
  }

  void _onError(String mes) {
    setState(() {
      message = mes;
    });
  }
}
