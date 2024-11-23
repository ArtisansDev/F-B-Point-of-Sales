import 'dart:convert';
import 'package:fnb_point_sale_base/data/local/database/printer/model/my_printer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'printer_local_api.dart';

class PrinterLocalApiImpl extends PrinterLocalApi {
  final String _boxName = "printersBox";
  final String _printerName = "primaryPrinter";

  Future<Box<dynamic>> _getBox() async {
    await Hive.openBox(_boxName);
    var box = Hive.box(_boxName);
    return box;
  }

  @override
  Future<bool> delete() async {
    Box<dynamic> box = await _getBox();
    await box.delete(_printerName);
    return true;
  }

  @override
  Future<MyPrinter?> getMyPrinter() async {
    Box<dynamic> box = await _getBox();
    var content = box.get(_printerName);

    if (content != null) {
      String? encoded = json.encode(content);
      Map<String, dynamic> decoded = json.decode(encoded);
      MyPrinter? myPrinter = MyPrinter.fromJson(decoded);
      return Future.value(myPrinter);
    }

    return Future.value(null);
  }

  @override
  Future<void> save(MyPrinter elements) async {
    Box<dynamic> box = await _getBox();
    await box.put(_printerName, elements.toJson());
  }
}
