// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/data/local/database/menu_item/menu_item_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/modifier/modifier_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/product/all_category/all_category_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/variant/variant_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/cart_item.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_category/get_all_category_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_menu_item/menu_item_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_modifier/get_all_modifier_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_variant/get_all_variant_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:get/get.dart';

import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../dashboard_screen/view/top_bar/controller/top_bar_controller.dart';
import '../view/add_item/controller/add_item_controller.dart';
import '../view/add_item/view/add_item_screen.dart';
import '../view/selected_order/controller/selected_order_controller.dart';

class HomeBaseController extends GetxController {
  ///Dashboard
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  TopBarController mTopBarController = Get.find<TopBarController>();
  static Rx<TextEditingController> searchController =
      TextEditingController().obs;

  ///SelectedOrder
  Rxn<SelectedOrderController> mSelectedOrderController =
      Rxn<SelectedOrderController>();

  ///SelectMenuView
  RxList<GetAllCategoryData> selectGetAllCategory = <GetAllCategoryData>[].obs;

  void onClickHome() {
    getAllCategoryList();
  }

  onSearchText(value) async {
    ///Category
    var localAllCategoryApi = locator.get<AllCategoryLocalApi>();
    mGetAllCategoryData.clear();
    mGetAllCategoryView.clear();
    mGetAllCategoryData.addAll(await localAllCategoryApi
            .getCategoryListSearch(value.toString().toLowerCase()) ??
        []);
    mGetAllCategoryView.addAll(mGetAllCategoryData.toList());
    mGetAllCategoryData.refresh();
    mGetAllCategoryView.refresh();
    selectGetAllCategory.clear();
    selectGetAllCategory.refresh();

    ///menu
    var localMenuItemApi = locator.get<MenuItemLocalApi>();
    mMenuItemSelected.value = null;
    mMenuItemData.clear();
    mMenuItemData.addAll(await localMenuItemApi
            .getMenuItemDataSearch(value.toString().toLowerCase()) ??
        []);
    mMenuItemData.refresh();
  }

  ///sync update
  onHomeUpdate() {
    mDashboardScreenController.onHomeUpdate(updateHome: () async {
      await getAllCategoryList();
      await getMenuItems(GetAllCategoryData());

      if (Get.isRegistered<SelectedOrderController>()) {
        mSelectedOrderController.value ??= Get.find<SelectedOrderController>();
        mSelectedOrderController.value?.getCalculateSubTotal();
      }
    });
  }

  ///Category data
  RxList<GetAllCategoryData> mGetAllCategoryData = <GetAllCategoryData>[].obs;
  RxList<GetAllCategoryData> mGetAllCategoryView = <GetAllCategoryData>[].obs;

  getAllCategoryList() async {
    var localAllCategoryApi = locator.get<AllCategoryLocalApi>();
    GetAllCategoryResponse mGetAllCategoryResponse =
        await localAllCategoryApi.getAllCategoryResponse() ??
            GetAllCategoryResponse();

    if ((mGetAllCategoryResponse.mGetAllCategoryData ?? []).isNotEmpty) {
      // ///MenuItemD
      mMenuItemData.clear();
      mMenuItemData.refresh();

      ///Category
      mGetAllCategoryData.clear();
      mGetAllCategoryView.clear();
      mGetAllCategoryData
          .addAll(mGetAllCategoryResponse.mGetAllCategoryData ?? []);
      mGetAllCategoryView.addAll(mGetAllCategoryData.toList());
      mGetAllCategoryData.refresh();
      mGetAllCategoryView.refresh();
    }

    selectGetAllCategory.clear();
    selectGetAllCategory.refresh();
    searchController.value.text = "";
  }

  void onCategorySelect(int index) async {
    ///selectCategory
    selectCategory(index);

    ///GetAllCategoryView
    mGetAllCategoryView.clear();
    mGetAllCategoryView
        .addAll((mGetAllCategoryData[index].subCategories ?? []));
    mGetAllCategoryView.refresh();

    ///GetAllCategory
    mGetAllCategoryData.clear();
    mGetAllCategoryData.addAll(mGetAllCategoryView.toList());
  }

