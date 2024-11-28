// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/utils/date_time_utils.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:get/get.dart';
import '../../dashboard_screen/controller/dashboard_screen_controller.dart';

class ReservationTableSelectController extends GetxController {
  Rxn<DashboardScreenController> mDashboardScreenController =
      Rxn<DashboardScreenController>();
  Rx<TextEditingController> enterNameController = TextEditingController().obs;
  Rx<TextEditingController> sTableNoController = TextEditingController().obs;
  Rx<TextEditingController> sPhoneNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> scheduleController = TextEditingController().obs;
  Rx<TextEditingController> sDateToComeController = TextEditingController().obs;
  Rx<TextEditingController> sTimeToComeController = TextEditingController().obs;
  Rx<TextEditingController> notesController = TextEditingController().obs;
  RxBool isDineIn = true.obs;
  RxString orderNumber = '1234567890'.obs;
  Rxn<DateTime>? selectedDate = Rxn<DateTime>();
  Rxn<TimeOfDay>? selectedTime = Rxn<TimeOfDay>();

  ReservationTableSelectController() {
    if (Get.isRegistered<DashboardScreenController>()) {
      mDashboardScreenController.value = Get.find<DashboardScreenController>();
    }

    orderNumber.value = getRandomNumber();
  }

  void onCreateOrder() {
    Get.back();
  }



  void onTime() async{
    selectedTime!.value =
    await selectTimePicker(Get.context!, selectedTime!.value);
    if (selectedTime!.value != null) {
      sTimeToComeController.value.text = getTime(selectedTime!.value);
    }
  }

  void onDate() async {
    selectedDate!.value =
        await selectDatePicker(Get.context!, selectedDate!.value);
    if (selectedDate!.value != null) {
      sDateToComeController.value.text = getDateDDMMYYYY(selectedDate!.value);
    }
  }
}
