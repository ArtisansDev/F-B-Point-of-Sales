/*
 * Project      : fnb_point_sale_app
 * File         : table_row_view.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-21
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/customer_controller.dart';

class CustomerListRowView extends StatelessWidget {
  late CustomerController controller;
  late int index;

  CustomerListRowView({super.key, required this.index}) {
    controller = Get.find<CustomerController>();
  }

  @override
  Widget build(BuildContext context) {
    GetAllCustomerList mGetAllCustomerList =
        controller.mSelectCustomerList.value?[index] ?? GetAllCustomerList();
    return Container(
      padding:
          EdgeInsets.only(top: 11.sp, left: 11.sp, right: 11.sp, bottom: 11.sp),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5.sp),
            alignment: Alignment.center,
            // decoration: const BoxDecoration(
            //   color: ColorConstants.cAppButtonColour,
            //   shape: BoxShape.circle,
            // ),
            width: 15.sp,
            // child: Icon(
            //   Icons.add,
            //   color: ColorConstants.white,
            //   size: 14.sp,
            // ),
          ),
          Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  (mGetAllCustomerList.srNo ?? '').toString(),
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 10.5.sp),
                ),
              )),
          Expanded(
              flex: 6,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  mGetAllCustomerList.name ?? '',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 11.sp),
                ),
              )),
          Expanded(
              flex: 6,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '${mGetAllCustomerList.phoneCountryCode ?? ''} ${mGetAllCustomerList.phoneNumber ?? ''}',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 11.sp),
                ),
              )),
          Expanded(
              flex: 6,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  mGetAllCustomerList.email ?? '',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 11.sp),
                ),
              )),
          Expanded(
              flex: 9,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  mGetAllCustomerList.address ?? '',
                  style: getTextRegular(
                      colors: ColorConstants.appTextSalesHader, size: 11.sp),
                ),
              )),
        ],
      ),
    );
    ;
  }
}
