/*
 * Project      : skill_360
 * File         : view_doument.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-08-30
 * Version      : 1.0
 * Ticket       : 
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/view_document/view_document_model.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ViewDocument extends StatelessWidget {
  final ViewDocumentModel mViewDocumentModel;

  ViewDocument({super.key, required this.mViewDocumentModel});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBarsCommon.appBarBack((value) {},
      //     title: mViewDocumentModel.mViewDocumentTitle ?? sViewDocument.tr,
      //     dTitleSpacing: 0.sp,
      //     myProfile: true),
      body: SafeArea(child: _fullView()),
    );
  }

  RxBool isReady = false.obs;

  _fullView() {
    return Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(17.sp),
        color: Colors.white,
        child: Stack(
          children: [
            Obx(
              () {
                return !isReady.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container();
              },
            ),
            PDFView(
              filePath: mViewDocumentModel.localFilePath ?? '',
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: true,
              pageSnap: true,
              onRender: (_pages) {
                isReady.value = true;
              },
              onError: (error) {
                print(error.toString());
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {},
            ),
          ],
        ));
  }
}
