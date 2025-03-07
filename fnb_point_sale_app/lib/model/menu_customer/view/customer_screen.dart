import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_app/model/menu_customer/view/customer_list/customer_list_view.dart';
import 'package:fnb_point_sale_app/model/menu_customer/view/top_search_view/customer_search_view.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import '../controller/customer_controller.dart';

class CustomerScreen extends GetView<CustomerController> {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CustomerController());
    // controller.pageNumber.value = 0;
    // controller.page.value = 1;
    // controller.totalPage.value = 0;
    // controller.mSelectCustomerList.value = [];
    controller.onCustomerUpdate();
    return FocusDetector(
        onVisibilityGained: () {
          // controller.getAllCustomerList();
          controller.callGetAllCustomer();
        },
        onVisibilityLost: () {},
        child: Column(
          children: [CustomerSearchView(), Expanded(child: CustomerListView())],
        ));
  }
}
