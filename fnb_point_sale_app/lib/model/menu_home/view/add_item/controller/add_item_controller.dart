// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/cart_item.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_menu_item/menu_item_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_modifier/get_all_modifier_response.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_variant/get_all_variant_response.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';

import '../../../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../../home_base_controller/home_base_controller.dart';
import '../../selected_order/controller/selected_order_controller.dart';

class AddItemController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
  Rxn<DashboardScreenController>();
  Rxn<HomeBaseController> mHomeBaseController = Rxn<HomeBaseController>();
  Rx<TextEditingController> remarkController = TextEditingController().obs;
  Rxn<CartItem> mCartItem = Rxn<CartItem>();

  AddItemController(HomeBaseController mGetHomeBaseController) {
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

  ///item priceIncDec
  void priceIncDec(value) {
    mCartItem.value?.count = value;
    onCalculateTotal();
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
  void onAddItem() {
    if (mCartItem.value != null) {
      mCartItem.value?.textRemarks = remarkController.value.text;
      bool value = true;

      ///
      if (Get.isRegistered<SelectedOrderController>()) {
        SelectedOrderController mSelectedOrderController =
        Get.find<SelectedOrderController>();
        OrderPlace mOrderPlace =
            mSelectedOrderController.mOrderPlace.value ?? OrderPlace();
        debugPrint("mOrderPlace add ${jsonEncode(mOrderPlace)}");

        if ((mOrderPlace.cartItem ?? []).isNotEmpty) {
          int index = -1;
          for (CartItem mMenuCartItem in mOrderPlace.cartItem ?? []) {
            index++;
            ///
            debugPrint("mMenuCartItem ${jsonEncode(mMenuCartItem)}");
            ///as new requirement
            // if (!mMenuCartItem.placeOrder) {
              if (mMenuCartItem.textRemarks.toString() ==
                  remarkController.value.text.toString()) {
                String sSelectVariant = (mMenuCartItem
                    .mSelectVariantListData?.quantitySpecification ??
                    '')
                    .toString();
                sSelectVariant = sSelectVariant +
                    (mMenuCartItem.mSelectVariantListData?.variantIDP ?? '')
                        .toString();
                String sCartItemVariant = (mCartItem
                    .value?.mSelectVariantListData?.quantitySpecification ?? '')
                    .toString();
                sCartItemVariant = sCartItemVariant+(mCartItem
                    .value?.mSelectVariantListData?.variantIDP ?? '')
                    .toString();
                if (sSelectVariant ==
                    sCartItemVariant) {
                  if (mMenuCartItem.getModifierString() ==
                      mCartItem.value?.getModifierString()) {
                    value = false;
                    break;
                  }
                }
              }
            // }
          }

          ///add
          if (value) {
            mHomeBaseController.value?.onAddValue(mCartItem.value!);
          } else {
            mSelectedOrderController.onCalculateTotalPricePerItem(
                ((mOrderPlace.cartItem?[index].count ?? 0) + 1),
                index,
                mOrderPlace.cartItem![index]);
          }
        } else {
          mHomeBaseController.value?.onAddValue(mCartItem.value!);
        }
      }
    }
    Get.back();
  }
}
