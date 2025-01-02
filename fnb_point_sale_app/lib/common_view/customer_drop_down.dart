import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

///partha paul
///customer_drop_down
///02/01/25

void showCustomerBottomSheet(
    List<GetAllCustomerList> allCustomerList, Function onGetDetails) {
  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true, // Allows the BottomSheet to expand
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8.sp)),
    ),
    builder: (BuildContext context) {
      TextEditingController phoneNumberSearchController =
      TextEditingController();
      RxList<GetAllCustomerList> filteredItems = allCustomerList.obs;
      return Container(
        height: 69.h,
        width: 40.w,
        padding: MediaQuery.of(context).viewInsets, // Handle keyboard overlap
        child: Column(
          mainAxisSize: MainAxisSize.min, // Wrap content
          children: [
            SizedBox(height: 12.sp),
            Text(
              'Select customer',
              style: getText500(
                  colors: ColorConstants.appTextSalesHader, size: 12.5.sp),
            ),
            SizedBox(height: 12.sp),
            Container(
                height: 20.sp,
                margin: EdgeInsets.only(left: 13.sp, right: 13.sp),
                child: TextInputWidget(
                  placeHolder: sPhoneNumber.tr,
                  controller: phoneNumberSearchController,
                  errorText: null,
                  textInputType: TextInputType.phone,
                  hintText: sPhoneNumber.tr,
                  hintTextColor: ColorConstants.black.withOpacity(0.80),
                  showFloatingLabel: false,
                  topPadding: 5.sp,
                  hintTextSize: 10.5.sp,
                  textSize: 10.5.sp,
                  onFilteringTextInputFormatter: [
                    FilteringTextInputFormatter.allow(
                      RegExp(AppUtilConstants.patternOnlyNumber),
                    ),
                    LengthLimitingTextInputFormatter(10)
                  ],
                  onTextChange: (value) {
                    filteredItems.value = allCustomerList
                        .where((item) => item.phoneNumber
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                        .toList();
                  },
                )),
            SizedBox(height: 12.sp),
            Obx(
                  () => filteredItems.isEmpty
                  ? GestureDetector(
                onTap: () {
                  GetAllCustomerList mGetAllCustomerList =
                  GetAllCustomerList(
                      name: "_new_",
                      phoneNumber:
                      phoneNumberSearchController.text);
                  Navigator.pop(context, mGetAllCustomerList);
                },
                child: Container(
                  height: 25.sp,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  padding: EdgeInsets.all(10.sp),
                  margin: EdgeInsets.only(
                      bottom: 8.sp, left: 15.sp, right: 14.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "New phone number",
                            style: getText500(
                                colors:
                                ColorConstants.appTextSalesHader,
                                size: 11.5.sp),
                          ),
                          Text(
                            phoneNumberSearchController.text,
                            style: getText500(
                                colors:
                                ColorConstants.appTextSalesHader,
                                size: 11.5.sp),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
                  : Expanded(
                  child: ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      GetAllCustomerList mGetAllCustomerList =
                      filteredItems[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context, mGetAllCustomerList);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          padding: EdgeInsets.all(10.sp),
                          margin: EdgeInsets.only(
                              bottom: 8.sp, left: 15.sp, right: 14.sp),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (mGetAllCustomerList.name ?? '').isEmpty
                                    ? '--'
                                    : (mGetAllCustomerList.name ?? ''),
                                style: getTextRegular(
                                    colors:
                                    ColorConstants.appTextSalesHader,
                                    size: 11.5.sp),
                              ),
                              SizedBox(
                                height: 5.sp,
                              ),
                              Row(
                                children: [
                                  Text(
                                    (mGetAllCustomerList.phoneCountryCode ??
                                        '')
                                        .isEmpty
                                        ? '--'
                                        : (mGetAllCustomerList
                                        .phoneCountryCode ??
                                        ''),
                                    style: getText500(
                                        colors: ColorConstants
                                            .appTextSalesHader,
                                        size: 11.sp),
                                  ),
                                  SizedBox(
                                    width: 5.sp,
                                  ),
                                  Text(
                                    (mGetAllCustomerList.phoneNumber ?? '')
                                        .isEmpty
                                        ? '--'
                                        : (mGetAllCustomerList
                                        .phoneNumber ??
                                        ''),
                                    style: getText500(
                                        colors: ColorConstants
                                            .appTextSalesHader,
                                        size: 11.sp),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),
            SizedBox(height: 12.sp),
          ],
        ),
      );
    },
  ).then((value) {
    if (value != null) {
      GetAllCustomerList mGetAllCustomerList = value;
      onGetDetails(mGetAllCustomerList);
    }
  });
}