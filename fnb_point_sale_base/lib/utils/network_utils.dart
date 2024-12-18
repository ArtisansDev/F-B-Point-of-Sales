import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  // Singleton approach
  static final NetworkUtils _instance = NetworkUtils._internal();

  factory NetworkUtils() => _instance;

  NetworkUtils._internal();

  var listenForNetwork = StreamController<bool>.broadcast();

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      // Vpn connection active.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      // Bluetooth connection available.
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      // Connected to a network which is not in the above mentioned networks.
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      // No available network types
    }
    return false;
  }

  bool isTypeCheck() {
    return (Platform.isAndroid || Platform.isIOS);
  }

}
