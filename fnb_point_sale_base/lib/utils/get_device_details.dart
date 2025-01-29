import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../data/mode/update_login_status/update_login_status_request.dart';
import 'package:device_info_plus/device_info_plus.dart';

///partha paul
///get_device_details
///29/01/25
getDeviceDetails() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  DeviceInfo mDeviceInfo = DeviceInfo();
  String? deviceName = "";
  String? os = "";
  String? iPAddress = "";
  String? mACAddress = "";

  if (Platform.isMacOS) {
    MacOsDeviceInfo mMacOsDeviceInfo = await deviceInfo.macOsInfo;
    deviceName = mMacOsDeviceInfo.computerName;
    os = mMacOsDeviceInfo.osRelease;
  } else if (Platform.isWindows) {
    WindowsDeviceInfo mWindowsDeviceInfo = await deviceInfo.windowsInfo;
    deviceName = mWindowsDeviceInfo.computerName;
    os = mWindowsDeviceInfo.productName;
  } else {}
  final networkInfo = NetworkInfo();
  iPAddress = await networkInfo.getWifiIP();
  mACAddress = await networkInfo.getWifiBSSID();

  mDeviceInfo = DeviceInfo(
      deviceName: deviceName,
      iPAddress: iPAddress,
      mACAddress: mACAddress,
      os: os);
  debugPrint("DeviceInfo ${jsonEncode(mDeviceInfo)}");
  return mDeviceInfo;
}
