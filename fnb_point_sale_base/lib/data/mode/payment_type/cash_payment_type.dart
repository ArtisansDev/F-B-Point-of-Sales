/// Cash : {"Pay_Amount":"${   getDoubleValue(amountController.value.text).toStringAsFixed(2) }","Due_Amount":"${   mDueAmount.value.toStringAsFixed(2) }","Return_Amount":"${   mReturnAmount.value.toStringAsFixed(2) }"}

class CashPaymentType {
  CashPaymentType({
      Cash? cash,}){
    _cash = cash;
}

  CashPaymentType.fromJson(dynamic json) {
    _cash = json['Cash'] != null ? Cash.fromJson(json['Cash']) : null;
  }
  Cash? _cash;

  Cash? get cash => _cash;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cash != null) {
      map['Cash'] = _cash?.toJson();
    }
    return map;
  }

}

/// Pay_Amount : "${   getDoubleValue(amountController.value.text).toStringAsFixed(2) }"
/// Due_Amount : "${   mDueAmount.value.toStringAsFixed(2) }"
/// Return_Amount : "${   mReturnAmount.value.toStringAsFixed(2) }"

class Cash {
  Cash({
      String? payAmount, 
      String? dueAmount, 
      String? returnAmount,}){
    _payAmount = payAmount;
    _dueAmount = dueAmount;
    _returnAmount = returnAmount;
}

  Cash.fromJson(dynamic json) {
    _payAmount = json['Pay_Amount'];
    _dueAmount = json['Due_Amount'];
    _returnAmount = json['Return_Amount'];
  }
  String? _payAmount;
  String? _dueAmount;
  String? _returnAmount;

  String? get payAmount => _payAmount;
  String? get dueAmount => _dueAmount;
  String? get returnAmount => _returnAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Pay_Amount'] = _payAmount;
    map['Due_Amount'] = _dueAmount;
    map['Return_Amount'] = _returnAmount;
    return map;
  }

}