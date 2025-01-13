// ///partha paul
// ///notification_service
// ///13/01/25
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationService {
//   static final _notificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   static Future<void> initialize() async {
//     const InitializationSettings initializationSettings = InitializationSettings(
//       macOS: DarwinInitializationSettings(),
//       // windows: WindowsInitializationSettings(),
//     );
//
//     await _notificationsPlugin.initialize(initializationSettings);
//   }
//
//   static Future<void> showNotification(String title, String body) async {
//     const NotificationDetails details = NotificationDetails(
//       macOS: MacOSNotificationDetails(),
//       windows: WindowsNotificationDetails(),
//     );
//
//     await _notificationsPlugin.show(
//       0, // Notification ID
//       title,
//       body,
//       details,
//     );
//   }
// }
