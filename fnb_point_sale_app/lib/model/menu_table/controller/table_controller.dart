// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/widgets.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/place_order/place_order_sale_model.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/data/mode/product/get_all_tables/get_all_tables_response.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:get/get.dart';

import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../dashboard_screen/view/top_bar/controller/top_bar_controller.dart';
import '../../table_select/controller/table_select_controller.dart';
import '../../table_select/view/table_select_screen.dart';
import '../view/table_view/table_summary/controller/table_summary_controller.dart';
import '../view/table_view/table_summary/view/table_summary_order_screen.dart';

class TableController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();

  TopBarController mTopBarController = Get.find<TopBarController>();

  ///table click
  void onTableSelectClick(
      GetAllTablesResponseData mGetAllTablesResponseData) async {
    OrderPlace mOrderPlace =
        getOrderPlace(mGetAllTablesResponseData.seatIDP ?? '');
    if ((mOrderPlace.cartItem ?? []).isNotEmpty) {
      await AppAlert.showView(
          Get.context!,
          Row(
            children: [
              const Expanded(flex: 7, child: SizedBox()),
              Expanded(flex: 3, child: TableSummaryOrderScreen(mOrderPlace))
            ],
          ),
          barrierDismissible: true);
      if (Get.isRegistered<TableSummaryController>()) {
        Get.delete<TableSummaryController>();
      }
    } else {
      bool value = (!(mGetAllTablesResponseData.isDeleted ?? false) &&
          (mGetAllTablesResponseData.isActive ?? false));
      if (value) {
        bool isCreateOrder = false;
        await AppAlert.showView(Get.context!,
            TableSelectScreen(tableNumber: mGetAllTablesResponseData),
            barrierDismissible: true);
        if (Get.isRegistered<TableSelectController>()) {
          isCreateOrder = Get.find<TableSelectController>().isCreateOrder.value;
          Get.delete<TableSelectController>();
        }
        if (isCreateOrder) {
          mDashboardScreenController.selectMenu.value = 0;
          mDashboardScreenController.selectMenu.refresh();
        }
      }
    }
  }

  ///order place
  Rxn<PlaceOrderSaleModel> mPlaceOrderSaleModel = Rxn<PlaceOrderSaleModel>();
  var mPlaceOrderSaleLocalApi = locator.get<PlaceOrderSaleLocalApi>();

  allOrderPlace() async {
    mPlaceOrderSaleModel.value =
        await mPlaceOrderSaleLocalApi.getAllPlaceOrderSale() ??
            PlaceOrderSaleModel();
  }

  OrderPlace getOrderPlace(String sSeatIDP) {
    OrderPlace mOrderPlace = OrderPlace();
    if ((mPlaceOrderSaleModel.value?.mOrderPlace ?? []).isEmpty) {
      return mOrderPlace;
    }
    int? value = mPlaceOrderSaleModel.value?.mOrderPlace?.indexWhere(
      (element) => element.seatIDP.toString() == sSeatIDP.toString(),
    );
    if ((value ?? -1) == -1) {
      return mOrderPlace;
    } else {
      mOrderPlace =
          mPlaceOrderSaleModel.value?.mOrderPlace?[value ?? -1] ?? OrderPlace();
      return mOrderPlace;
    }
  }

  ///all table
  List<GetAllTablesResponseData> selectGetAllTablesResponseData = [];
  RxMap<String, List<GetAllTablesResponseData>> groupedByDepartment =
      <String, List<GetAllTablesResponseData>>{}.obs;



  onUpdateViewTable() async{
    await allOrderPlace();
    mDashboardScreenController.onUpdateViewTable(() {
      setGroupTable();
    });
    setGroupTable();
  }

  setGroupTable() {
    ///
    List<GetAllTablesResponseData> selectTablesData = [];
    selectGetAllTablesResponseData.clear();
    selectGetAllTablesResponseData.addAll(mTopBarController.mGetAllTablesList.toList());
    ///
    groupedByDepartment.clear();
    groupedByDepartment.refresh();
    ///
    if (mDashboardScreenController.topBarIndex.value == 1) {
      for (OrderPlace mOrderPlace
      in mPlaceOrderSaleModel.value?.mOrderPlace ?? []) {
        selectTablesData.clear();
        selectTablesData.addAll(selectGetAllTablesResponseData.toList());
        selectGetAllTablesResponseData.clear();
        selectGetAllTablesResponseData.addAll(selectTablesData.where(
              (element) {
            if (mOrderPlace.seatIDP.toString() != element.seatIDP.toString()) {
              return true;
            } else {
              return false;
            }
          },
        ).toList());
      }
    } else if (mDashboardScreenController.topBarIndex.value == 2) {
      for (OrderPlace mOrderPlace in mPlaceOrderSaleModel.value?.mOrderPlace ?? []) {
        selectTablesData.addAll(selectGetAllTablesResponseData.where(
              (element) {
            if (mOrderPlace.seatIDP.toString() == element.seatIDP.toString()) {
              return true;
            } else {
              return false;
            }
          },
        ).toList());
      }
      selectGetAllTablesResponseData.clear();
      selectGetAllTablesResponseData.addAll(selectTablesData.toList());
    }
    groupTable();
  }

  groupTable() {
    /// Create a map for grouping
    for (var mTable in selectGetAllTablesResponseData) {
      groupedByDepartment.putIfAbsent(mTable.locationType ?? '', () => []);
      groupedByDepartment[mTable.locationType]!.add(mTable);
    }
    groupedByDepartment.refresh();
  }
}
