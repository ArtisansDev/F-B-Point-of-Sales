import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:fnb_point_sale_base/serialportdevices/model/may_bank_payment_details.dart';
import 'package:fnb_point_sale_base/serialportdevices/serial_port_helper.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/affin_bank_terminal/affin_terminal_card_mapper.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/affin_bank_terminal/affin_terminal_helper.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/process_runner_service.dart';
import 'package:fnb_point_sale_base/serialportdevices/service/rakyat_bank_terminal/rakyet_terminal_card_mapper.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';

import '../../../data/local/database/serialport/serial_port_devices_api.dart';
import '../../../locator.dart';
import 'rakyet_bank_terminal_service.dart';

// Start of Text STX 0x02
// End of Text ETX 0x03
// Acknowledgement ACK 0x06
// Negative Acknowledgement NACK 0x15
/// Refer https://www.eso.org/~ndelmott/ascii.html for characters
class RakyetBankTerminalServiceImpl with RakyetBankTerminalService {
  final tag = "RakyetBankTerminalService";

  final stxAsInt = 2;
  final etxAsInt = 3;
  final enqAsInt = 5;
  final ackAsIn = 6;
  final nackAsIn = 15;

  final stx = '\x02';
  final etx = '\x03';
  final enq = '\x05';
  final ack = '\x06';
  final nack = '\x15';

  // statusCode & its description
  // Code	Description
  // Pay Account ID Optional 00
  // Transaction ID Mandatory 66
  // Response Text 02
  // Amount Mandatory 40
  // Cashback Amount Optional 42
  // Approval Code Optional 01
  // Invoice Number Mandatory 65
  // Trace Number Mandatory 64
  // Optional 29 Encrypted PAN (min 36, max 48)
  // Card No. Mandatory 30
  // Card Label Mandatory D4 Card preferred name, e.g. VISA / MasterCard
  // Cardholder Name Mandatory D5
  // Expiry Date Optional 31 YYMM
  // Card Issue Date Optional 32 YYMMDD
  // Member Expiry Date Optional 33 YYMM
  // Terminal ID Mandatory 16
  // Merchant No. Mandatory D1
  // Merchant Name Optional D0 3 lines of 23 characters (name & address)
  // Batch No. Mandatory 50 Optional for Wallet
  // Retrieval
  // Reference No.
  // Mandatory 06 Optional for Wallet
  // AID (EMV) Approved E0 Optional for Wallet
  // Application
  // Profile (EMV)
  // Approved E1 Optional for Wallet
  // CID (EMV) Approved E2 Optional for Wallet
  // Application
  // Cryptogram
  // (EMV)
  // Approved E3 Optional for Wallet
  // TSI (EMV) Approved E4 Optional for Wallet
  // TVR (EMV) Approved E5 Optional for Wallet
  // Card Entry Mode Optional E6 ‘10’ – chip card transaction
  // ‘20’ – contactless transaction
  // ‘30’ – swipe transaction
  // ‘40’ – fallback transaction
  // ‘50’ – manual transaction
  // ‘60’ – QR transaction
  // Transaction Date Optional 03 YYMMDD
  // Transaction Time Optional 04 HHmmss
  // Account Balance Optional 38
  // Card Issuer Name Optional D2

  // === Card Type  === //
  // Card Issuer Name, possible values are as below:
  // 1) VISA
  // 2) MASTERCARD
  // 3) AMEX
  // 4) UNIONPAY
  // 5) MyDebit

  @override
  Future<bool> initDevice() async {
    var localApi = locator.get<SerialPortDevicesApi>();
    var device = await localApi.getRakyetPaymentTerminalDevice();

    if (device != null) {
      var processRunner = locator.get<ProcessRunnerService>();
      //Set the configuration Using process runner
      await processRunner
          .execute("mode ${device.name}: BAUD=115200 PARITY=N data=8 stop=1");
    }
    return true;
  }

  @override
  Future<bool> echoTerminalTest() async {
    return false;
  }

