// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/data/local/database/payment_type/payment_type_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:get/get.dart';
import '../../../common_view/customer_drop_down.dart';
import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../menu_customer/customer_utils/add_customer.dart';

class PaymentScreenController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rxn<Function> onPaymentClick = Rxn<Function>();
  Rxn<OrderPlace> mOrderPlace = Rxn<OrderPlace>();
  RxString phoneCode = '60'.obs;

  PaymentScreenController(OrderPlace selectOrderPlace, Function onPayment) {
    onPaymentClick.value = onPayment;
    mOrderPlace.value = selectOrderPlace;
    nameController.value.text = mOrderPlace.value?.mSelectCustomer?.name ?? '';
    phoneNumberController.value.text =
        mOrderPlace.value?.mSelectCustomer?.phoneNumber ?? '';
    if ((mOrderPlace.value?.mSelectCustomer?.phoneCountryCode ?? '')
        .isNotEmpty) {
      phoneCode.value =
          (mOrderPlace.value?.mSelectCustomer?.phoneCountryCode ?? '')
              .trim()
              .substring(
                  1,
                  (mOrderPlace.value?.mSelectCustomer?.phoneCountryCode ?? '')
                      .length);
    }

    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
    mOrderPlace.refresh();
    loadPaymentType();
  }

  // RxList<String> paymentType = ['Affin Terminal','Google Pay','Booking Payment','Credit Card'].obs;
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

  void onPrint() async{

   if(!isSelectPayment.value){
     AppAlert.showCustomSnackbar(
         Get.context!, 'Please select the payment type');
     return;
   }

    if(mSelectCustomer.value!=null){
      if(mSelectCustomer.value?.name.toString()=='_new_') {
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
      }else {
        onPaymentClick.value!(mGetAllPaymentType.value, mSelectCustomer.value);
      }
    }else {
      onPaymentClick.value!(mGetAllPaymentType.value, mSelectCustomer.value);
    }
  }


  ///customer
  Rxn<GetAllCustomerList> mSelectCustomer = Rxn<GetAllCustomerList>();

  getAllCustomer({bool showCustomer = false}) async {
    List<GetAllCustomerList> allCustomerList = [];
    await mDashboardScreenController.value?.getAllCustomerList();
    allCustomerList.clear();
    allCustomerList.addAll(
        (mDashboardScreenController.value?.mAllCustomerList.value ?? []));

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
