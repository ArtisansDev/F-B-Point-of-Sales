import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import '../controller/shift_details_controller.dart';
import 'details/details_screen.dart';
import 'open_cash_drawer/open_cash_drawer_screen.dart';

class ShiftDetailsScreen extends GetView<ShiftDetailsController> {
  const ShiftDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ShiftDetailsController());
    controller.getAllDetails();
    return FocusDetector(
        onVisibilityGained: () {
          controller.onDeleteHoldSale();
          controller.postShiftDetailsApiCall();
        },
        onVisibilityLost: () {},
        child: const Row(
          children: [
            Expanded(flex: 9, child: DetailsScreen()),
            Expanded(flex: 4, child: OpenCashDrawerScreen())
          ],
        )

    );
  }
}
