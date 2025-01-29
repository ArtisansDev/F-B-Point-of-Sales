// import 'dart:async';
//
// ///partha paul
// ///periodic_service
// ///27/01/25
// class PeriodicService {
//   Timer? timer;
//
//   void startService() {
//     timer = Timer.periodic(Duration(minutes: 2), (timer) {
//       // Your logic here
//       print("Service called at ${DateTime.now()}");
//     });
//   }
//
//   void stopService() {
//     timer?.cancel();
//   }
// }