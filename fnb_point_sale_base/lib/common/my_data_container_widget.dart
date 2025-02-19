import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class MyDataContainerWidget extends StatelessWidget {
  final Widget child;
  final double? padding;

  const MyDataContainerWidget({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding == null ? 15.0 : padding!),
      decoration: BoxDecoration(
          color: ColorConstants.primaryBackgroundColor,
          border: Border.all(color: Theme
              .of(context)
              .dividerColor),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: child,
    );
  }
}
