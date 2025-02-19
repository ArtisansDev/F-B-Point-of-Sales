// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/payment_type/payment_type_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
import 'package:fnb_point_sale_base/data/mode/order_history/order_history_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../common_view/customer_drop_down.dart';
import '../../../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../../../menu_customer/customer_utils/add_customer.dart';

class ItemPaymentScreenController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rxn<Function> onPaymentClick = Rxn<Function>();
  Rxn<OrderHistoryData> mOrderPlace = Rxn<OrderHistoryData>();
  Rxn<GetAllCustomerList> mSelectCustomer = Rxn<GetAllCustomerList>();
  RxString phoneCode = '60'.obs;

  ItemPaymentScreenController(
      OrderHistoryData selectOrderPlace, Function onPayment) {
    onPaymentClick.value = onPayment;
    mOrderPlace.value = selectOrderPlace;
    nameController.value.text = mOrderPlace.value?.name ?? '';
    phoneNumberController.value.text = mOrderPlace.value?.phoneNumber ?? '';
    if ((mOrderPlace.value?.phoneCountryCode ?? '').isNotEmpty) {
      phoneCode.value = (mOrderPlace.value?.phoneCountryCode ?? '')
          .substring(1, (mOrderPlace.value?.phoneCountryCode ?? '').length);
    }
    mOrderPlace.refresh();
    loadPaymentType();
    getAllCustomer();
  }

  Rxn<GetAllPaymentTypeResponse> mGetAllPaymentTypeResponse =
      Rxn<GetAllPaymentTypeResponse>();
  RxList<GetAllPaymentTypeData> mGetAllPaymentTypeData =
      <GetAllPaymentTypeData>[].obs;

  loadPaymentType() async {
    var mPaymentTypeLocalApi = locator.get<PaymentTypeLocalApi>();
    mGetAllPaymentTypeResponse.value =
        await mPaymentTypeLocalApi.getPaymentTypeResponse() ??
            GetAllPaymentTypeResponse();
    mGetAllPaymentTypeData.clear();
    mGetAllPaymentTypeData.addAll(mGetAllPaymentTypeResponse.value?.data ?? []);
    mGetAllPaymentTypeResponse.refresh();
    mGetAllPaymentTypeData.refresh();
  }

  RxBool isSelectPayment = false.obs;
  Rx<GetAllPaymentTypeData> mGetAllPaymentType = GetAllPaymentTypeData().obs;

  isSelectPaymentType(index) {
    for (int i = 0; i < mGetAllPaymentTypeData.length; i++) {
      mGetAllPaymentTypeData[i].setIsSelect(false);
    }
    isSelectPayment.value = true;
    mGetAllPaymentTypeData[index].setIsSelect(true);
    mGetAllPaymentType.value = mGetAllPaymentTypeData[index];
    mGetAllPaymentTypeData.refresh();
    isSelectPayment.refresh();
  }

  void onPrint() async {
    if (mSelectCustomer.value != null) {
      if (mSelectCustomer.value?.name.toString() == '_new_') {
        AddCustomer mAddCustomer = AddCustomer(
            name: nameController.value.text,
            phoneCode: phoneCode.value,
            phone: phoneNumberController.value.text,
            onSelectCustomer: (GetAllCustomerList mGetAllCustomerList) {
              mSelectCustomer.value = mGetAllCustomerList;
              onPaymentClick.value!(
                  mGetAllPaymentType.value, mSelectCustomer.value);
            });
        await mAddCustomer.onSubmit();
      } else {
        onPaymentClick.value!(mGetAllPaymentType.value, mSelectCustomer.value);
      }
    } else {
      onPaymentClick.value!(mGetAllPaymentType.value, mSelectCustomer.value);
    }
  }

  ///

  getAllCustomer({bool showCustomer = false}) async {
    List<GetAllCustomerList> allCustomerList = [];
    await mDashboardScreenController.getAllCustomerList();
    allCustomerList.clear();
    allCustomerList
        .addAll((mDashboardScreenController.mAllCustomerList.value ?? []));

    if (showCustomer) {
      showCustomerBottomSheet(allCustomerList,
          (GetAllCustomerList mGetAllCustomerList) {
        debugPrint('Selected: ${jsonEncode(mGetAllCustomerList)}');
        mSelectCustomer.value = mGetAllCustomerList;
        phoneNumberController.value.text =
            mGetAllCustomerList.phoneNumber ?? '';
        nameController.value.text = "";
        if (mGetAllCustomerList.name != "_new_") {
          nameController.value.text = mGetAllCustomerList.name ?? '';
        }
      });
    }
  }
}
