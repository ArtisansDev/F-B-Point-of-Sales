import 'dart:typed_data';

import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/display_device_service.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/process_runner_service.dart';

import '../../data/local/database/serialport/serial_port_devices_api.dart';
import '../../locator.dart';
import '../../utils/my_log_utils.dart';

class DisplayDeviceServiceImpl with DisplayDeviceService {
  final tag = 'DisplayDeviceService';

  @override
  Future<bool> sendMessage(String message) async {
    var localApi = locator.get<SerialPortDevicesApi>();

    var device = await localApi.getMyDisplayDevice();

    if (device != null) {
      final port = SerialPort(device.address);

      await initDevice();

      MyLogUtils.logDebug("$tag, writeToDevice port is open: ${port.isOpen}");

      if (!port.isOpen) {
        port.openReadWrite();
      }

      MyLogUtils.logDebug("$tag, writeToDevice port is open: ${port.isOpen}");

      List<int> list = message.codeUnits;

      MyLogUtils.logDebug("$tag, writeToDevice list: $list");

      Uint8List bytes = Uint8List.fromList(list);

      //SerialPortReader reader = SerialPortReader(port, timeout: 10000);
      try {
        var writtenBytes = port.write(bytes);

        MyLogUtils.logDebug('writtenBytes : $writtenBytes');
        
        await Future.delayed(const Duration(seconds: 2));

        closeTheDevice(port);
      } on SerialPortError catch (_, err) {
        MyLogUtils.logDebug('writeToDevice err : $err');
        closeTheDevice(port);
      }
    }

    return false;
  }

  void closeTheDevice(SerialPort port) {
    if (port.isOpen) {
      port.close();
    }
    port.dispose();

    MyLogUtils.logDebug('closeTheDevice');
  }

  @override
  Future<bool> initDevice() async {
    var localApi = locator.get<SerialPortDevicesApi>();
    var device = await localApi.getMyDisplayDevice();

    if (device != null) {
      var processRunner = locator.get<ProcessRunnerService>();
      //Set the configuration Using process runner
      await processRunner
          .execute("mode ${device.address}: BAUD=9600 PARITY=N data=8 stop=1");
    }
    return true;
  }
}
