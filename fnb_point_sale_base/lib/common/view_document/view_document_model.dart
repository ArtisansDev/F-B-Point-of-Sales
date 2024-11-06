/*
 * Project      : skill_360
 * File         : ViewDocumentModel.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-08-30
 * Version      : 1.0
 * Ticket       : 
 */

class ViewDocumentModel {
  ViewDocumentModel({
    String? mViewDocumentTitle,
    String? localFilePath,
  }) {
    _mViewDocumentTitle = mViewDocumentTitle;
    _localFilePath = localFilePath;
  }

  ViewDocumentModel.fromJson(dynamic json) {
    _mViewDocumentTitle = json['view_document_title'];
    _localFilePath = json['local_file_path'];
  }

  String? _mViewDocumentTitle;
  String? _localFilePath;

  String? get mViewDocumentTitle => _mViewDocumentTitle;

  String? get localFilePath => _localFilePath;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['view_document_title'] = _mViewDocumentTitle;
    map['local_file_path'] = _localFilePath;
    return map;
  }
}