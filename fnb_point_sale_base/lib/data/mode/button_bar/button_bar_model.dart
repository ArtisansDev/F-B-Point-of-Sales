/*
 * Project      : fnb_point_sale_base
 * File         : button_bar_model.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-21
 * Version      : 1.0
 * Ticket       : 
 */

class ButtonBarModel {
  ButtonBarModel({
    String? imageAssets,
    String? buttonBarName,
  }) {
    _imageAssets = imageAssets;
    _buttonBarName = buttonBarName;
  }

  ButtonBarModel.fromJson(dynamic json) {
    _imageAssets = json['image_assets'];
    _buttonBarName = json['button_bar_name'];
  }

  String? _imageAssets;
  String? _buttonBarName;

  String? get imageAssets => _imageAssets;

  String? get buttonBarName => _buttonBarName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image_assets'] = _imageAssets;
    map['button_bar_name'] = _buttonBarName;
    return map;
  }
}
