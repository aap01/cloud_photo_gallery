import 'package:cloud_photo_gallery/core/error_model/error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

@freezed
class ApiResponse with _$ApiResponse {
  const factory ApiResponse.error({
    required ErrorModel error,
  }) = Error;
  const factory ApiResponse.success({
    required dynamic response,
  }) = Success;
}
