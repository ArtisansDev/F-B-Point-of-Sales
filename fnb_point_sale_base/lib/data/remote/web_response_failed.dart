// error : true
// statusCode : 400
// statusMessage : "Bad Request"


class WebResponseFailed {
  WebResponseFailed({
    bool? error,
    int? statusCode,
    String? statusMessage,
  }) {
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
  }

  WebResponseFailed.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage']??json['Message'];
  }

  bool? _error;
  int? _statusCode;
  String? _statusMessage;

  bool? get error => _error;

  int? get statusCode => _statusCode;

  String? get statusMessage => _statusMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['statusCode'] = _statusCode;
    map['statusMessage'] = _statusMessage;
    return map;
  }
}
