import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/details_screen_controller.dart';

class PaymentDeclarationScreen extends StatelessWidget {
  late DetailsScreenController controller;

  PaymentDeclarationScreen({super.key}) {
    controller = Get.find<DetailsScreenController>();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 13.sp, right: 13.sp, top: 12.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sPaymentDeclaration.tr,
                style: getText500(
                    size: 11.sp, colors: ColorConstants.cAppButtonColour),
              ),
              SizedBox(
                width: 13.w,
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 13.sp, right: 13.sp, top: 12.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Container(
                    padding: EdgeInsets.all(11.sp),
                    decoration: BoxDecoration(
                      color: ColorConstants.cShiftDetailsColour3,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.sp),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sCash.tr,
                          style: getText500(
                              size: 11.sp, colors: ColorConstants.black),
                        ),
                        SizedBox(height: 8.sp,),
                        Text(
                          'RM 0.00',
                          style: getText500(
                              size: 11.sp, colors: ColorConstants.black),
                        ),
                      ],
                    ),
                  )),
              SizedBox(width: 10.sp,),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.all(11.sp),
                    decoration: BoxDecoration(
                      color: ColorConstants.cShiftDetailsColour2,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.sp),
                      ),
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sBookingPayment.tr,
                          style: getText500(
                              size: 11.sp, colors: ColorConstants.black),
                        ),
                        SizedBox(height: 8.sp,),
                        Text(
                          'RM 0.00',
                          style: getText500(
                              size: 11.sp, colors: ColorConstants.black),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
