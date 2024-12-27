/// error : false
/// statusCode : 200
/// statusMessage : "Data Saved Successfully"
/// data : "24EA4165-CDE4-45EB-8A4C-9CBE4DB65C8F"

class ProcessOrderResponse {
  ProcessOrderResponse({
      this.error, 
      this.statusCode, 
      this.statusMessage, 
      this.data,});

  ProcessOrderResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'];
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  String? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['statusCode'] = statusCode;
    map['statusMessage'] = statusMessage;
    map['data'] = data;
    return map;
  }

}