//For example of verify '00' PAY account ID

//REQ DATA: 02 00 43 36 30 30 30 30 30 30 30 30 30 31 30 30 30 30 30 30 1c 30 30 00 20 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 1c 03 57

// STEP 1: Start Character STX: 02

// STEP 2: Length of 'Message Data' in BCD format: 00 43 (67 in decimal)

// STEP 3: Transport Header:
// Hex values: 36 30 30 30 30 30 30 30 30 30
// Structure breakdown:
// Transport Header Type: 36 30 (60 in ASCII)
// Transport Destination: 30 30 30 30 (0000 in ASCII)
// Transport Source: 30 30 30 30 (0000 in ASCII)

// STEP 4: Presentation Header:
// Hex values: 31 30 30 30 30 30 30 1C
// Structure breakdown:
// Format Version: 31 (1 in ASCII)
// Request Response Indicator: 30 (0 in ASCII)
// Transaction Code: 30 30 (00 in ASCII)
// Response Code: 30 30 (00 in ASCII)
// More to follow: 30 (0 in ASCII)
// End of Presentation Header: 1C

// STEP 5: Field Data:
// Hex values: 30 30 00 20 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 1C
// Structure breakdown:
// Field Code : 30 30 (00 in ASCII)
// Len (2 Bytes)  : 00 20 (20 in BCD format)
// Data  : 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 ((00000000000000000000 in ASCII))
// End of Field Data: 1C

// STEP 6: End of Message Data (ETX):
// Hex values: 03

// STEP 7:LRC (Checksum):
// Hex values: 57



import '../../../utils/my_log_utils.dart';

List<int> constructTransportHeader(String transportHeaderType,
    String transportDestination, String transportSource) {
  // Check if the provided values are valid
  if (transportHeaderType.length != 2 ||
      transportDestination.length != 4 ||
      transportSource.length != 4) {
    throw ArgumentError('Invalid input data');
  }

  // Start with an empty transport header
  List<int> transportHeader = [];

  // Add the transport header type
  transportHeader.addAll(transportHeaderType.codeUnits);

  // Add the transport destination
  transportHeader.addAll(transportDestination.codeUnits);

  // Add the transport source
  transportHeader.addAll(transportSource.codeUnits);

  return transportHeader;
}

List<int> constructPresentationHeader(
    String formatVersion,
    String requestResponseIndicator,
    String transactionCode,
    String responseCode,
    bool moreToFollow) {
  // Check if the provided values are valid
  if (formatVersion.length != 1 ||
      requestResponseIndicator.length != 1 ||
      transactionCode.length != 2 ||
      responseCode.length != 2) {
    throw ArgumentError('Invalid input data');
  }

  // Start with an empty presentation header
  List<int> presentationHeader = [];

  // Add the format version
  presentationHeader.addAll(formatVersion.codeUnits);

  // Add the request response indicator
  presentationHeader.addAll(requestResponseIndicator.codeUnits);

  // Add the transaction code
  presentationHeader.addAll(transactionCode.codeUnits);

  // Add the response code
  presentationHeader.addAll(responseCode.codeUnits);

  // Add the more to follow indicator
  presentationHeader.addAll(moreToFollow ? "1".codeUnits : "0".codeUnits);

  // Add the end of presentation header
  presentationHeader.add(0x1C);

  return presentationHeader;
}

List<int> constructFieldData(String fieldCode, String data) {
  // Check if the provided values are valid
  if (fieldCode.length != 2 || data.isEmpty) {
    throw ArgumentError('Invalid input data');
  }

  // Start with an empty field data
  List<int> fieldData = [];

  // Add the Field Code
  fieldData.addAll(fieldCode.codeUnits);

  int dataLength = data.codeUnits.length;
  // String asciiCharacter = String.fromCharCode(dataLength);
  // fieldData.addAll(asciiCharacter.codeUnits);
  // // Add the Len (Bytes) in BCD format
  var dataLenBCD = ((dataLength ~/ 10) << 4) | (dataLength % 10);

  int highByte = (dataLenBCD >> 8) & 0xFF;
  int lowByte = dataLenBCD & 0xFF;
  fieldData.add(highByte);
  fieldData.add(lowByte);

  // Add the Data
  fieldData.addAll(data.codeUnits);

  // Add the Separator
  fieldData.add(0x1C);

  return fieldData;
}

List<int> constructMessage(List<int> transportHeader,
    List<int> presentationHeader, List<int> fieldData) {
  if (transportHeader.length > 255 ||
      presentationHeader.length > 255 ) {
    throw ArgumentError('Invalid input data');
  }

  // Start Character STX
  List<int> result = [0x02];

  // Length of 'Message Data' in 2 bytes
  int messageLength =
      transportHeader.length + presentationHeader.length + fieldData.length;
  var dataLenBCD = ((messageLength ~/ 10) << 4) | (messageLength % 10);
  int highByte = (dataLenBCD >> 8) & 0xFF;
  int lowByte = dataLenBCD & 0xFF;
  result.add(highByte);
  result.add(lowByte);

  // Message Data
  result.addAll(transportHeader);
  result.addAll(presentationHeader);
  result.addAll(fieldData);

  // End Character ETX
  result.add(0x03);

  // Calculate LRC (Exclusive OR of each character of the message excluding STX but including ETX)
  int lrc = result.skip(1).fold(0, (acc, value) => acc ^ value);
  result.add(lrc);

  return result;
}

List<int> createTransportationHeader() {
  // Example usage:
  String transportHeaderType = '60';
  String transportDestination = '0000';
  String transportSource = '0000';

  List<int> transportHeader = constructTransportHeader(
      transportHeaderType, transportDestination, transportSource);
   MyLogUtils.logDebug("createTransportationHeader: ${listToHexString(transportHeader)}");
  return transportHeader;
}

String listToHexString(List<int> data) {
  return data.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(' ');
}

List<int> createPresentationHeader({String transactionCode = '00',String responseCode = '00'}) {
  // Example usage:
  String formatVersion = '1';
  String requestResponseIndicator = '0';
  bool moreToFollow = false;

  List<int> presentationHeader = constructPresentationHeader(formatVersion,
      requestResponseIndicator, transactionCode, responseCode, moreToFollow);
   MyLogUtils.logDebug("createPresentationHeader: ${listToHexString(presentationHeader)}");
  return presentationHeader;
}

List<int> createFieldData({String fieldCode = "00",String data = "00000000000000000000"}) {
  // Example usage:
  //30 30 00 20 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 1C
  List<int> fieldData = constructFieldData(fieldCode, data);
   MyLogUtils.logDebug("createFieldData: ${listToHexString(fieldData)}");
  return fieldData;
}
