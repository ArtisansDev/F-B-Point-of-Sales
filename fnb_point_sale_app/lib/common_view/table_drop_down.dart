import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_tables/get_all_tables_response.dart';
import 'package:fnb_point_sale_base/data/mode/table_status/get_all_tables_by_table_status_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

///partha paul
///customer_drop_down
///02/01/25

// Rxn<PlaceOrderSaleModel> mPlaceOrderSaleModel = Rxn<PlaceOrderSaleModel>();
List<GetAllTablesResponseData> selectGetAllTablesResponseData = [];

allOrderPlace() async {
  // var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();
  // mPlaceOrderSaleModel.value =
  //     await mPlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
  //         PlaceOrderSaleModel();
}

showTableBottomSheet(
    List<GetAllTablesResponseData> mGetAllTablesList,
    List<TablesByTableStatusData> mTablesByTableStatusData,
    Function onGetDetails) async {
  // await allOrderPlace();
  selectGetAllTablesResponseData.clear();
  selectGetAllTablesResponseData.addAll(mGetAllTablesList.toList());

  List<GetAllTablesResponseData> selectTablesData = [];

  for (TablesByTableStatusData mOrderPlace in mTablesByTableStatusData ?? []) {
    selectTablesData.clear();
    selectTablesData.addAll(selectGetAllTablesResponseData.toList());

    selectGetAllTablesResponseData.clear();
    selectGetAllTablesResponseData.addAll(selectTablesData.where(
      (element) {
        if (mOrderPlace.seatIDP.toString() != element.seatIDP.toString() &&
            (!(element.isDeleted ?? false) && (element.isActive ?? false))) {
          return true;
        } else {
          return false;
        }
      },
    ).toList());
  }

  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true, // Allows the BottomSheet to expand
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8.sp)),
    ),
    builder: (BuildContext context) {
      TextEditingController phoneNumberSearchController =
          TextEditingController();
      RxList<GetAllTablesResponseData> filteredItems =
          selectGetAllTablesResponseData.obs;
      return Container(
        height: 69.h,
        width: 35.w,
        padding: MediaQuery.of(context).viewInsets, // Handle keyboard overlap
        child: Column(
          mainAxisSize: MainAxisSize.min, // Wrap content
          children: [
            SizedBox(height: 12.sp),
            Text(
              'Select Seating',
              style: getText500(
                  colors: ColorConstants.appTextSalesHader, size: 12.5.sp),
            ),
            SizedBox(height: 12.sp),
            Container(
                height: 20.sp,
                margin: EdgeInsets.only(left: 13.sp, right: 13.sp),
                child: TextInputWidget(
                  placeHolder: sSeatingNo.tr,
                  controller: phoneNumberSearchController,
                  errorText: null,
                  textInputType: TextInputType.phone,
                  hintText: sSeatingNo.tr,
                  hintTextColor: ColorConstants.black.withOpacity(0.80),
                  showFloatingLabel: false,
                  topPadding: 5.sp,
                  hintTextSize: 10.5.sp,
                  textSize: 10.5.sp,
                  onFilteringTextInputFormatter: [
                    FilteringTextInputFormatter.allow(
                      RegExp(AppUtilConstants.patternCompanyName),
                    ),
                    LengthLimitingTextInputFormatter(10)
                  ],
                  onTextChange: (value) {
                    filteredItems.value = selectGetAllTablesResponseData
                        .where((item) => item.seatNumber
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
                      onTap: () {},
                      child: Container(
                          height: 25.sp,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          padding: EdgeInsets.all(10.sp),
                          margin: EdgeInsets.only(
                              bottom: 8.sp, left: 15.sp, right: 14.sp),
                          alignment: Alignment.center,
                          child: Text(
                            "No table found",
                            textAlign: TextAlign.center,
                            style: getText500(
                                colors: ColorConstants.appTextSalesHader,
                                size: 11.5.sp),
                          )),
                    )
                  : Expanded(
                      child: ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        GetAllTablesResponseData mGetAllTablesResponseData =
                            filteredItems[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context, mGetAllTablesResponseData);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                              padding: EdgeInsets.all(10.sp),
                              margin: EdgeInsets.only(
                                  bottom: 8.sp, left: 15.sp, right: 14.sp),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    (mGetAllTablesResponseData.seatNumber ?? '')
                                            .isEmpty
                                        ? '--'
                                        : (mGetAllTablesResponseData
                                                .seatNumber ??
                                            ''),
                                    style: getText500(
                                        colors:
                                            ColorConstants.appTextSalesHader,
                                        size: 11.sp),
                                  )),
                                  Text(
                                    '${mGetAllTablesResponseData.seatingCapacity ?? ''} Seat(s)',
                                    style: getText500(
                                        colors: ColorConstants.cAppButtonColour,
                                        size: 11.sp),
                                  )
                                ],
                              )),
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
      GetAllTablesResponseData mGetAllTablesResponseData = value;
      onGetDetails(mGetAllTablesResponseData);
    }
  });
}
