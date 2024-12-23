// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/common/date_range_picker/models.dart';
import 'package:fnb_point_sale_base/common/date_range_picker/widgets/date_range_picker.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/hold_sale/hold_sale_model.dart';
import 'package:fnb_point_sale_base/data/mode/cart_item/order_place.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../cancel_order/controller/cancel_order_controller.dart';
import '../../cancel_order/view/cancel_order_screen.dart';
import '../../dashboard_screen/controller/dashboard_screen_controller.dart';
import '../../menu_table/view/table_view/table_summary/controller/table_summary_controller.dart';
import '../../menu_table/view/table_view/table_summary/view/table_summary_order_screen.dart';
import '../../pay_now/controller/pay_now_controller.dart';
import '../../pay_now/view/pay_now_order_screen.dart';
import '../../payment_screen/controller/payment_screen_controller.dart';
import '../../payment_screen/view/payment_screen.dart';

class HoldSalesController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  Rxn<HoldSaleModel> mHoldSaleModel = Rxn<HoldSaleModel>();
  var holdSaleLocalApi = locator.get<HoldSaleLocalApi>();
  getAllHoldSale() async {
    mHoldSaleModel.value =
        await holdSaleLocalApi.getAllHoldSale() ?? HoldSaleModel();
    mHoldSaleModel.refresh();
  }

  void onDeleteAll() async{
    await holdSaleLocalApi.deleteAllHoldSale();
    mHoldSaleModel.value =
        await holdSaleLocalApi.getAllHoldSale() ?? HoldSaleModel();
    mHoldSaleModel.refresh();
    mDashboardScreenController.onUpdateHoldSale();
  }

  void onEditHoldSale(int index, OrderPlace mOrderPlace) {
    mDashboardScreenController.mOrderPlace.value = mOrderPlace;
    mDashboardScreenController.mOrderPlace.refresh();
    Get.back();
  }

  void onDeleteHoldSale(int index, OrderPlace mOrderPlace) async{
    await holdSaleLocalApi.getHoldSaleDelete(mOrderPlace.sOrderNo);
    mHoldSaleModel.value =
        await holdSaleLocalApi.getAllHoldSale() ?? HoldSaleModel();
    mHoldSaleModel.refresh();
    mDashboardScreenController.onUpdateHoldSale();
  }
}
