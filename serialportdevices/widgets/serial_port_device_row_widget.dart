
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/my_data_container_widget.dart';
import '../../common/textfield/my_text_field_widget.dart';
import '../serial_port_view_model.dart';
import '../model/my_serial_port_devices.dart';

class SerialPortDeviceRowWidget extends StatefulWidget {
  final SerialPort serialPort;
  final String deviceType;
  final Function saveDevice;
  final Function deleteDevice;

  const SerialPortDeviceRowWidget({
    Key? key,
    required this.serialPort,
    required this.saveDevice,
    required this.deviceType,
    required this.deleteDevice,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SerialPortDeviceRowWidgetState();
  }
}

class _SerialPortDeviceRowWidgetState extends State<SerialPortDeviceRowWidget> {
  String writeResult = "";
  final viewModel = SerialPortViewModel();

  @override
  Widget build(BuildContext context) {
    return _deviceRowWidget(widget.serialPort);
  }

  Widget _deviceRowWidget(SerialPort port) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      child: MyDataContainerWidget(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Text('Name  : ${port.name} , Address : ${port.address}'),
          const SizedBox(
            height: 15,
          ),
          allDeviceDisplay == widget.deviceType
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        child: const Text(
                          "Save As May Bank",
                          style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                              color: Colors.blueGrey),
                        ),
                        onTap: () {
                          widget.saveDevice(deviceTypePaymentTerminal, port);
                        }),
                    const SizedBox(
                      width: 25,
                    ),
                    InkWell(
                        child: const Text(
                          "Save As Affin Bank",
                          style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                              color: Colors.blueGrey),
                        ),
                        onTap: () {
                          widget.saveDevice(
                              deviceTypeAffinPaymentTerminal, port);
                        }),
                    const SizedBox(
                      width: 25,
                    ),
                    InkWell(
                        child: const Text(
                          "Save As Bank Rakyat",
                          style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                              color: Colors.blueGrey),
                        ),
                        onTap: () {
                          widget.saveDevice(
                              deviceTypeRakyetPaymentTerminal, port);
                        }),
                    const SizedBox(
                      width: 25,
                    ),
                    InkWell(
                        child: const Text(
                          "Save As Display Device",
                          style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                              color: Colors.blueGrey),
                        ),
                        onTap: () {
                          widget.saveDevice(deviceTypeDisplay, port);
                        }),
                  ],
                )
              : const SizedBox(),
           SizedBox(
            height: allDeviceDisplay == widget.deviceType?15:0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: SizedBox(
                height: 21.sp,
                child: MyTextFieldWidget(
                    controller: TextEditingController(),
                    node: FocusNode(),
                    onSubmitted: (value) async {
                      int result = -1;
                      if (widget.deviceType == deviceTypeAffinPaymentTerminal) {
                        // result = await viewModel.writeToPaymentTerminal(value);
                      } else if (widget.deviceType ==
                          deviceTypePaymentTerminal) {
                        // result = await viewModel.writeToPaymentTerminal(value);
                      } else {
                        var resultBool =
                            await viewModel.sendMessageToDisplayDevice(value);
                        if (resultBool) {
                          result = 1;
                        }
                      }

                      setState(() {
                        writeResult = '$result';
                      });
                    },
                    hint: 'Test commands'),
              )),
              const SizedBox(
                width: 5,
              ),
              Expanded(child: Text('Write Result: $writeResult')),
              const SizedBox(
                width: 5,
              ),
              Expanded(child: Text('Signals : ${widget.serialPort.signals}'))
            ],
          ),
          allDeviceDisplay == widget.deviceType
              ? const SizedBox()
              : const SizedBox(
                  height: 10,
                ),
          allDeviceDisplay == widget.deviceType
              ? const SizedBox()
              : InkWell(
                  child: const Text(
                    "Delete Device",
                    style: TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        color: Colors.blueGrey),
                  ),
                  onTap: () {
                    widget.deleteDevice(widget.deviceType, port);
                  }),
        ],
      )),
    );
  }
}
