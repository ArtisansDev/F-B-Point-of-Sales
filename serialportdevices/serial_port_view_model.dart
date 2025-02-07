import 'dart:convert';

import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:fnb_point_sale_base/data/local/database/serialport/serial_port_devices_api.dart';
import 'package:fnb_point_sale_base/serialportdevices/model/my_serial_port_devices.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/affin_bank_terminal/affin_bank_terminal_service.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/display_device_service.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/may_bank_terminal/may_bank_terminal_service.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:fnb_point_sale_base/viewmodel/base_view_model.dart';

import '../locator.dart';
import 'service/rakyat_bank_terminal/rakyet_bank_terminal_service.dart';

class SerialPortViewModel extends BaseViewModel {
  Future<List<SerialPort>> getAllSerialPorts() async {
    await Future.delayed(const Duration(seconds: 1));
    List<SerialPort> ports = List.empty(growable: true);
    List<String> availablePortAddresses = SerialPort.availablePorts;
    for (var address in availablePortAddresses) {
      final port = SerialPort(address);
      ports.add(port);
    }

    return Future(() => ports);
  }

  Future<SerialPort?> getMyDisplayDevice() async {
    var localApi = locator.get<SerialPortDevicesApi>();

    var device = await localApi.getMyDisplayDevice();

    if (device != null) {
      final port = SerialPort(device.address);
      return port;
    }
    return Future(() => null);
  }

  Future<SerialPort?> getMyPaymentTerminalDevice() async {
    var localApi = locator.get<SerialPortDevicesApi>();

    var device = await localApi.getMyPaymentTerminalDevice();

    if (device != null) {
      final port = SerialPort(device.address);
      return port;
    }
    return Future(() => null);
  }

  Future<SerialPort?> getAffinPaymentTerminalDevice() async {
    var localApi = locator.get<SerialPortDevicesApi>();

    var device = await localApi.getAffinPaymentTerminalDevice();

    if (device != null) {
      final port = SerialPort(
        device.name,
      );
      return port;
    }
    return Future(() => null);
  }

  Future<SerialPort?> getRakyetPaymentTerminalDevice() async {
    var localApi = locator.get<SerialPortDevicesApi>();

    var device = await localApi.getRakyetPaymentTerminalDevice();

    if (device != null) {
      final port = SerialPort(
        device.name,
      );
      return port;
    }
    return Future(() => null);
  }

  Future<SerialPort> saveDevice(String deviceType, SerialPort port) async {
    var localApi = locator.get<SerialPortDevicesApi>();

    MySerialPortDevices portDevices = MySerialPortDevices(
        name: port.name ?? "",
        address: port.address.toString(),
        deviceType: deviceType);
    await localApi.save(portDevices);

    return SerialPort(portDevices.address);
  }

  Future<void> deleteDevice(String deviceType, SerialPort port) async {
    var localApi = locator.get<SerialPortDevicesApi>();
    switch (deviceType) {
      case "display":
        await localApi.deleteDisplayDevice();
        break;
      case "paymentTerminal":
        await localApi.deletePaymentTerminalDevice();
        break;

      case "affinPaymentTerminal":
        await localApi.deleteAffinPaymentTerminalDevice();
        break;

      case "rakyetPaymentTerminal":
        await localApi.deleteRakyetPaymentTerminalDevice();
        break;
    }
  }

  Future<int> writeToDisplayDevice(String data, SerialPort port) async {
    var localApi = locator.get<DisplayDeviceService>();
    var device = await localApi.sendMessage(data);
    return device ? 1 : 0;
  }

  Future<int> echoTextMayBankTerminal() async {
    var mayBankTerminalService = locator.get<MayBankTerminalService>();
    var result = await mayBankTerminalService.echoTerminalTest();
    MyLogUtils.logDebug("echoTextMayBankTerminal result : $result");
    return -1;
  }

  Future<int> echoTextAffinBankTerminal() async {
    var affinBankTerminalService = locator.get<AffinBankTerminalService>();
    var result = await affinBankTerminalService.echoTerminalTest();
    MyLogUtils.logDebug("echoTextaffinBankTerminal result : $result");
    return -1;
  }

  Future<int> echoTextRakyetBankTerminal() async {
    var rakyetBankTerminalService = locator.get<RakyetBankTerminalService>();
    var result = await rakyetBankTerminalService.echoTerminalTest();
    MyLogUtils.logDebug("echoTextRakyetBankTerminal result : $result");
    return -1;
  }

  Future<bool> flushDisplayDevice() async {
    var localApi = locator.get<SerialPortDevicesApi>();

    var device = await localApi.getMyDisplayDevice();

    if (device != null) {
      final port = SerialPort(device.address);
      port.flush();
      return true;
    }
    return Future(() => false);
  }
}
