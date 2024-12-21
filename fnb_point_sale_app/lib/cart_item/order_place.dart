import 'package:fnb_point_sale_base/utils/date_time_utils.dart';
import 'package:fnb_point_sale_base/utils/num_utils.dart';
import 'package:intl/intl.dart';

import 'cart_item.dart';

///partha paul
///order_place
///21/12/24
class OrderPlace {
  String tableNo = "--";
  String dateTime = "";
  String sOrderNo = "";
  double subTotalPrice = 0.0;
  double totalPrice = 0.0;
  double taxAmount = 0.0;

  OrderPlace({this.cartItem}){
    dateTime = DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now());
    sOrderNo = getRandomNumber();
  }

  List<CartItem>? cartItem;
}
