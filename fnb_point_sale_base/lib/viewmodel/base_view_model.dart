import 'package:rxdart/rxdart.dart';

import '../locator.dart';
import '../serialportdevices/service/display_device_service.dart';
import '../utils/my_log_utils.dart';

const int cashPaymentId = 1;
const int creditNotePaymentId = 2;
const int bookingPaymentId = 3;
const int loyaltyPointPaymentId = 4;
const int giftCardPaymentId = 5;

// 20 CHARACTERS OF 2 LINES
const int maxCharactersAcceptedByDisplayDevice = 40;

const cashInTypeId = 1;
const cashOutTypeId = 2;
const refundBookingPaymentTypeId = 3;
const refundCreditNotesTypeId = 4;
const totalVoidSaleTypeId = 5;

class BaseViewModel {
  static double getAmountChangeDue = 0.00;

  void addError(PublishSubject responseSubject, Object e) {
    responseSubject.sink.addError(e);
  }

  Future<bool> createMessageForCustomerDisplay(String productName,
      String price) async {
    // KALMIA INSTANT HYACINTHS (M), RM 180.00
    var message = productName;
    var messageLength = productName.length;
    var priceLength = price.length + 1;
    // 1 extra for space in between name & price.

    if ((messageLength + priceLength) > maxCharactersAcceptedByDisplayDevice) {
      var neededProductNameLength =
          maxCharactersAcceptedByDisplayDevice - (priceLength + 3);
      // 3 extra to add 3 dots after product name
      message =
      "${productName.substring(0, neededProductNameLength)}... $price";
    } else {
      message = "$productName $price";
    }

    MyLogUtils.logDebug(
        "createMessageForCustomerDisplay message: $message & length : ${message
            .length}");

    return await sendMessageToDisplayDevice(message);
  }

  Future<bool> sendMessageToDisplayDevice(String message) async {
    var displayService = locator.get<DisplayDeviceService>();
    // Reset Device
    message = message.trim();
    await clearDisplayDeviceMessage(displayService);

    String emptySpaces = "";
    if (message.length < maxCharactersAcceptedByDisplayDevice) {
      int emptySpacesNeeded =
          maxCharactersAcceptedByDisplayDevice - message.length;
      for (int i = 0; i < emptySpacesNeeded; i++) {
        emptySpaces = " $emptySpaces";
      }
    }

    message = '$emptySpaces$message';

    if (message.length > maxCharactersAcceptedByDisplayDevice) {
      message = message.substring(0, maxCharactersAcceptedByDisplayDevice);
    }

    // KALMIA INSTANT HYACINTHS (M), RM 180.00
    return await displayService.sendMessage(message);
  }

  Future<void> clearDisplayDeviceMessage(
      DisplayDeviceService displayService) async {
    await displayService
        .sendMessage("                                        ");
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<bool> resetDisplayDevice() async {
    String thankYouMessage = "     Thank you!     .  Have a great day! ";
    return await sendMessageToDisplayDevice(thankYouMessage);
  }

}
