// ignore_for_file: depend_on_referenced_packages

import 'package:fnb_point_sale_base/printer/printer_helper.dart';
import 'package:fnb_point_sale_base/printer/types/open_cash_drawer_via_print_esc.dart';
import 'package:fnb_point_sale_base/utils/my_log_utils.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void printPdf() async {
  List<pw.Widget> widgets = getDocument();
  await printWidgets(widgets,false,false);
  // await Printing.layoutPdf(onLayout: (format) async => await doc.save());
}

void printPdfDirect(Printer printer) async {
  final doc = getDocument();
  var result = await Printing.directPrintPdf(
      printer: printer, onLayout: (format) async => await doc.save());
  MyLogUtils.logDebug("Auto print result  : $result");
}

getDocument() {
  return [
    pw.Center(
      child: pw.Text('1. Hello World'),
    ),
    pw.Container(height: 30),
    pw.Center(
      child: pw.Text('2. Hello World'),
    ),
    pw.Container(height: 30),
    pw.Center(
      child: pw.Text('3. Hello World'),
    ),
    pw.Container(height: 30),
    pw.Center(
      child: pw.Text('4. Hello World'),
    ),
    pw.Container(height: 30),
    pw.Center(
      child: pw.Text('5. Hello World'),
    ),
    pw.Container(height: 30),
    pw.Center(
      child: pw.Text('6. Hello World'),
    ),
    pw.Container(height: 30),
    pw.Center(
      child: pw.Text('7. Hello World'),
    ),
    pw.Container(height: 30),
    pw.Center(
      child: pw.Text('8. Hello World'),
    ),
    pw.Container(height: 30),
    pw.Center(
      child: pw.Text('9. Hello World'),
    ),
    pw.Container(height: 30),
    pw.Center(
      child: pw.Text('10. Hello World'),
    ),
    pw.Container(height: 30),
  ];
}

void openCashDrawer(Printer printer) async {
  openCashDrawerViaPrinter(printer.name);
}
