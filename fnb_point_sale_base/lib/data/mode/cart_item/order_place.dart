import 'package:fnb_point_sale_base/utils/date_time_utils.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:intl/intl.dart';

import 'cart_item.dart';

///partha paul
///order_place
///21/12/24
class OrderPlace {
  String userName = "";
  String userPhone = "";
  String seatIDP = "";
  String tableNo = "--";
  String dateTime = "";
  String sOrderNo = "";
  double subTotalPrice = 0.0;
  double totalPrice = 0.0;
  double taxAmount = 0.0;
  List<CartItem>? cartItem;


  OrderPlace({this.cartItem}){
    dateTime = DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now());
    sOrderNo = getRandomNumber();
  }

  OrderPlace.fromJson(dynamic json) {
    userName = json['userName']??'';
    userPhone = json['userPhone']??'';
    seatIDP = json['seatIDP']??'';
    tableNo = json['tableNo'];
    dateTime = json['dateTime'];
    sOrderNo = json['sOrderNo'];
    subTotalPrice = json['subTotalPrice'];
    totalPrice = json['totalPrice'];
    taxAmount = json['taxAmount'];
    if (json['cartItem'] != null) {
      cartItem = [];
      json['cartItem'].forEach((v) {
        cartItem?.add(CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = userName;
    map['userPhone'] = userPhone;
    map['seatIDP'] = seatIDP;
    map['tableNo'] = tableNo;
    map['dateTime'] = dateTime;
    map['sOrderNo'] = sOrderNo;
    map['subTotalPrice'] = subTotalPrice;
    map['totalPrice'] = totalPrice;
    map['taxAmount'] = taxAmount;
    if (cartItem != null) {
      map['cartItem'] = cartItem?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
