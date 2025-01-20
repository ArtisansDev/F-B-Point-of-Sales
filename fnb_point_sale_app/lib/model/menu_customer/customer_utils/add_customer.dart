import 'package:fnb_point_sale_base/alert/app_alert.dart';
import 'package:fnb_point_sale_base/constants/message_constants.dart';
import 'package:fnb_point_sale_base/constants/web_constants.dart';
import 'package:fnb_point_sale_base/data/local/database/configuration/configuration_local_api.dart';
import 'package:fnb_point_sale_base/data/local/database/customer/customer_local_api.dart';
import 'package:fnb_point_sale_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_request.dart';
import 'package:fnb_point_sale_base/data/mode/customer/get_all_customer/get_all_customer_response.dart';
import 'package:fnb_point_sale_base/data/mode/customer/save/customer_save_request.dart';
import 'package:fnb_point_sale_base/data/remote/api_call/customer/customer_api.dart';
import 'package:fnb_point_sale_base/data/remote/web_response.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:fnb_point_sale_base/locator.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:fnb_point_sale_base/utils/network_utils.dart';
import 'package:get/get.dart';

///partha paul
///add_customer
///20/01/25

class AddCustomer {
  final Function onSelectCustomer;
  String name;
  String phoneCode;
  String phone;

  AddCustomer(
      {required this.onSelectCustomer,
      required this.name,
      required this.phoneCode,
      required this.phone});

  ///add new customer
  onSubmit() async {
    if (phone.trim().isEmpty) {
      AppAlert.showSnackBar(Get.context!, sPleaseEnterMobileNumber.tr);
    } else if (phone.trim().length < 9) {
      AppAlert.showSnackBar(Get.context!, sPleaseEnterValidMobileNumber.tr);
    } else if (name.trim().isEmpty) {
      AppAlert.showSnackBar(Get.context!, sPleaseEnterName.tr);
    } else {
      await callSaveCustomer();
    }
  }

  callSaveCustomer() async {
    ///api Customer call
    final customerApi = locator.get<CustomerApi>();
    var configurationLocalApi = locator.get<ConfigurationLocalApi>();
    ConfigurationResponse mConfigurationResponse =
        await configurationLocalApi.getConfigurationResponse() ??
            ConfigurationResponse();
    await NetworkUtils()
        .checkInternetConnection()
        .then((isInternetAvailable) async {
      if (isInternetAvailable) {
        CustomerSaveRequest mCustomerSaveRequest = CustomerSaveRequest(
            email: '',
            name: name,
            phoneCountryCode: '+$phoneCode',
            phoneNumber: phone,
            dateOfBirth: '',
            address: '',
            userIDF: await SharedPrefs().getUserId(),
            restaurantIDF:
                (mConfigurationResponse.configurationData?.restaurantData ?? [])
                        .isEmpty
                    ? ""
                    : (mConfigurationResponse
                                .configurationData?.restaurantData ??
                            [])
                        .first
                        .restaurantIDP);
        WebResponseSuccess mWebResponseSuccess =
            await customerApi.postCustomerSave(mCustomerSaveRequest);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          await callGetAllCustomer();
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

  ///get all Customer
  final customerLocalApi = locator.get<CustomerLocalApi>();

  callGetAllCustomer() async {
    try {
      ///api product call
      final customerApi = locator.get<CustomerApi>();
      var configurationLocalApi = locator.get<ConfigurationLocalApi>();
      ConfigurationResponse mConfigurationResponse =
          await configurationLocalApi.getConfigurationResponse() ??
              ConfigurationResponse();
      await NetworkUtils()
          .checkInternetConnection()
          .then((isInternetAvailable) async {
        if (isInternetAvailable) {
          GetAllCustomerRequest mGetAllCustomerRequest = GetAllCustomerRequest(
              pageNumber: 1,
              rowsPerPage: 0,
              restaurantIDF: (mConfigurationResponse
                              .configurationData?.restaurantData ??
                          [])
                      .isEmpty
                  ? ""
                  : (mConfigurationResponse.configurationData?.restaurantData ??
                          [])
                      .first
                      .restaurantIDP);
          WebResponseSuccess mWebResponseSuccess =
              await customerApi.postGetAllCustomer(mGetAllCustomerRequest);

          if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
            GetAllCustomerResponse mGetAllCustomerResponse =
                mWebResponseSuccess.data;
            await customerLocalApi.save(mGetAllCustomerResponse);

            ///GetAllCustomerResponse
            if ((mGetAllCustomerResponse
                        .getAllCustomerData?.getAllCustomerList ??
                    [])
                .isNotEmpty) {
              GetAllCustomerList mSelectCustomer = (mGetAllCustomerResponse
                          .getAllCustomerData?.getAllCustomerList ??
                      [])
                  .first;
              onSelectCustomer(mSelectCustomer);
              // mSelectCustomer.value = (mGetAllCustomerResponse
              //             .getAllCustomerData?.getAllCustomerList ??
              //         [])
              //     .first;
            }
            // mGetAllCustomerData.value =
            //     mGetAllCustomerResponse.getAllCustomerData ??
            //         GetAllCustomerData();
            // mAllCustomerList.value = [];
            // mAllCustomerList.value
            //     ?.addAll(mGetAllCustomerData.value?.getAllCustomerList ?? []);
            // mAllCustomerList.refresh();
            //
            // if ((mAllCustomerList.value ?? []).isNotEmpty) {
            //   (mSelectCustomerList.value ?? []).clear();
            //   mSelectCustomerList.refresh();
            //   selectPage();
            // }
          } else {
            AppAlert.showSnackBar(
                Get.context!, mWebResponseSuccess.statusMessage ?? '');
          }
        } else {
          AppAlert.showSnackBar(
              Get.context!, MessageConstants.noInternetConnection);
        }
      });
    } catch (e) {
      MyLogUtils.logDebug('downloadTableList failed with exception $e');
      AppAlert.showSnackBar(
          Get.context!, 'downloadTableList failed with exception $e');
    }
  }
}
