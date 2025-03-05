// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/common/download_data/download_data_view_model.dart';
import 'package:fnb_point_sale_base/common/download_data/jobs/download_product_menu_job.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/cart_item.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/get_menu_stock/get_menu_stock_request.dart';
import 'package:fnb_point_sale_base/data/mode/get_menu_stock/get_menu_stock_response.dart';
import 'package:fnb_point_sale_base/data/mode/menu_stock/menu_request.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_category/get_all_category_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_menu_item/menu_item_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_modifier/get_all_modifier_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_variant/get_all_variant_response.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/product/product_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';

import '../../../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../../home_base_controller/home_base_controller.dart';
import '../../selected_order/controller/selected_order_controller.dart';

class StockItemController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  Rxn<HomeBaseController> mHomeBaseController = Rxn<HomeBaseController>();

  // Rx<TextEditingController> remarkController = TextEditingController().obs;
  Rxn<CartItem> mCartItem = Rxn<CartItem>();

  StockItemController(HomeBaseController mGetHomeBaseController) {
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }
    mHomeBaseController.value = mGetHomeBaseController;
    getValue();
  }

  void getValue() {
    mCartItem.value = CartItem(
      mMenuItemData: mHomeBaseController.value?.mMenuItemSelected.value,
      mModifierList: mHomeBaseController.value?.mModifierListData,
      mVariantListData: mHomeBaseController.value?.mVariantListData,
      mSelectModifierList: [],
    );

    selectVariant(mHomeBaseController.value!.mVariantListData.first);
  }

  ///selectVariant
  void selectVariant(VariantListData mVariantListData) {
    mCartItem.value?.mSelectVariantListData = mVariantListData;
    onCalculateTotal();
  }

  ///
  isSelectVariant(VariantListData mVariantListData) {
    bool isSelect = false;
    if (mVariantListData.variantIDP.toString() ==
        (mCartItem.value?.mSelectVariantListData?.variantIDP ?? '')
            .toString()) {
      isSelect = true;
    }
    return isSelect;
  }

  ///
  void selectModifier(ModifierList mModifierList) {
    if ((mCartItem.value?.mSelectModifierList ?? []).isEmpty) {
      mCartItem.value?.mSelectModifierList?.add(mModifierList);
    } else {
      if (!isSelectModifier(mModifierList)) {
        mCartItem.value?.mSelectModifierList?.add(mModifierList);
      } else {
        removeModifier(mModifierList);
      }
    }
    onCalculateTotal();
  }

  ///item priceIncDec
  void priceModifierIncDec(value, int index, ModifierList mModifierList) {
    (mCartItem.value?.mModifierList ?? [])[index].setCount(value);
    if (isSelectModifier(mModifierList)) {
      int? index = mCartItem.value?.mSelectModifierList?.indexWhere(
          (element) => element.modifierIDP == mModifierList.modifierIDP);
      if (index != null) {
        mCartItem.value?.mSelectModifierList?[index].setCount(value);
      }
    }
    onCalculateTotal();
  }

  isSelectModifier(ModifierList mModifierList) {
    int? index = mCartItem.value?.mSelectModifierList?.indexWhere(
        (element) => element.modifierIDP == mModifierList.modifierIDP);
    if (index == null || index == -1) {
      return false;
    } else {
      return true;
    }
  }

  void removeModifier(ModifierList mModifierList) {
    mCartItem.value?.mSelectModifierList?.removeWhere(
      (element) => element.modifierIDP == mModifierList.modifierIDP,
    );
  }

  ///onCalculateTotal
  onCalculateTotal() {
    ///Variant
    mCartItem.value?.price =
        (mCartItem.value?.mSelectVariantListData?.discountPercentage ?? 0.0) > 0
            ? mCartItem.value?.mSelectVariantListData?.discountedPrice ?? 0.0
            : mCartItem.value?.mSelectVariantListData?.price ?? 0.0;

    ///tax
    mCartItem.value?.taxAmount = 0.0;
    if ((mCartItem.value?.mMenuItemData?.itemTaxPercent ?? 0) > 0) {
      mCartItem.value?.taxAmount = calculatePercentageOf(
          mCartItem.value?.price ?? 0,
          getDoubleValue(
              (mCartItem.value?.mMenuItemData?.itemTaxPercent ?? 0)));
    }

    ///Modifier
    mCartItem.value?.priceModifier = 0.0;
    for (ModifierList mModifierList
        in mCartItem.value?.mSelectModifierList ?? []) {
      mCartItem.value?.priceModifier = (mCartItem.value?.priceModifier ?? 0) +
          ((mModifierList.price ?? 0) * (mModifierList.count ?? 1));
    }

    ///price
    mCartItem.value?.price =
        (mCartItem.value?.price ?? 0) + (mCartItem.value?.priceModifier ?? 0.0);

    mCartItem.value?.taxPriceAmount =
        (mCartItem.value?.price ?? 0) + (mCartItem.value?.taxAmount ?? 0);

    ///total price
    mCartItem.value?.totalPrice = getDoubleValue((mCartItem.value?.count ?? 1) *
        getDoubleValue(mCartItem.value?.taxPriceAmount));

    mCartItem.refresh();
  }

  ///
  onStockInOutItem() async {
    final productApiImpl = locator.get<ProductApi>();
    var configurationLocalApi = locator.get<ConfigurationLocalApi>();
    ConfigurationResponse mConfigurationResponse =
        await configurationLocalApi.getConfigurationResponse() ??
            ConfigurationResponse();
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        List<UpdateStokeData> updateStokeData = [
          UpdateStokeData(
            categoryIDF: mHomeBaseController
                    .value?.selectGetAllCategory.last.categoryIDP ??
                '',
            menuItemIDF: mHomeBaseController
                    .value?.mMenuItemSelected.value?.menuItemIDP ??
                '',
          )
        ];
        MenuRequest mMenuRequest = MenuRequest(
            restaurantIDF:
                (mConfigurationResponse
                                .configurationData?.restaurantData ??
                            [])
                        .isEmpty
                    ? ""
                    : (mConfigurationResponse
                                .configurationData?.restaurantData ??
                            [])
                        .first
                        .restaurantIDP,
            branchIDF:
                (mConfigurationResponse
                                .configurationData?.branchData ??
                            [])
                        .isEmpty
                    ? ""
                    : (mConfigurationResponse
                                .configurationData?.branchData ??
                            [])
                        .first
                        .branchIDP,
            isStockOut: !(mHomeBaseController
                    .value?.mMenuItemSelected.value?.isStockOut ??
                false),
            updateStokeData: updateStokeData);
        debugPrint("mMenuRequest ${jsonEncode(mMenuRequest)}");
        WebResponseSuccess mWebResponseSuccess =
            await productApiImpl.postUpdateStockStatus(mMenuRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          Get.back();
          await downloadProductMenuList((value) {});
          await mHomeBaseController.value?.getMenuItems(GetAllCategoryData());
        } else {
          AppAlert.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        AppAlert.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }

}
