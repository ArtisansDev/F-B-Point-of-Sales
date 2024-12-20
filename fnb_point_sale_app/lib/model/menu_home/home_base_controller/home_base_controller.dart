// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/data/local/database/menu_item/menu_item_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/modifier/modifier_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/product/all_category/all_category_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/variant/variant_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_category/get_all_category_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_menu_item/menu_item_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_modifier/get_all_modifier_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_variant/get_all_variant_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:get/get.dart';

import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../controller/home_controller.dart';
import '../view/add_item/controller/add_item_controller.dart';
import '../view/add_item/view/add_item_screen.dart';
import '../view/search_order/controller/search_order_controller.dart';
import '../view/search_order/view/menu_view/controller/menu_view_controller.dart';
import '../view/search_order/view/search_view/controller/search_view_controller.dart';
import '../view/search_order/view/select_menu_view/controller/select_menu_view_controller.dart';
import '../view/selected_order/controller/selected_order_controller.dart';

class HomeBaseController extends GetxController {
  ///Dashboard
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();

  ///Home
  Rxn<HomeController> mHomeController = Rxn<HomeController>();

  ///SearchOrder
  Rxn<SearchOrderController> mSearchOrderController =
      Rxn<SearchOrderController>();

  ///SelectedOrder
  Rxn<SelectedOrderController> mSelectedOrderController =
      Rxn<SelectedOrderController>();

  ///Search
  Rxn<SearchViewController> mSearchViewController = Rxn<SearchViewController>();

  ///Select
  Rxn<SelectMenuViewController> mSelectMenuViewController =
      Rxn<SelectMenuViewController>();

  ///Menu
  Rxn<MenuViewController> mMenuViewController = Rxn<MenuViewController>();

  ///SelectMenuView
  RxList<GetAllCategoryData> selectGetAllCategory = <GetAllCategoryData>[].obs;

  void onClickHome() {
    selectGetAllCategory.clear();
    selectGetAllCategory.refresh();

    ///
    if (mMenuViewController.value == null) {
      createController();
    }
    mMenuViewController.value!.getAllCategoryList();
  }

  ///sync update
  onHomeUpdate() {
    mDashboardScreenController.onUpdate(() async {
      await getAllCategoryList();
      if (mSelectMenuViewController.value == null) {
        createController();
      }
      mSelectMenuViewController.value?.selectGetAllCategory.clear();
      mSelectMenuViewController.value?.selectGetAllCategory.refresh();
    });
  }

  createController() {
    ///Home
    mHomeController.value = Get.find<HomeController>();

    ///SearchOrder
    mSearchOrderController.value = Get.find<SearchOrderController>();

    ///SelectedOrder
    mSelectedOrderController.value = Get.find<SelectedOrderController>();

    ///Search
    mSearchViewController.value = Get.find<SearchViewController>();

    ///Select
    mSelectMenuViewController.value = Get.find<SelectMenuViewController>();

    ///Menu
    mMenuViewController.value = Get.find<MenuViewController>();
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
      ///MenuItemD
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
  }

  void onCategorySelect(int index) async {
    ///
    if (mSelectMenuViewController.value == null) {
      createController();
    }

    ///
    // if ((mGetAllCategoryView[index].subCategories ?? []).isNotEmpty) {
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
    // } else {
    //   selectCategory(index);
    // }
  }

  ///selectCategory
  void selectCategory(int index) {
    if (mSelectMenuViewController.value!.selectGetAllCategory.isNotEmpty &&
        (mSelectMenuViewController
                    .value!.selectGetAllCategory.last.subCategories ??
                [])
            .isEmpty) {
      mSelectMenuViewController.value?.selectGetAllCategory.removeLast();
      mSelectMenuViewController.value?.selectGetAllCategory
          .add(mGetAllCategoryView[index]);
      mSelectMenuViewController.value?.selectGetAllCategory.refresh();
    } else {
      mSelectMenuViewController.value?.selectGetAllCategory
          .add(mGetAllCategoryView[index]);
      mSelectMenuViewController.value?.selectGetAllCategory.refresh();
    }

    getMenuItems(mSelectMenuViewController.value?.selectGetAllCategory.last ??
        GetAllCategoryData());
  }

  isSelectedCategory(GetAllCategoryData mGetAllCategoryData) {
    if (mSelectMenuViewController.value == null) {
      return false;
    }
    if (mSelectMenuViewController.value!.selectGetAllCategory.isNotEmpty &&
        (mSelectMenuViewController
                        .value!.selectGetAllCategory.value.last.categoryIDP ??
                    '')
                .toString() ==
            (mGetAllCategoryData.categoryIDP ?? '').toString()) {
      return true;
    }
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

  ///add item
  // void onItemClick(int index) async {
  //   ///
  //   MyLogUtils.logDebug(
  //       "##### mMenuItemSelected ${jsonEncode(mMenuItemSelected.value)}");
  //   MyLogUtils.logDebug("##### mVariantListData ${mVariantListData.length}");
  //   MyLogUtils.logDebug(
  //       "##### mVariantListData ${jsonEncode(mVariantListData)}");
  //
  //   MyLogUtils.logDebug(
  //       "##### mModifierListData ${jsonEncode(mModifierListData.length)}");
  //   MyLogUtils.logDebug(
  //       "##### mModifierListData ${jsonEncode(mModifierListData)}");
  //
  //   ///addItemView
  //   await addItemView();
  //
  //   ///
  //   // mSelectMenuViewController.selectMenu.value.clear();
  //   // mSelectMenuViewController.selectMenu.value.add(menuList.value[index]);
  //   // mSelectMenuViewController.selectMenu.refresh();
  // }

  addItemView() async {
    await AppAlert.showView(Get.context!,  AddItemScreen(this),
        barrierDismissible: true);
    if (Get.isRegistered<AddItemController>()) {
      Get.delete<AddItemController>();
    }
  }
}
