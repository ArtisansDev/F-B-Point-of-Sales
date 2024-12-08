// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:get/get.dart';

import '../../../../add_item/controller/add_item_controller.dart';
import '../../../../add_item/view/add_item_screen.dart';
import '../../../controller/search_order_controller.dart';
import '../../select_menu_view/controller/select_menu_view_controller.dart';

class MenuViewController extends GetxController {
  Rxn<SearchOrderController> mDashboardScreenController =
      Rxn<SearchOrderController>();
  SelectMenuViewController mSelectMenuViewController =
      Get.find<SelectMenuViewController>();
  RxList<String> menuList = [
    'Sandwiches',
    'Pizza',
    'Salad',
    'Main Course',
    'Rice',
    'Bread',
    'Combo',
    'Italian Cuisine'
  ].obs;

  MenuViewController() {
    if (Get.isRegistered<SearchOrderController>()) {
      mDashboardScreenController.value = Get.find<SearchOrderController>();
    }
  }

  void onItemClick(int index) async{
    ///addItemView
    await addItemView();

    ///
    mSelectMenuViewController.selectMenu.value.clear();
    mSelectMenuViewController.selectMenu.value.add(menuList.value[index]);
    mSelectMenuViewController.selectMenu.refresh();


  }

  addItemView() async{
    await AppAlert.showView(Get.context!, const AddItemScreen(),
        barrierDismissible: true);
    if (Get.isRegistered<AddItemController>()) {
      Get.delete<AddItemController>();
    }
  }

  bool isSelected(String value){
    if(mSelectMenuViewController.selectMenu.value.isEmpty){
      return false;
    }
    return value == (mSelectMenuViewController.selectMenu.value.first??'');
  }

}
