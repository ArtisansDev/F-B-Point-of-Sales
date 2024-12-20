// ignore_for_file: avoid_dynamic_calls

import 'jobs/download_product_category_job.dart';
import 'jobs/download_product_menu_job.dart';
import 'jobs/download_product_modifier_job.dart';
import 'jobs/download_product_variant_job.dart';

class DownloadDataMenu {
  static String sCategoryList = 'Category';
  static String sModifierList = 'Modifier';
  static String sMenuItems = 'Menu Items';
  static String sVariantList = 'Variant';
  static List<String> values = [
    sCategoryList,
    sModifierList,
    sMenuItems,
    sVariantList,
  ];
}

class DownloadDataViewModel {
  Future<void> startDownloading(Function callBack, Function onCompleted,
      Function onError, List<String> selectedDownloadOptions,
      {required bool onlyLatestChange}) async {
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

    callBack('Completed');
    onCompleted();
  }
}
