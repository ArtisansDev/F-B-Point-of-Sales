// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';

import '../../../../dashboard_screen/controller/dashboard_screen_controller.dart';
import 'cash_model/cash_model.dart';

class OpenCashDrawerScreenController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;

  OpenCashDrawerScreenController() {
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }

    // addAmount();
  }

  RxDouble totalCashCollected = 0.00.obs;
  RxList<CashModel> mCashModelList = <CashModel>[].obs;

  void addAmount() {
    mCashModelList.value.clear();
    mCashModelList.add(CashModel(amount: 0.05, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 0.10, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 0.20, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 0.50, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 1.00, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 5.00, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 10.00, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 20.00, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 50.00, qty: 0, totalAmount: 0.0));
    mCashModelList.add(CashModel(amount: 100.00, qty: 0, totalAmount: 0.0));
  }

  void onTextQtyChange(int index) {
    CashModel mCashModel = mCashModelList.value[index];
    if (mCashModel.qtyController.value.text.isEmpty) {
      mCashModelList.value[index].qty = 0;
      mCashModelList.value[index].totalAmount = 0.0;
    } else {
      mCashModelList.value[index].qty =
          getInValue(mCashModel.qtyController.value.text);
      mCashModelList.value[index].totalAmount = getDoubleValue(
          (mCashModelList.value[index].qty ?? 0) *
              (mCashModelList.value[index].amount ?? 1));
    }
    mCashModelList.refresh();

    totalCalculate();
  }

  void totalCalculate() {
    double value = 0.0;
    for(CashModel mCashModel in mCashModelList.value??[]){
      value = value + (mCashModel.totalAmount??0);
    }
    totalCashCollected.value = value;
    totalCashCollected.refresh();
  }
}
