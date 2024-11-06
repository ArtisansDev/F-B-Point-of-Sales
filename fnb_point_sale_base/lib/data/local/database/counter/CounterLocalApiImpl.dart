// import 'dart:convert';
//
// import 'package:hive_flutter/hive_flutter.dart';
//
// import '../../../mode/entity/cases_model.dart';
// import 'CounterLocalApi.dart';
//
// class CounterLocalApiImpl extends CounterLocalApi {
//   final String _boxName = "counter";
//
//   Future<Box<dynamic>> _getBox() async {
//     await Hive.openBox(_boxName);
//     var box = Hive.box(_boxName);
//     return box;
//   }
//
//   @override
//   Future<void> saveCounter(CasesModel counter) async {
//     Box<dynamic> box = await _getBox();
//     box.put(_boxName, counter.toJson());
//   }
//
//   @override
//   Future<CasesModel?> getCounter() async {
//     Box<dynamic> box = await _getBox();
//     var content = box.get(_boxName);
//
//     if (content != null) {
//       String? encoded = json.encode(content);
//       Map<String, dynamic> decoded = json.decode(encoded);
//       CasesModel? counter = CasesModel.fromJson(decoded);
//       return Future.value(counter);
//     }
//
//     return Future.value(null);
//   }
//
//   @override
//   Future<bool> deleteCounter() async {
//     Box<dynamic> box = await _getBox();
//     await box.delete(_boxName);
//     return true;
//   }
//
//   @override
//   Future<void> clearBox() async {
//     var box = await _getBox();
//     await box.deleteFromDisk();
//   }
// }
