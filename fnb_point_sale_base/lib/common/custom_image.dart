import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/color_constants.dart';
import '../constants/image_assets_constants.dart';

cacheCoursesImage(String imageUrl, String placeHolderImagePath,double size) {
  debugPrint("image Url $imageUrl");
  return CachedNetworkImage(
    imageUrl: imageUrl,
    key: UniqueKey(),
    width: size,
    height: size,
    fit: BoxFit.cover,
    placeholder: (context, url) {
      return Image.asset(
        placeHolderImagePath,
        width: size,
        fit: BoxFit.fitWidth,
      );
    },
    errorWidget: (context, url, error) {
      return Image.asset(
        placeHolderImagePath,
        width: size,
        fit: BoxFit.fitWidth,
      );
    },
    imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
    )),
  );
}

svgImageSet(String assetName, double width, double height,
    {Color colour = Colors.black}) {
  return SvgPicture.asset(
    assetName,
    colorFilter: ColorFilter.mode(colour, BlendMode.srcIn),
    width: width,
    height: height,
  );
}

///Returns an [SVG] widgets
Widget svgView(String asset,
    {double? height, double? width, Color? color, Key? key}) =>
    SvgPicture.asset(
      asset,
      key: key,
      height: height,
      width: width,
      colorFilter: ColorFilter.mode(
        color ?? Colors.white,
        BlendMode.srcIn,
      ),
      matchTextDirection: true,
    );

svgImageSetNoColour(String assetName, double width, double height) {
  return SvgPicture.asset(
    assetName,
    width: width,
    height: height,
  );
}

editIcon(Function onTab) {
  return GestureDetector(
    onTap: () {
      onTab();
    },
    child: Container(
      height: 20.sp,
      width: 20.sp,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
          color: ColorConstants.cAppColors,
          borderRadius: BorderRadius.all(Radius.circular(8.sp))),
      child: Image.asset(
        ImageAssetsConstants.appLogo,
        fit: BoxFit.fitWidth,
      ),
    ),
  );
}

setImage(String image){
  return Image.asset(
    image,
    fit: BoxFit.fitWidth,
  );
}
