import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/details_screen_controller.dart';

class TransactionInfoScreen extends StatelessWidget {
  late DetailsScreenController controller;

  TransactionInfoScreen({super.key}) {
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
                sTransactionInfo.tr,
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
                  color: ColorConstants.cShiftDetailsColour1,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.sp),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(11.sp),
                      height: 21.sp,
                      width: 21.sp,
                      decoration: BoxDecoration(
                        color: ColorConstants.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.sp),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        (controller.mShiftDetailsController.mShiftDetailsResponse
                            .value.data?.salesCount ??0).toString(),
                        style:
                        getText500(size: 11.5.sp, colors: ColorConstants.black),
                      ),
                    ),
                    SizedBox(
                      width: 11.sp,
                    ),
                    Text(
                      sSales.tr,
                      style:
                          getText500(size: 11.sp, colors: ColorConstants.black),
                    ),
                  ],
                ),
              )),
              SizedBox(
                width: 10.sp,
              ),
              // Expanded(
              //     child: Container(
              //   padding: EdgeInsets.all(11.sp),
              //   decoration: BoxDecoration(
              //     color: ColorConstants.cShiftDetailsColour2,
              //     borderRadius: BorderRadius.all(
              //       Radius.circular(8.sp),
              //     ),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Container(
              //         padding: EdgeInsets.all(11.sp),
              //         height: 21.sp,
              //         width: 21.sp,
              //         decoration: BoxDecoration(
              //           color: ColorConstants.white,
              //           borderRadius: BorderRadius.all(
              //             Radius.circular(8.sp),
              //           ),
              //         ),
              //         alignment: Alignment.center,
              //         child: Text(
              //           (controller.mShiftDetailsController.mShiftDetailsResponse
              //               .value.data?.refundCount ??0).toString(),
              //           style:
              //           getText500(size: 11.5.sp, colors: ColorConstants.black),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 11.sp,
              //       ),
              //       Text(
              //         sRefund.tr,
              //         style:
              //         getText500(size: 11.sp, colors: ColorConstants.black),
              //       ),
              //     ],
              //   ),
              // )),
              // SizedBox(
              //   width: 10.sp,
              // ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(11.sp),
                      height: 21.sp,
                      width: 21.sp,
                      decoration: BoxDecoration(
                        color: ColorConstants.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.sp),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        (controller.mShiftDetailsController.mShiftDetailsResponse
                            .value.data?.voucherGenerateCount ??0).toString(),
                        style:
                        getText500(size: 11.5.sp, colors: ColorConstants.black),
                      ),
                    ),
                    SizedBox(
                      width: 11.sp,
                    ),
                    Text(
                      sVouchersCreate.tr,
                      style:
                      getText500(size: 11.sp, colors: ColorConstants.black),
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