  @override
  void requestPaymentAsync(double amount, Function onProcessCompleted) async {
    MyLogUtils.logDebug(
        type: LogType.RAKYAT,
        "requestPaymentAsync amount : $amount , "
        "_getAmountAsTwelveCharacters : ${_getAmountAsTwelveCharacters(amount)} , ");

    //Step 1: Fetch Rakyet Bank terminal device from local storage
    var localApi = locator.get<SerialPortDevicesApi>();
    var device = await localApi.getRakyetPaymentTerminalDevice();
    if (device == null) {
      MyLogUtils.logDebug(
          type: LogType.RAKYAT,
          "requestPaymentAsync=>Terminal is not configured ");
      onProcessCompleted(MayBankPaymentDetails(
          errorMessage:
              "Terminal is not configured.\nPlease contact IT team.\nIf payment is success, you can update payment manually in this pop up to complete the sale"));
    } else {
      await initDevice();
      final serialPortDevice = SerialPort(device.name);

      try {
        if (!serialPortDevice.isOpen) serialPortDevice.openReadWrite();

        //Step 2: create transportHeader
        ///transportHeader
        List<int> transportHeader = createTransportationHeader();

        //Step 3: create presentationHeader
        ///presentationHeader
        List<int> presentationHeader = createPresentationHeaderRakyat(
            transactionCode: "20", responseCode: "00");

        //Step 4: create fieldData
        ///fieldData
        List<int> fieldData = [];
        fieldData.addAll(createFieldData(
            fieldCode: "40", data: _getAmountAsTwelveCharacters(amount)));
        //Step 5: create message
        List<int> message =
            constructMessage(transportHeader, presentationHeader, fieldData);

        String inputCommand = listToHexString(message);

        MyLogUtils.logDebug(
            "$tag,echoTerminalTest inputCommand after lrc and stx : $inputCommand ");

        await _readAndAcknowledge(serialPortDevice, message, 9,
            (value, mUint8List) {
              //Step 6: waiting ACK
          if (value.toString().trim().toUpperCase() != ("ACK")) {
            closeTheDevice(serialPortDevice);

            List<String> mListValue = [];
            mListValue.addAll(value.split("FS"));

            String? cardNumber;
            String? cardNumberName;
            String? expiry;
            String? cardType;
            String? statusCode;
            String? traceNo;
            String? approvalCode;
            String? referenceNumber;
            String? batchNumber;
            String? hostNo;
            for (var element in mListValue) {
              if (element.trim().length > 3) {
                ///cardNumber
                if (element.trim().substring(0, 2).toUpperCase().trim() ==
                    "30") {
                  cardNumber = element.trim().substring(2).trim();
                }

                ///cardNumberName
                if (element.trim().substring(0, 2).toUpperCase().trim() ==
                    "D5") {
                  cardNumberName = element.trim().substring(2).trim().length > 1
                      ? element.trim().substring(2).trim()
                      : "-- & ---";
                }

                ///cardType
                if (element.trim().substring(0, 2).toUpperCase().trim() ==
                    "D2") {
                  cardType = getPaymentCardFromRakyetCode(
                      element.trim().substring(2).trim());
                }

                ///expiry
                if (element.trim().substring(0, 2).toUpperCase().trim() ==
                    "31") {
                  expiry = element.trim().substring(2).trim();
                }

                ///batchNumber
                if (element.trim().substring(0, 2).toUpperCase().trim() ==
                    "50") {
                  batchNumber =
                      element.trim().substring(2).trim().replaceAll("ACK", "");
                }

                ///approvalCode
                if (element.trim().substring(0, 2).toUpperCase().trim() ==
                    "01") {
                  approvalCode =
                      element.trim().substring(2).trim().replaceAll("ACK", "");
                }

                ///referenceNumber
                if (element.trim().substring(0, 2).toUpperCase().trim() ==
                    "D3") {
                  referenceNumber = element.trim().substring(2).trim();
                }

                ///traceNo
                if (element.trim().substring(0, 2).toUpperCase().trim() ==
                    "65") {
                  traceNo =
                      element.trim().substring(2).trim().replaceAll("ACK", "");
                }

                ///hostNo
                if (element.trim().substring(0, 2).toUpperCase().trim() ==
                    "50") {
                  hostNo =
                      element.trim().substring(2).trim().replaceAll("ACK", "");
                }

                ///statusCode
                if (element.trim().substring(0, 2).toUpperCase().trim() ==
                    "02") {
                  statusCode = element
                          .trim()
                          .substring(2)
                          .toUpperCase()
                          .trim()
                          .contains("APPROVED")
                      ? "00"
                      : "01";
                }
              }
            }

            MayBankPaymentDetails? paymentDetails = MayBankPaymentDetails(
                terminalName: "RAKYAT",
                cardNumber: cardNumber,
                cardNumberName: cardNumberName,
                cardType: cardType,
                expiry: expiry,
                batchNumber: batchNumber,
                referenceNumber: referenceNumber,
                approvalCode: approvalCode,
                traceNo: traceNo,
                hostNo: hostNo,
                statusCode: statusCode);

            if (statusCode == "00") {
              onProcessCompleted(paymentDetails);
            } else {
              onProcessCompleted(MayBankPaymentDetails(
                  errorMessage:
                      "Terminal is not configured.\nPlease contact IT team.\nIf payment is success, you can update payment manually in this pop up to complete the sale"));
            }
          }
        });
      } catch (e) {
        MyLogUtils.logDebug("$tag, echoTerminalTest exception : $e ");
        closeTheDevice(serialPortDevice);
        onProcessCompleted(MayBankPaymentDetails(
            errorMessage:
                "Terminal is not configured.\nPlease contact IT team.\nIf payment is success, you can update payment manually in this pop up to complete the sale"));
      }
    }
  }

