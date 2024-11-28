/*
 * Project      : MDM_base
 * File         : date_time_utils.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-10-23
 * Version      : 1.0
 * Ticket       : 
 */
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

getDateTimeFromMilliseconds(int milliseconds) {
  // Convert milliseconds to DateTime
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);

  // Format DateTime as you like (using intl package)
  String formattedDate = DateFormat('dd-MMM-yyyy HH:mm').format(dateTime);
  return formattedDate;
}

Future<DateTime?> selectDatePicker(BuildContext context,
    DateTime? selectedDate) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().add(const Duration(days: -1)),
      lastDate: DateTime(2101),
      initialEntryMode: DatePickerEntryMode.calendarOnly
  );
  if (picked != null && picked != selectedDate) {
    return picked;
  }
}

getDateDDMMYYYY(DateTime? selectedDate) {
  String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate!);
  return formattedDate;
}


Future<TimeOfDay?> selectTimePicker(BuildContext context,
    TimeOfDay? selectedTime) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: selectedTime ?? TimeOfDay.now(),
  );
  if (picked != null && picked != selectedTime) {
    return picked;
  }
}

getTime(TimeOfDay? selectedTime) {
  final hour = selectedTime!.hour % 12; // Convert hour to 12-hour format
  final formattedHour = hour == 0 ? 12 : hour; // Handle midnight and noon
  final period = selectedTime.hour < 12 ? 'AM' : 'PM'; // Determine AM or PM
  return '$formattedHour:${selectedTime.minute.toString().padLeft(
      2, '0')} $period';
}