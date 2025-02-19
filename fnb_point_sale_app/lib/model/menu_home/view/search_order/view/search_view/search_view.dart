import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../home_base_controller/home_base_controller.dart';

class SearchView extends StatelessWidget {
  late HomeBaseController controller;
  SearchView({super.key}) {
    controller = Get.find<HomeBaseController>();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 8.sp, bottom: 8.sp),
        padding:
            EdgeInsets.only( left: 8.sp),
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8.sp),
          ),
        ),
        child: Row(
          children: [

            Expanded(child:  Container(
              height: 22.sp,
                alignment: Alignment.center,
                margin: EdgeInsets.only( right: 13.sp),
                child: TextInputWidget(
                  placeHolder: sSearchItems.tr,
                  controller: HomeBaseController.searchController.value,
                  errorText: null,
                  onTextChange: (value){
                    controller.onSearchText(value);
                  },
                  textInputType: TextInputType.emailAddress,
                  hintText: sSearchItems.tr,
                  showFloatingLabel: false,
                  topPadding: 5.sp,
                  hintTextSize: 11.sp,
                  textSize: 11.5.sp,
                  hintTextColor: ColorConstants.cAppTaxColour,
                  borderSideColor: Colors.transparent,
                  onFilteringTextInputFormatter: [
                    FilteringTextInputFormatter.allow(
                        RegExp(AppUtilConstants.patternStringAndSpace)),
                  ],
                )),),
            GestureDetector(
              onTap: () {
                // Get.back();
              },
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
                  child:
                  Image.asset(
                    ImageAssetsConstants.appSearch,
                    fit: BoxFit.fitWidth,
                  ),
                ),
            )
          ],
        ));
  }

}