  @override
  Future<bool> closeThePort() async {
    var localApi = locator.get<SerialPortDevicesApi>();
    var device = await localApi.getRakyetPaymentTerminalDevice();
    MyLogUtils.logDebug(
        "$tag, echoTerminalTest serialPortDevice address : ${device?.address.toString()} ");
    if (device != null) {
      final serialPortDevice = SerialPort(device.address);
      closeTheDevice(serialPortDevice);
    }
    return true;
  }

  List<int> getRequestPaymentInput(
      bool triggerMayBankCard, bool triggerMayBankQrCode, double amount) {
    MyLogUtils.logDebug("\n'20’ PURCHASE\n");
    List<int> transportHeader = createTransportationHeader();
    List<int> presentationHeader = createPresentationHeaderRakyat(
        transactionCode: "20", responseCode: "00");
    List<int> fieldData =
        createFieldData(fieldCode: "00", data: "00000000000000000000");
    fieldData
        .addAll(createFieldData(fieldCode: "66", data: "00020230620090912971"));
    fieldData.addAll(createFieldData(
        fieldCode: "40", data: _getAmountAsTwelveCharacters(amount)));
    fieldData.addAll(createFieldData(fieldCode: "M1", data: "00"));

    List<int> message =
        constructMessage(transportHeader, presentationHeader, fieldData);
    String inputCommand = listToHexString(message);
    MyLogUtils.logDebug("Final Output: $inputCommand");

    return message;
  }

  void closeTheDevice(SerialPort serialPortDevice) {
    MyLogUtils.logDebug(
        type: LogType.RAKYAT,
        "$tag closeTheDevice is Open : ${serialPortDevice.isOpen} ");
    if (serialPortDevice.isOpen) {
      serialPortDevice.close();
    }
  }

  // Enquire & acknowledge the same
  Future<void> _readAndAcknowledge(SerialPort portDevice, List<int> data,
      int expectedLength, Function mFunction) async {
    MyLogUtils.logDebug(
        type: LogType.RAKYAT, "$tag, _readAndAcknowledge data : $data ");
    int writeResult = portDevice.write(Uint8List.fromList(data));

    MyLogUtils.logDebug(
        type: LogType.RAKYAT,
        "$tag,_readAndAcknowledge writeResult : $writeResult ");
    final reader = SerialPortReader(portDevice);
    await Future.delayed(const Duration(seconds: 2));
    reader.stream.listen((data) {
      String readResultAsString = rakyetBankConvertUInt8ListToString(data);
      MyLogUtils.logDebug(
          type: LogType.RAKYAT,
          " raw data $data &  readResultAsString: $readResultAsString");
      mFunction(readResultAsString, data);
    });
  }

  String _getAmountAsTwelveCharacters(double amount) {
    String amountStringWithNoDecimals = getStringWithTwoDecimal(amount);
    MyLogUtils.logDebug(
        "_getAmountAsTwelveCharacters amountStringWithNoDecimals =>$amountStringWithNoDecimals<=");

    // Get InValue is used to make sure its integer only.
    int amountInCents =
        getInValue(amountStringWithNoDecimals.replaceAll(".", ""));

    MyLogUtils.logDebug(
        "_getAmountAsTwelveCharacters amountInCents =>$amountInCents<=");

    String amountAsString = '$amountInCents';

    int length = amountAsString.length;

    MyLogUtils.logDebug(
        "_getAmountAsTwelveCharacters for =>$amount<= length $length");

    var price = '${_getZeros(12 - length)}$amountAsString';

    MyLogUtils.logDebug("_getAmountAsTwelveCharacters for $amount is $price");
    return price;
  }

  String _getZeros(int count) {
    String value = "";

    for (int i = 0; i < count; i++) {
      value = "${value}0";
    }

    return value;
  }
}
