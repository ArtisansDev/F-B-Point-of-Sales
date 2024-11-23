import 'dart:typed_data';

import 'package:barcode/barcode.dart';
import 'package:fnb_point_sale_base/constants.dart';
import 'package:fnb_point_sale_base/printer/types/open_cash_drawer_via_print_esc.dart';
import 'package:fnb_point_sale_base/printer/types/printer_cut_via_print_esc.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';

// import 'package:package_info_plus/package_info_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../data/local/database/printer/model/my_printer.dart';
import '../data/local/database/printer/printer_local_api.dart';
import '../locator.dart';
import '../utils/num_utils.dart';
import 'printer_view_model.dart';

pw.Document createPDF(List<pw.Widget> allWidgets, bool isMultiPageNeeded) {
  final doc = pw.Document(
    version: PdfVersion.pdf_1_5,
    compress: false,
    pageMode: PdfPageMode.fullscreen,
  );

  const width = 2.65 * PdfPageFormat.inch;

  var height = isMultiPageNeeded ? (265.0 * PdfPageFormat.mm) : double.infinity;
  var pageFormat = PdfPageFormat(width, height);

  if (isMultiPageNeeded) {
    doc.addPage(pw.MultiPage(
      maxPages: 100,
      header: (context) {
        return pw.Container(
          height: 50,
        );
      },
      pageFormat: pageFormat,
      build: (pw.Context context) => allWidgets,
    ));
  } else {
    doc.addPage(pw.Page(
      pageFormat: pageFormat,
      build: (pw.Context context) => pw.Wrap(children: allWidgets),
    ));
  }

  return doc;
}

Future<bool> printWidgets(List<pw.Widget> widgets, bool isMultiPageNeeded,
    bool openCashDrawer) async {
  var localPrinter = locator.get<PrinterLocalApi>();

  MyPrinter? printer = await localPrinter.getMyPrinter();

  if (printer != null) {
    // Open cash drawer
    if (openCashDrawer) {
      await openCashDrawerViaPrinter(printer.name);
    }

    var result = await initiateAutomaticPrint(
      createPDF(widgets, isMultiPageNeeded),
      PrinterViewModel().getPrinterFromMyPrinter(printer),
    );

    await cutReceiptViaEsc(printer.name);

    if (!result) {
      return initiateManualPrint(createPDF(widgets, isMultiPageNeeded));
    }
    return true;
  } else {
    return initiateManualPrint(createPDF(widgets, isMultiPageNeeded));
  }
}

Future<Uint8List> getUint8List(pw.Document doc) async {
  return await doc.save();
}

Future<bool> initiateManualPrint(pw.Document doc) async {
  return await Printing.layoutPdf(onLayout: (format) async => await doc.save());
}

Future<bool> initiateAutomaticPrint(pw.Document doc, Printer printer) async {
  var result = await Printing.directPrintPdf(
      printer: printer, onLayout: (format) async => await doc.save());
  return result;
}

pw.TextStyle getSmallBoldTextStyle() {
  return pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6);
}

pw.TextStyle getBoldTextStyle() {
  return pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8);
}

pw.TextStyle getBoldTextStyleMedium() {
  return pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10);
}

pw.TextStyle getBoldTextStyleBig() {
  return pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16);
}

pw.TextStyle getNormalTextStyle() {
  return pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 8);
}

pw.TextStyle getSmallTextStyle() {
  return pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 6);
}

pw.Widget getLeftRightText(String text1, String text2) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.start,
    children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(2.0),
        child: pw.Text(text1, style: getNormalTextStyle()),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.all(2.0),
        child: pw.Text(text2, style: getNormalTextStyle()),
      )
    ],
  );
}

pw.Widget getLeftRightText1(String text1, String text2) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
    children: [
      pw.Expanded(
        flex: 1,
        child: pw.Padding(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(text1, style: getNormalTextStyle())),
        ),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.all(2.0),
        child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(text2, style: getNormalTextStyle())),
      )
    ],
  );
}

pw.Widget getLeftRightTextBold(String text1, String text2) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
    children: [
      pw.Expanded(
        flex: 1,
        child: pw.Padding(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(text1, style: getBoldTextStyle())),
        ),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.all(2.0),
        child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(text2, style: getBoldTextStyle())),
      )
    ],
  );
}

// List<pw.Widget> getStoreDetails(
//     Stores? store, String companyName, String registrationNumber) {
//   List<pw.Widget> pwWidgets = List.empty(growable: true);
//
//   // pwWidgets.add(pw.Container(height: 20));
//
//   pwWidgets.add(
//       pw.Center(child: pw.Text(companyName, style: getSmallBoldTextStyle())));
//
//   pwWidgets.add(pw.Center(
//       child: pw.Text(registrationNumber, style: getSmallBoldTextStyle())));
//
//   pwWidgets.add(pw.Container(height: 5));
//
//   pwWidgets.add(pw.Center(
//       child: pw.Text(_getStoreName(store), style: getNormalTextStyle())));
//
//   pwWidgets.add(pw.Center(
//       child: pw.Text(_addressLine1(store), style: getNormalTextStyle())));
//
//   pwWidgets.add(pw.Center(
//       child: pw.Text(_addressLine2(store), style: getNormalTextStyle())));
//
//   pwWidgets.add(pw.Center(
//       child: pw.Text(_cityPinCode(store), style: getNormalTextStyle())));
//
//   pwWidgets.add(
//       pw.Center(child: pw.Text(_phone(store), style: getNormalTextStyle())));
//
//   return pwWidgets;
// }


pw.Widget barCodeWidget(String value, {bool? drawText = false}) {
  var shouldDrawText = false;

  if (drawText != null && drawText == true) {
    shouldDrawText = true;
  }
  return pw.Center(
      child: pw.BarcodeWidget(
          data: value,
          barcode: Barcode.fromType(BarcodeType.Code128),
          width: 150,
          drawText: shouldDrawText,
          height: 30));
}

pw.Widget qrCodeWidget(String value) {
  return pw.Center(
      child: pw.BarcodeWidget(
          data: value,
          barcode: Barcode.qrCode(),
          width: 50,
          height: 50));
}
