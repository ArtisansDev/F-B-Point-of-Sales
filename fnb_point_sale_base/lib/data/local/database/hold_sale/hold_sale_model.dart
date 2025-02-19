import '../../../mode/cart_item/order_place.dart';

///partha paul
///hold_sale_model
///22/12/24

class HoldSaleModel {
  HoldSaleModel({
    List<OrderPlace>? mOrderPlace,}){
    _mOrderPlace = mOrderPlace;
  }

  HoldSaleModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _mOrderPlace = [];
      json['data'].forEach((v) {
        _mOrderPlace?.add(OrderPlace.fromJson(v));
      });
    }
  }
  
  List<OrderPlace>? _mOrderPlace;
  
  List<OrderPlace>? get mOrderPlace => _mOrderPlace;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mOrderPlace != null) {
      map['data'] = _mOrderPlace?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}