  ///selectCategory
  void selectCategory(int index) {
    if (selectGetAllCategory.isNotEmpty &&
        (selectGetAllCategory.last.subCategories ?? []).isEmpty) {
      selectGetAllCategory.removeLast();
      selectGetAllCategory.add(mGetAllCategoryView[index]);
      selectGetAllCategory.refresh();
    } else {
      selectGetAllCategory.add(mGetAllCategoryView[index]);
      selectGetAllCategory.refresh();
    }

    getMenuItems(selectGetAllCategory.last ?? GetAllCategoryData());
  }

  isSelectedCategory(GetAllCategoryData mGetAllCategoryData) {
    // if (mSelectMenuViewController.value == null) {
    //   return false;
    // }
    // if (selectGetAllCategory.isNotEmpty &&
    //     (mSelectMenuViewController
    //                     .value!.selectGetAllCategory.value.last.categoryIDP ??
    //                 '')
    //             .toString() ==
    //         (mGetAllCategoryData.categoryIDP ?? '').toString()) {
    //   return true;
    // }
    return false;
  }

  ///getMenuItems
  RxList<MenuItemData> mMenuItemData = <MenuItemData>[].obs;
  Rxn<MenuItemData> mMenuItemSelected = Rxn<MenuItemData>();

  getMenuItems(GetAllCategoryData mGetAllCategoryData) async {
    mMenuItemData.clear();
    mMenuItemData.refresh();
    mMenuItemSelected.value = null;

    ///
    var localMenuItemApi = locator.get<MenuItemLocalApi>();
    mMenuItemData.addAll(await localMenuItemApi
            .getMenuItemData(mGetAllCategoryData.categoryIDP ?? '') ??
        []);
    mMenuItemData.refresh();
  }

  onMenuSelect(int index) async {
    mMenuItemSelected.value = mMenuItemData[index];
    await getVariantItems(mMenuItemSelected.value ?? MenuItemData());
    await getModifierItems(mMenuItemSelected.value ?? MenuItemData());
    // onItemClick(index);
    await addItemView();
  }

  isSelectedMenuItem(MenuItemData mMenuItemDataSelected) {
    if (mMenuItemSelected.value == null) {
      return false;
    }
    if ((mMenuItemSelected.value?.menuItemIDP ?? '').toString() ==
        (mMenuItemDataSelected.menuItemIDP ?? '').toString()) {
      return true;
    }
    return false;
  }

  ///getVariant
  RxList<VariantListData> mVariantListData = <VariantListData>[].obs;

  getVariantItems(MenuItemData mMenuItemData) async {
    mVariantListData.clear();
    mVariantListData.refresh();

    var localVariantApi = locator.get<VariantLocalApi>();
    mVariantListData.addAll(
        await localVariantApi.getVariantList(mMenuItemData.menuItemIDP ?? '') ??
            []);
    mVariantListData.refresh();
  }

  ///getModifier
  RxList<ModifierList> mModifierListData = <ModifierList>[].obs;

  getModifierItems(MenuItemData mMenuItemData) async {
    mModifierListData.clear();
    mModifierListData.refresh();
    if ((mMenuItemData.modifierIDs ?? []).isEmpty) {
      return;
    }

    var localModifierApi = locator.get<ModifierLocalApi>();
    mModifierListData.addAll(await localModifierApi
            .getModifierList(mMenuItemData.modifierIDs ?? []) ??
        []);
    mModifierListData.refresh();
  }

  addItemView() async {
    await AppAlert.showView(Get.context!, AddItemScreen(this),
        barrierDismissible: true);
    if (Get.isRegistered<AddItemController>()) {
      await Get.delete<AddItemController>();
      getAllCategoryList();
    }
  }

  onAddValue(CartItem mCartItem) {
    MyLogUtils.logDebug("mModifierListData ${mCartItem.totalPrice}");
    getAllCategoryList();
    mSelectedOrderController.value ??= Get.find<SelectedOrderController>();
    mSelectedOrderController.value?.onSelectOrder(mCartItem);
  }
}
