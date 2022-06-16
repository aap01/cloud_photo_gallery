import 'dart:io';

import 'package:cloud_photo_gallery/core/network/netowork_connection_checker.dart';

class NetworkConnectionCheckerImpl implements NetworkConnectionChecker {
  @override
  Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
