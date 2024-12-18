// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/data/local/database/product/all_category/all_category_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_category/get_all_category_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:get/get.dart';

import '../../../../../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../../../../controller/home_controller.dart';
import '../../../../add_item/controller/add_item_controller.dart';
import '../../../../add_item/view/add_item_screen.dart';
import '../../../controller/search_order_controller.dart';
import '../../select_menu_view/controller/select_menu_view_controller.dart';

class MenuViewController extends GetxController {

  Rxn<SearchOrderController> mSearchOrderController =
      Rxn<SearchOrderController>();

  DashboardScreenController mDashboardScreenController =
  Get.find<DashboardScreenController>();

  SelectMenuViewController mSelectMenuViewController =
      Get.find<SelectMenuViewController>();

  onHomeUpdate() async{
    mDashboardScreenController.onUpdate(() {
      getAllCategoryList();
    });
  }

  RxList<GetAllCategoryData> mGetAllCategoryData = <GetAllCategoryData>[].obs;

  getAllCategoryList() async {
    var localAllCategoryApi = locator.get<AllCategoryLocalApi>();
    GetAllCategoryResponse mGetAllCategoryResponse =
        await localAllCategoryApi.getAllCategoryResponse() ??
            GetAllCategoryResponse();
    if ((mGetAllCategoryResponse.mGetAllCategoryData ?? []).isNotEmpty) {
      mGetAllCategoryData.value.clear();
      mGetAllCategoryData.value
          .addAll(mGetAllCategoryResponse.mGetAllCategoryData ?? []);
      mGetAllCategoryData.refresh();
    }
  }

  MenuViewController() {
    if (Get.isRegistered<SearchOrderController>()) {
      mSearchOrderController.value = Get.find<SearchOrderController>();
    }
  }

  void onItemClick(int index) async{
    ///addItemView
    await addItemView();

    ///
    // mSelectMenuViewController.selectMenu.value.clear();
    // mSelectMenuViewController.selectMenu.value.add(menuList.value[index]);
    // mSelectMenuViewController.selectMenu.refresh();


  }

  addItemView() async{
    await AppAlert.showView(Get.context!, const AddItemScreen(),
        barrierDismissible: true);
    if (Get.isRegistered<AddItemController>()) {
      Get.delete<AddItemController>();
    }
  }

  // bool isSelected(String value){
  //   if(mSelectMenuViewController.selectMenu.value.isEmpty){
  //     return false;
  //   }
  //   return value == (mSelectMenuViewController.selectMenu.value.first??'');
  // }

}
