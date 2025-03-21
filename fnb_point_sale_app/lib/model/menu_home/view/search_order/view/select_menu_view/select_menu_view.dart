import 'package:flutter/material.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/image_assets_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../home_base_controller/home_base_controller.dart';

class SelectMenuView extends StatelessWidget {
  late HomeBaseController controller;
  SelectMenuView({super.key}) {
    controller = Get.find<HomeBaseController>();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 8.sp),
            decoration: BoxDecoration(
              color: ColorConstants.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8.sp),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.onClickHome();
                  },
                  child: Container(
                      margin:
                          EdgeInsets.only(left: 5.sp, top: 5.sp, bottom: 5.sp),
                      height: 22.sp,
                      width: 6.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorConstants.cAppButtonColour,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7.sp),
                          bottomLeft: Radius.circular(7.sp),
                        ),
                      ),
                      child: Text(
                        'HOME',
                        style: getText500(size: 11.sp),
                      )),
                ),
                Container(
                  height: 22.sp,
                  padding: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                  child: Image.asset(
                    ImageAssetsConstants.appArrow,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Expanded(
                    child: SizedBox(
                        height: 22.sp,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.selectGetAllCategory.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (){
                                  controller.switchCategory(index);
                                },
                                child: Container(
                                    padding: EdgeInsets.only(
                                        left: 15.sp, right: 15.sp),
                                    margin: EdgeInsets.only(left: 5.sp),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: (controller.selectGetAllCategory
                                            .length -
                                            1 ==
                                            index)
                                            ? ColorConstants.cAppColors
                                            : ColorConstants.cAppButtonColour,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7.sp))),
                                    child: Text(
                                      controller.selectGetAllCategory[index]
                                          .categoryName ??
                                          '',
                                      style: getText500(
                                        size: 11.sp,
                                      ),
                                    )),
                              );
                            })))
              ],
            ));
      },
    );
  }
}
