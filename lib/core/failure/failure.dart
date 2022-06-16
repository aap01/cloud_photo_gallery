import 'package:cloud_photo_gallery/core/constant/message_constants.dart';

abstract class Failure {}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({
    this.message = MessageConstants.defaultServerFailureMessage,
  });
}

class JsonParsingFailure extends Failure {}

class NoInternetFalure extends Failure {}
