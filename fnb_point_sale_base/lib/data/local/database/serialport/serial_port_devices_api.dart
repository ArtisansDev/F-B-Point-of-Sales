import 'package:fnb_point_sale_base/serialportdevices/model/my_serial_port_devices.dart';

abstract class SerialPortDevicesApi {
  /// Save
  Future<void> save(MySerialPortDevices element);

  /// Get My Display Device
  Future<MySerialPortDevices?> getMyDisplayDevice();

  /// Get May bank Display Device
  Future<MySerialPortDevices?> getMyPaymentTerminalDevice();

  /// Get affin bank Display Device
  Future<MySerialPortDevices?> getAffinPaymentTerminalDevice();

  /// Get Rakyet bank Display Device
  Future<MySerialPortDevices?> getRakyetPaymentTerminalDevice();

  /// Delete display device
  Future<bool> deleteDisplayDevice();

  /// Delete display device
  Future<bool> deletePaymentTerminalDevice();

  /// Delete display device
  Future<bool> deleteAffinPaymentTerminalDevice();

  /// Delete display device
  Future<bool> deleteRakyetPaymentTerminalDevice();
}
