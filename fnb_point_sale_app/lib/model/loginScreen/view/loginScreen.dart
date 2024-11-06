import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import '../controller/loginController.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());
    return Scaffold(body: loginView());
  }

  loginView() {
    return FocusDetector(
      onVisibilityGained: () {},
      onVisibilityLost: () {},
      child: Container(),
    );
  }
}
