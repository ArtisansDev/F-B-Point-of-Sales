/*
 * Project      : MDM_base
 * File         : date_time_utils.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-10-23
 * Version      : 1.0
 * Ticket       : 
 */
import 'package:intl/intl.dart';

getDateTimeFromMilliseconds( int milliseconds){
  // Convert milliseconds to DateTime
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);

  // Format DateTime as you like (using intl package)
  String formattedDate = DateFormat('dd-MMM-yyyy HH:mm').format(dateTime);
  return formattedDate;
}