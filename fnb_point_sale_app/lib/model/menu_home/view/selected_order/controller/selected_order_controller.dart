// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import '../../../../../cart_item/cart_item.dart';
import '../../../../../cart_item/order_place.dart';
import '../../../../payment_screen/controller/payment_screen_controller.dart';
import '../../../../payment_screen/view/payment_screen.dart';
import '../../../../table_select/controller/table_select_controller.dart';
import '../../../../table_select/view/table_select_screen.dart';
import '../../../controller/home_controller.dart';
import '../../../home_base_controller/home_base_controller.dart';

class SelectedOrderController extends HomeBaseController {
  Rx<TextEditingController> remarkController = TextEditingController().obs;
  Rxn<OrderPlace> mOrderPlace = Rxn<OrderPlace>();

  SelectedOrderController() {
    mSelectedOrderController.value = this;
  }

  void onPayment() async {
    await AppAlert.showView(Get.context!, const PaymentScreen(),
        barrierDismissible: true);
    if (Get.isRegistered<PaymentScreenController>()) {
      Get.delete<PaymentScreenController>();
    }
  }

  ///Order Place from outher page
  onOrderPlace() async{
    if (mDashboardScreenController.mOrderPlace.value != null) {
      mOrderPlace.value = mDashboardScreenController.mOrderPlace.value;
      mOrderPlace.refresh();
      mDashboardScreenController.mOrderPlace.value = null;
    }
  }

  onSelectOrder(CartItem mCartItem) async {
    mOrderPlace.value ??= OrderPlace(cartItem: []);
    mOrderPlace.value?.cartItem?.add(mCartItem);

    ///getCalculateSubTotal
    getCalculateSubTotal();
  }

  ///onCalculateTotalItem value
  onCalculateTotalPricePerItem(
    int value,
    int index,
    CartItem mCartItem,
  ) {
    if (value == 0) {
      mOrderPlace.value?.cartItem?.removeAt(index);
      mOrderPlace.refresh();
      return;
    }

    ///count
    mCartItem.count = value;

    ///total price
    mCartItem.totalPrice = getDoubleValue(
        (mCartItem.count ?? 1) * getDoubleValue(mCartItem.price));

    ///
    mOrderPlace.value?.cartItem?[index].count = value;
    mOrderPlace.value?.cartItem?[index].totalPrice = mCartItem.totalPrice;
    getCalculateSubTotal();
  }

  ///Calculate sub total
  getCalculateSubTotal() {
    mOrderPlace.value?.subTotalPrice = 0.0;
    mOrderPlace.value?.taxAmount = 0.0;
    mOrderPlace.value?.totalPrice = 0.0;
    for (CartItem mCartItem in mOrderPlace.value?.cartItem ?? []) {
      mOrderPlace.value?.subTotalPrice =
          (mOrderPlace.value?.subTotalPrice ?? 0) +
              ((mCartItem.taxPriceAmount ?? 0) * (mCartItem.count));
    }
    mOrderPlace.value?.totalPrice = mOrderPlace.value?.subTotalPrice ?? 0;
    mOrderPlace.refresh();
  }

  @override
  void onClose() {
    ///delete all sub Controller
    super.onClose();
  }
}
