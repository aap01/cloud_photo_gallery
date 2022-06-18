// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
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

  @override
  Stream<bool> connectionStream() async* {
    yield* Stream.periodic(
      const Duration(seconds: 2),
      (count) => isConnected(),
    ).asyncMap(
      (event) async => await event,
    );
  }
}
