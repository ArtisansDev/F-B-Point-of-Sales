import 'dart:convert';

import 'package:fnb_point_sale_base/data/mode/configuration/configuration_response.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'configuration_local_api.dart';


class ConfigurationLocalApiImpl extends ConfigurationLocalApi {
  final String _boxName = "configuration_details";

  Future<Box<dynamic>> _getBox() async {
    await Hive.openBox(_boxName);
    var box = Hive.box(_boxName);
    return box;
  }

  @override
  Future<void> save(ConfigurationResponse mConfigurationResponse) async {
    Box<dynamic> box = await _getBox();
    box.put(_boxName, mConfigurationResponse.toJson());
  }

  @override
  Future<ConfigurationResponse?> getConfigurationResponse() async {
    Box<dynamic> box = await _getBox();
    var content = box.get(_boxName);

    if (content != null) {
      String? encoded = json.encode(content);
      Map<String, dynamic> decoded = json.decode(encoded);
      ConfigurationResponse? configurationResponse = ConfigurationResponse.fromJson(decoded);
      return Future.value(configurationResponse);
    }

    return Future.value(null);
  }

  @override
  Future<bool> deleteAllCategory() async {
    Box<dynamic> box = await _getBox();
    await box.delete(_boxName);
    return true;
  }

  @override
  Future<void> clearBox() async {
    var box = await _getBox();
    await box.deleteFromDisk();
  }
  
}
