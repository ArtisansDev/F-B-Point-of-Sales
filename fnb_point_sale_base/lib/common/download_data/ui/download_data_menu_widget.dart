// ignore_for_file: cascade_invocations, avoid_dynamic_calls, inference_failure_on_function_invocation, prefer_foreach, depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/text_styles_constants.dart';
import '../../../utils/network_utils.dart';
import '../../my_outline_button.dart';
import '../download_data_view_model.dart';

class DownloadDataMenuWidget extends StatefulWidget {
  final Function onCompleted;
  final Function onCancel;
  final Function updateMessage;
  final Function onError;

  const DownloadDataMenuWidget(
      {super.key,
      required this.onCompleted,
      required this.onCancel,
      required this.onError,
      required this.updateMessage});

  @override
  State<DownloadDataMenuWidget> createState() => _DownloadDataMenuWidgetState();
}

class _DownloadDataMenuWidgetState extends State<DownloadDataMenuWidget> {
  List<String> selectedDownloadOptions = List.empty(growable: true);
  List<String> values = List.empty(growable: true);
  DownloadDataViewModel viewModel = DownloadDataViewModel();

  @override
  void initState() {
    values
      ..addAll(DownloadDataMenu.values)
      ..sort((a, b) => a.compareTo(b));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
          height: 78.h,
          width: 65.h,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: getWidgets()),
        ),
      );

  Widget getWidgets() {
    final widgets = List<Widget>.empty(growable: true);

    widgets.add(SizedBox(
      height: 18.sp,
    ));

    widgets.add(Text(
      'Select option for download data',
      style: getText500(size: 13.sp, colors: ColorConstants.cAppButtonColour),
    ));

    widgets.add(SizedBox(
      height: 15.sp,
    ));

    widgets.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: 35.sp,
          child: MyOutlineButton(
              text: (selectedDownloadOptions.length == values.length)
                  ? 'Clear'
                  : 'Select All',
              height: 19.sp,
              mTextStyle: getText500(colors: ColorConstants.white, size: 11.sp),
              backgroundColor:
                  WidgetStateProperty.all(ColorConstants.cAppButtonColour),
              onClick: () {
                if (selectedDownloadOptions.length == values.length) {
                  selectedDownloadOptions.clear();
                } else {
                  for (final mDownloadDataMenu in values) {
                    selectedDownloadOptions.add(mDownloadDataMenu);
                  }
                }
                setState(() {});
              }),
        )));

    widgets.add(SizedBox(
      height: 11.sp,
    ));

    widgets.add(Expanded(
      child: ListView.separated(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) => CheckboxListTile(
                dense: true,
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: ColorConstants.cAppButtonColour,
                value: selectedDownloadOptions.contains(values[index]),
                onChanged: (value) {
                  setState(() {
                    if (value ?? false) {
                      selectedDownloadOptions.add(values[index]);
                    } else {
                      selectedDownloadOptions.remove(values[index]);
                    }
                  });
                },
                title: Text(
                  values[index],
                  style: getTextRegular(
                      size: 11.5.sp, colors: ColorConstants.black),
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: NetworkUtils().isTypeCheck() ? 0 : 4,
              ),
          itemCount: values.length),
    ));

    widgets.add(const SizedBox(
      height: 20,
    ));

    widgets.add(Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                  left: NetworkUtils().isTypeCheck() ? 10.sp : 20, right: 0),
              child: MyOutlineButton(
                  text: 'Cancel',
                  height: 19.sp,
                  mTextStyle: getText500(
                      colors: ColorConstants.cAppButtonColour, size: 11.sp),
                  backgroundColor: WidgetStateProperty.all(ColorConstants.white),
                  onClick: () {
                    selectedDownloadOptions.clear();
                    widget.onCancel();
                  })
            )),
        SizedBox(
          width: NetworkUtils().isTypeCheck() ? 10.sp : 0,
        ),
        Expanded(
            child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(
              left: NetworkUtils().isTypeCheck() ? 0 : 20,
              right: NetworkUtils().isTypeCheck() ? 10.sp : 20),
          child: MyOutlineButton(
              text: 'Download Full Data',
              height: 19.sp,
              mTextStyle: getText500(colors: ColorConstants.white, size: 11.sp),
              backgroundColor:
                  WidgetStateProperty.all(ColorConstants.cAppButtonColour),
              onClick: () => _downloadProductsDialog(false)),
        ))
      ],
    ));

    // widgets.add(SizedBox(
    //   height: 10.sp,
    // ));
    //
    // widgets.add(Container(
    //     width: 18.w,
    //     margin: const EdgeInsets.only(left: 20, right: 20),
    //     child:  MyOutlineButton(
    //         text: 'Download Latest Changes',
    //         height: 19.sp,
    //         mTextStyle:
    //         getText500(colors: ColorConstants.white, size: 11.sp),
    //         backgroundColor:
    //         WidgetStateProperty.all(ColorConstants.cAppButtonColour),
    //         onClick: () => _downloadProductsDialog(true))));

    widgets.add(SizedBox(
      height: 15.sp,
    ));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widgets,
    );
  }

  Future<void> _downloadProductsDialog(bool isLatestChangeOnly) async {
    Navigator.of(context).pop();
    unawaited(viewModel.startDownloading(widget.updateMessage,
        widget.onCompleted, widget.onError, selectedDownloadOptions,
        onlyLatestChange: isLatestChangeOnly));
  }
}
