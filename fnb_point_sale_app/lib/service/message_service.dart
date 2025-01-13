// ///partha paul
// ///message_service
// ///13/01/25
// import 'dart:async';
// import 'package:fnb_point_sale_app/service/notification_service.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class MessageService {
//   static Timer? _timer;
//
//   static void startListening() {
//     _timer = Timer.periodic(Duration(minutes: 1), (_) async {
//       final response = await http.get(Uri.parse('https://your-api/messages'));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['title'] != null && data['body'] != null) {
//           NotificationService.showNotification(data['title'], data['body']);
//         }
//       }
//     });
//   }
//
//   static void stopListening() {
//     _timer?.cancel();
//   }
// }
