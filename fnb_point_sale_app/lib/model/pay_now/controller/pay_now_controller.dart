// // ignore_for_file: depend_on_referenced_packages
// import 'package:flutter/material.dart';
// import 'package:fnb_point_sale_base/alert/app_alert.dart';
// import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
// import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
// import 'package:fnb_point_sale_base/data/mode/product/get_all_payment_type/get_all_payment_type_response.dart';
// import 'package:get/get.dart';
//
// import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
// import '../../payment_screen/controller/payment_screen_controller.dart';
// import '../../payment_screen/view/payment_screen.dart';
//
// class PayNowController extends GetxController {
//   Rxn<DashboardScreenController> mDashboardScreenController =
//       Rxn<DashboardScreenController>();
//   Rx<TextEditingController> remarkController = TextEditingController().obs;
//
//   PayNowController() {
//     if (Get.isRegistered<DashboardScreenController>()) {
//       mDashboardScreenController.value = Get.find<DashboardScreenController>();
//     }
//   }
//
//   void onPayment() async {
//     Get.back();
//     await AppAlert.showView(
//         Get.context!,
//         PaymentScreen(
//           OrderPlace(),
//           onPayment: (GetAllPaymentTypeData mSelectPaymentType,
//               GetAllCustomerList? mSelectCustomer) {
//             Get.back();
//           },
//         ),
//         barrierDismissible: true);
//     if (Get.isRegistered<PaymentScreenController>()) {
//       Get.delete<PaymentScreenController>();
//     }
//   }
//
//   void addMore() {
//     Get.back();
//     mDashboardScreenController.value!.selectMenu.value = 0;
//     mDashboardScreenController.value!.selectMenu.refresh();
//   }
// }
