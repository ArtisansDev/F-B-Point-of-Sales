import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnb_point_sale_base/common/button_constants.dart';
import 'package:fnb_point_sale_base/common/text_input_widget.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/pattern_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/lang/translation_service_key.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/branch_manager_controller.dart';

class BranchManagerScreen extends GetView<BranchManagerController> {
  const BranchManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BranchManagerController());
    return Obx(
      () {
        return loginView();
      },
    );
  }

  loginView() {
    return FocusDetector(
      onVisibilityGained: () {
        // controller.getConfigurationInfo();
      },
      onVisibilityLost: () {},
      child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
              width: 30.w,
              padding: EdgeInsets.only(
                  top: 14.sp,
                  bottom: 14.sp,
                  left: 19.sp,
                  right: 19.sp),
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.circular(11.sp),
                // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    // Shadow color
                    spreadRadius: 1,
                    // Spread radius
                    blurRadius: 3,
                    // Blur radius
                    offset: const Offset(0,
                        0), // Shadow position (horizontal, vertical)
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 13.sp,
                  ),
                  Text(
                    'General manager credential',
                    // ${controller.mRestaurantData.value.restaurantName}',
                    style: getText600(
                        colors: ColorConstants.cAppButtonColour,
                        size: 14.sp),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.white,
                      borderRadius: BorderRadius.circular(8.sp),
                      // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          // Shadow color
                          spreadRadius: 1,
                          // Spread radius
                          blurRadius: 3,
                          // Blur radius
                          offset: const Offset(0,
                              0), // Shadow position (horizontal, vertical)
                        ),
                      ],
                    ),
                    child: TextInputWidget(
                      placeHolder: sEnterEmail.tr,
                      controller:
                      controller.userNameController.value,
                      errorText: null,
                      textInputType: TextInputType.emailAddress,
                      hintText: sEnterEmail.tr,
                      showFloatingLabel: false,
                      prefixIcon: Icons.email,
                      topPadding: 5.sp,
                      onFilteringTextInputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp(
                            AppUtilConstants
                                .patternEmailStringAtDot)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 13.sp,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.white,
                        borderRadius: BorderRadius.circular(8.sp),
                        // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            // Shadow color
                            spreadRadius: 1,
                            // Spread radius
                            blurRadius: 3,
                            // Blur radius
                            offset: const Offset(0,
                                0), // Shadow position (horizontal, vertical)
                          ),
                        ],
                      ),
                      child: TextInputWidget(
                          placeHolder: sPassword.tr,
                          controller:
                          controller.passwordController.value,
                          errorText: null,
                          textInputType: TextInputType.text,
                          hintText: sPasswordHint.tr,
                          showFloatingLabel: false,
                          prefixIcon: Icons.password,
                          suffixIcon:
                          controller.hidePassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onClick: (value) {
                            if (value == "suffixIcon") {
                              controller.hidePassword.value =
                              !controller.hidePassword.value;
                              controller.hidePassword.refresh();
                            }
                          },
                          topPadding: 5.sp,
                          hidePassword:
                          controller.hidePassword.value)),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Row(
                    children: [

                      Expanded(child:rectangleCornerButtonText600(
                        height: 19.5.sp,
                        textSize: 11.5.sp,
                        sAuthorize.tr,
                            () {
                          controller.isLoginCheck();
                        },
                      )),
                      SizedBox(width: 15.sp,),
                      Expanded(child: rectangleCornerButtonText600(
                        height: 19.5.sp,
                        textSize: 11.5.sp,
                        bgColor: Colors.white,
                        boderColor: ColorConstants.cAppButtonColour,
                        textColor: ColorConstants.cAppButtonColour,
                        sCancel.tr,
                            () {
                          Get.back();
                        },
                      )),
                    ],
                  )
                  ,
                  SizedBox(
                    height: 13.sp,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
