import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:fnb_point_sale_base/constants/color_constants.dart';
import 'package:fnb_point_sale_base/constants/text_styles_constants.dart';
import 'package:fnb_point_sale_base/serialportdevices/serial_port_view_model.dart';
import 'package:fnb_point_sale_base/serialportdevices/model/my_serial_port_devices.dart';
import 'package:fnb_point_sale_base/serialportdevices/widgets/serial_port_device_row_widget.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/button_constants.dart';
import '../../common/my_ink_well_widget.dart';
import '../../lang/translation_service_key.dart';

class SerialPortDeviceConfigWidget extends StatefulWidget {
  const SerialPortDeviceConfigWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SerialPortDeviceConfigState();
  }
}

class _SerialPortDeviceConfigState extends State<SerialPortDeviceConfigWidget> {
  final viewModel = SerialPortViewModel();
  ScrollController _horizontalController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      // Blur effect
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: Container(
            color:
                Colors.black.withOpacity(0.2)), // Optional: Add overlay color
      ),
      Dialog(
        alignment: Alignment.center,
        backgroundColor: Colors.transparent,
        child: Container(
          width: 80.w,
          height: 85.h,
          decoration: BoxDecoration(
              color: ColorConstants.white,
              borderRadius: BorderRadius.circular(
                  8.sp) // use instead of BorderRadius.all(Radius.circular(20))
              ),
          padding: EdgeInsets.all(15.sp),
          child: Column(
            children: [
              getHeader(),
              SizedBox(
                height: 8.sp,
              ),
              const Divider(),
              SizedBox(
                  height: 30.h,
                  child: Scrollbar(
                    controller: _horizontalController,
                    thumbVisibility: true,
                    thickness: 3.0,

                    /// Nest the vertical 'Scrollbar' right below the horizontal one.
                    child: SingleChildScrollView(
                        controller: _horizontalController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 20, bottom: 10),
                              height: 250,
                              width: 350,
                              child: displayDeviceWidget(),
                            ),
                            Container(
                                margin: EdgeInsets.only(right: 20, bottom: 10),
                                height: 250,
                                width: 350,
                                child: mayBankTerminalWidget()),
                            Container(
                                margin: EdgeInsets.only(right: 20, bottom: 10),
                                height: 250,
                                width: 350,
                                child: affinBankTerminalWidget()),
                            Container(
                                margin: EdgeInsets.only(right: 20, bottom: 10),
                                height: 250,
                                width: 350,
                                child: rakyetBankTerminalWidget()),
                          ],
                        )),
                  )),
              const Divider(),
              const Text(
                'Search Serial Port Devices',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              Expanded(
                child: getAllSerialPortDevices(),
              ),
              SizedBox(width: 2.0.h),
              SizedBox(
                width: 10.w,
                child: rectangleCornerButtonText600(
                  textSize: 11.sp,
                  height: 19.sp,
                  sCancel.tr,
                  () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }

  ///Header
  Widget getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Serial Port Device Configuration',
            style: getText600(size: 13.5.sp, colors: ColorConstants.black))
      ],
    );
  }

  ///mayBankTerminal
  Widget mayBankTerminalWidget() {
    return Column(
      children: [
        Text('MayBank Terminal Device Detail',
            style: getText600(size: 13.sp, colors: ColorConstants.black)),
        Expanded(child: getMayBankTerminalDevice()),
        // const SizedBox(
        //   height: 5,
        // ),
        // MyInkWellWidget(
        //     child: const Text("Echo Test"),
        //     onTap: () {
        //       //sendEnquiryUsingWin32();
        //       viewModel.echoTextMayBankTerminal();
        //     })
      ],
    );
  }

  Widget getMayBankTerminalDevice() {
    return FutureBuilder(
        future: viewModel.getMyPaymentTerminalDevice(),
        builder: (BuildContext context, AsyncSnapshot<SerialPort?> snapshot) {
          if (snapshot.hasError) {
            return Text(
              "Failed to search serial port devices",
              style: Theme.of(context).textTheme.bodyLarge,
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return _deviceRowWidget(
                  snapshot.data!, deviceTypePaymentTerminal);
            }
            return Text(
              "May bank terminal device is not configured.",
              style: Theme.of(context).textTheme.bodyLarge,
            );
          }
          return const Text("Loading ...");
        });
  }

  ///affinBankTerminal
  Widget affinBankTerminalWidget() {
    return Column(
      children: [
        Text('Affin Terminal Device Detail',
            style: getText600(size: 13.sp, colors: ColorConstants.black)),
        Expanded(child: getAffinBankTerminalDevice()),
        // const SizedBox(
        //   height: 5,
        // ),
        // MyInkWellWidget(
        //     child: const Text("Echo Test"),
        //     onTap: () {
        //       //sendEnquiryUsingWin32();
        //       viewModel.echoTextAffinBankTerminal();
        //     })
      ],
    );
  }

  ///RakyetBankTerminal
  Widget rakyetBankTerminalWidget() {
    return Column(
      children: [
        Text('Rakyet Terminal Device Detail',
            style: getText600(size: 13.sp, colors: ColorConstants.black)),
        Expanded(child: getRakyetBankTerminalDevice()),
        // const SizedBox(
        //   height: 5,
        // ),
        // MyInkWellWidget(
        //     child: const Text("Echo Test"),
        //     onTap: () {
        //       //sendEnquiryUsingWin32();
        //       viewModel.echoTextRakyetBankTerminal();
        //     })
      ],
    );
  }

  Widget getAffinBankTerminalDevice() {
    return FutureBuilder(
        future: viewModel.getAffinPaymentTerminalDevice(),
        builder: (BuildContext context, AsyncSnapshot<SerialPort?> snapshot) {
          if (snapshot.hasError) {
            return Text(
              "Failed to search serial port devices",
              style: Theme.of(context).textTheme.bodyLarge,
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return _deviceRowWidget(
                  snapshot.data!, deviceTypeAffinPaymentTerminal);
            }
            return Text(
              "May bank terminal device is not configured.",
              style: Theme.of(context).textTheme.bodyLarge,
            );
          }
          return const Text("Loading ...");
        });
  }

  Widget getRakyetBankTerminalDevice() {
    return FutureBuilder(
        future: viewModel.getRakyetPaymentTerminalDevice(),
        builder: (BuildContext context, AsyncSnapshot<SerialPort?> snapshot) {
          if (snapshot.hasError) {
            return Text(
              "Failed to search serial port devices",
              style: Theme.of(context).textTheme.bodyLarge,
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return _deviceRowWidget(
                  snapshot.data!, deviceTypeRakyetPaymentTerminal);
            }
            return Text(
              "May bank terminal device is not configured.",
              style: Theme.of(context).textTheme.bodyLarge,
            );
          }
          return const Text("Loading ...");
        });
  }

  ///display device
  Column displayDeviceWidget() {
    return Column(
      children: [
        Text('Display Device Detail',
            style: getText600(size: 13.sp, colors: ColorConstants.black)),
        Expanded(child: getDisplayDevice())
      ],
    );
  }

  Widget getDisplayDevice() {
    return FutureBuilder(
        future: viewModel.getMyDisplayDevice(),
        builder: (BuildContext context, AsyncSnapshot<SerialPort?> snapshot) {
          if (snapshot.hasError) {
            return Text(
              "Failed to search serial port devices",
              style: Theme.of(context).textTheme.bodyLarge,
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return _deviceRowWidget(snapshot.data!, deviceTypeDisplay);
            }
            return Text(
              "Display device is not configured",
              style: Theme.of(context).textTheme.bodyLarge,
            );
          }
          return const Text("Loading ...");
        });
  }

  ///Search Serial Port Devices
  Widget getAllSerialPortDevices() {
    return FutureBuilder(
        future: viewModel.getAllSerialPorts(),
        builder:
            (BuildContext context, AsyncSnapshot<List<SerialPort>> snapshot) {
          if (snapshot.hasError) {
            return Text(
              "Failed to search serial port devices",
              style: Theme.of(context).textTheme.bodyLarge,
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return getRootWidget(snapshot.data!);
            }
            return Text(
              "No devices found",
              style: Theme.of(context).textTheme.bodyLarge,
            );
          }
          return const Text("Loading ...");
        });
  }

  Widget getRootWidget(List<SerialPort> allPrinters) {
    return ListView.builder(
        itemCount: allPrinters.length,
        itemBuilder: (BuildContext context, int index) {
          return _deviceRowWidget(allPrinters[index], allDeviceDisplay);
        });
  }

  Widget _deviceRowWidget(SerialPort port, String deviceType) {
    return SerialPortDeviceRowWidget(
      deviceType: deviceType,
      serialPort: port,
      saveDevice: _saveSerialPortDevices,
      deleteDevice: _deleteSerialPortDevices,
    );
  }

  Future<void> _saveSerialPortDevices(
      String deviceType, SerialPort port) async {
    await viewModel.saveDevice(deviceType, port);
    setState(() {});
  }

  Future<void> _deleteSerialPortDevices(
      String deviceType, SerialPort port) async {
    await viewModel.deleteDevice(deviceType, port);
    setState(() {});
  }
}
