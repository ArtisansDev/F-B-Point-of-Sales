import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/data/mode/button_bar/button_bar_model.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'controller/button_view_controller.dart';

class ButtonView extends GetView<ButtonViewController> {
  const ButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ButtonViewController());
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 8.sp,  bottom: 8.sp),
        padding:
            EdgeInsets.only(top: 8.sp, left: 8.sp, right: 8.sp, bottom: 8.sp),
        // decoration: BoxDecoration(
        //   color: ColorConstants.white,
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(8.sp),
        //   ),
        // ),
        alignment: Alignment.center,
        child: Text('Powered by artisans Commerce Cloud',style: getText500(size: 12.sp,colors: ColorConstants.cAppColors),)
        // Wrap(
        //   children: List.generate(
        //     controller
        //         .mDashboardScreenController.value!.mButtonBarModel.value.length,
        //     (index) {
        //       ButtonBarModel mButtonBarModel = controller
        //           .mDashboardScreenController
        //           .value!
        //           .mButtonBarModel
        //           .value[index];
        //       return GestureDetector(
        //         onTap: () {
        //           controller.onTabButton(index);
        //         },
        //         child: Container(
        //             margin: EdgeInsets.only(
        //               right: 8.sp,
        //             ),
        //             padding: EdgeInsets.only(
        //                 left: 11.sp, right: 11.sp, top: 9.sp, bottom: 9.sp),
        //             decoration: BoxDecoration(
        //               color: ColorConstants.cAppButtonColour,
        //               borderRadius: BorderRadius.all(
        //                 Radius.circular(8.sp),
        //               ),
        //             ),
        //             child: Wrap(
        //               crossAxisAlignment: WrapCrossAlignment.center,
        //               alignment: WrapAlignment.center,
        //               children: [
        //                 Image.asset(
        //                   mButtonBarModel.imageAssets ?? '',
        //                   fit: BoxFit.fitWidth,
        //                   width: 11.5.sp,
        //                 ),
        //                 SizedBox(width: 8.sp,),
        //                 Text(
        //                   mButtonBarModel.buttonBarName ?? '',
        //                   style: getText500(size: 11.sp),
        //                 )
        //               ],
        //             )),
        //       );
        //     },
        //   ),
        // )
    );
  }
}
