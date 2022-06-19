import 'package:cloud_photo_gallery/core/failure/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_photo_list_failure.freezed.dart';

@freezed
class GetPhotoListFailure extends Failure with _$GetPhotoListFailure {
  const factory GetPhotoListFailure.server({required String message}) = Server;
  const factory GetPhotoListFailure.internet() = NoInternet;
}
