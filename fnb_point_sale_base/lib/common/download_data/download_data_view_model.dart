// ignore_for_file: avoid_dynamic_calls

import 'package:get/get.dart';

import '../../alert/app_alert.dart';
import '../../constants/message_constants.dart';
import '../../utils/network_utils.dart';
import 'jobs/download_list_of_table_job.dart';
import 'jobs/download_payment_type_job.dart';
import 'jobs/download_product_category_job.dart';
import 'jobs/download_product_menu_job.dart';
import 'jobs/download_product_modifier_job.dart';
import 'jobs/download_product_variant_job.dart';

class DownloadDataMenu {
  static String sCategoryList = 'Category';
  static String sModifierList = 'Modifier';
  static String sMenuItems = 'Menu Items';
  static String sVariantList = 'Variant';
  static String sTable = 'Table\'s';
  static String sPaymentType = 'Payment Type';
  static List<String> values = [
    sCategoryList,
    sModifierList,
    sMenuItems,
    sVariantList,
    sTable,
    sPaymentType
  ];
}

class DownloadDataViewModel {
  Future<void> startDownloading(Function callBack, Function onCompleted,
      Function onError, List<String> selectedDownloadOptions,
      {required bool onlyLatestChange}) async {
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        if (selectedDownloadOptions.contains(DownloadDataMenu.sCategoryList)) {
          callBack('Downloading Category List ...');
          await Future.delayed(const Duration(microseconds: 500));
          await downloadProductCategoryList(onError);
        }
        if (selectedDownloadOptions.contains(DownloadDataMenu.sModifierList)) {
          callBack('Downloading Modifier List ...');
          await Future.delayed(const Duration(microseconds: 500));
          await downloadProductModifierList(onError);
        }

        if (selectedDownloadOptions.contains(DownloadDataMenu.sMenuItems)) {
          callBack('Downloading Menu Items ...');
          await Future.delayed(const Duration(microseconds: 500));
          await downloadProductMenuList(onError);
        }

        if (selectedDownloadOptions.contains(DownloadDataMenu.sVariantList)) {
          callBack('Downloading Variant Items ...');
          await Future.delayed(const Duration(microseconds: 500));
          await downloadProductVariantList(onError);
        }

        if (selectedDownloadOptions.contains(DownloadDataMenu.sTable)) {
          callBack('Downloading Table configuration...');
          await Future.delayed(const Duration(microseconds: 500));
          await downloadTableList(onError);
        }

        if (selectedDownloadOptions.contains(DownloadDataMenu.sPaymentType)) {
          callBack('Downloading Payment Type...');
          await Future.delayed(const Duration(microseconds: 500));
          await downloadPaymentType(onError);
        }

        callBack('Completed');
        onCompleted();
      } else {
        AppAlert.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
        // callBack(MessageConstants.noInternetConnection);
        // await Future.delayed(const Duration(seconds: 1));
        // onError("");
      }
    });
  }
}
