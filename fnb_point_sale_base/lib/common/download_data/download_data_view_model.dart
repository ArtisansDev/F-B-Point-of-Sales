// ignore_for_file: avoid_dynamic_calls

import 'jobs/download_advertisement_job.dart';

class DownloadDataMenu {
  static String sCategoryList = 'Category List';
  static List<String> values = [
    sCategoryList,
  ];
}

class DownloadDataViewModel {
  Future<void> startDownloading(Function callBack, Function onCompleted,
      Function onError, List<String> selectedDownloadOptions,
      {required bool onlyLatestChange}) async {
    if (selectedDownloadOptions.contains(DownloadDataMenu.sCategoryList)) {
      callBack('Downloading Category List ...');
      await Future.delayed(const Duration(seconds: 1));
      await downloadProductCategoryList(onError);
    }

    callBack('Completed');
    onCompleted();
  }
}
