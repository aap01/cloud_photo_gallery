import 'package:cloud_photo_gallery/core/constant/message_constants.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({
    this.message = MessageConstants.defaultServerFailureMessage,
  });

  @override
  List<Object?> get props => [message];
}
