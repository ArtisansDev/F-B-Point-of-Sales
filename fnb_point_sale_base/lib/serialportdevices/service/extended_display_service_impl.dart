// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui';
//
// import 'package:desktop_multi_window/desktop_multi_window.dart';
// import 'package:fnb_point_sale_base/data/local/database/sale/model/cart_summary.dart';
// import 'package:fnb_point_sale_base/data/local/database/user/user_local_api.dart';
// import 'package:fnb_point_sale_base/locator.dart';
// import 'package:fnb_point_sale_base/restapi/configurationkey/model/get_logo_theme_configuration.dart';
// import 'package:fnb_point_sale_base/restapi/currencySymbol/currency_symbol_api.dart';
// import 'package:fnb_point_sale_base/restapi/getconfiguration/get_configuration_api.dart';
// import 'package:fnb_point_sale_base/restapi/getconfiguration/model/get_configuration_response.dart';
// import 'package:fnb_point_sale_base/serialportdevices/model/extended_display_model.dart';
// import 'package:fnb_point_sale_base/serialportdevices/service/extended_display_service.dart';
// import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
// import 'package:path_provider/path_provider.dart';
//
// class ExtendedDisplayServiceImpl with ExtendedDisplayService {
//   final tag = 'ExtendedDisplayService';
//
//   Future<List<String>> getMediaFiles() async {
//     final Directory directory = await getApplicationDocumentsDirectory();
//     var adsDirectoryPath = '${directory.path}/pos-advertisement/';
//
//     Directory adsDirectory = Directory(adsDirectoryPath);
//
//     List<String> mediaFiles = List.empty(growable: true);
//     if (adsDirectory.existsSync()) {
//       List<FileSystemEntity> fileSystemEntity = adsDirectory.listSync();
//       for (var element in fileSystemEntity) {
//         if (element.path.contains("png") ||
//             element.path.contains("jpg") ||
//             element.path.contains("jpeg") ||
//             element.path.contains("mp4") ||
//             element.path.contains("gif")) {
//           mediaFiles.add(element.path);
//         }
//       }
//     }
//
//     MyLogUtils.logDebug("getMedia File adsDirectory : $adsDirectory");
//     return mediaFiles;
//   }
//   late CartSummary mCartSummary;
//   @override
//   Future<WindowController> createNewWindow() async {
//     var api = locator.get<GetConfiguratiopnApi>();
//     GetConfigurationResponse mGetConfigurationResponse =
//         await api.getAllConfiguration();
//
//     ///themeColour
//     String themeColour="";
//     String logoPath="";
//
//       var localApi = locator.get<UserLocalApi>();
//       GetLogoThemeConfiguration? logoThemeResponse =
//       await localApi.getLogoThemeConfigKey();
//       if (logoThemeResponse != null) {
//         themeColour = logoThemeResponse.data?.theme ?? "";
//         logoPath = logoThemeResponse.data?.loginPageLogo ?? "";
//       }
//
//     ///sCurrency
//     var restApi = locator.get<CurrencySymbolApi>();
//     var response = await restApi.getCurrencySymbol();
//     String sCurrency = "";
//     MyLogUtils.logDebug(
//         "_downloadCurrencySymbol response ${jsonEncode(response)}");
//     if (response.currencySymbol != null) {
//       sCurrency = response.currencySymbol ?? "RM";
//     }
//
//     ExtendedDisplayModel mExtendedDisplayModel = ExtendedDisplayModel(
//         args1: 'Customer Display',
//         args2: 100,
//         args3: true,
//         business: 'business_test',
//         mediaFiles: await getMediaFiles(),
//         getConfigurationResponse: mGetConfigurationResponse,
//         mColor: themeColour,
//         sCurrency: sCurrency,
//         sCartSummary: jsonEncode(mCartSummary),
//         logoPath: logoPath,
//     );
//     final WindowController window = await DesktopMultiWindow.createWindow(
//         jsonEncode(mExtendedDisplayModel));
//     window
//       ..setFrame(const Offset(0, 0) & const Size(800, 600))
//       ..center()
//       ..setTitle('Customer Display')
//       ..show();
//     return window;
//   }
//
//   @override
//   Future<bool> notifyCartUpdate(CartSummary cartSummary) async {
//     try {
//     mCartSummary = cartSummary;
//     final subWindowIds = await DesktopMultiWindow.getAllSubWindowIds();
//     for (final windowId in subWindowIds) {
//       MyLogUtils.logDebug("notifyCartUpdate to windowId : $windowId");
//       DesktopMultiWindow.invokeMethod(
//           windowId, 'broadcast', cartSummary.toJson());
//     }
//     return true;
//     }catch(e){
//       return false;
//     }
//   }
//
//   @override
//   Future<bool> notifyCounterStatus(bool isCounterOpen) async{
//     try {
//       final subWindowIds = await DesktopMultiWindow.getAllSubWindowIds();
//       for (final windowId in subWindowIds) {
//         MyLogUtils.logDebug("notifyCounterStatus to windowId : $windowId");
//         DesktopMultiWindow.invokeMethod(
//             windowId, 'counter_status', isCounterOpen);
//       }
//       return true;
//     }catch(e){
//       return false;
//     }
//   }
// }
