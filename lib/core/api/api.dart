import 'package:cloud_photo_gallery/core/api/api_response.dart';

abstract class Api {
  final int connectionTimeout = 5000; // Miliseconds

  Future<ApiResponse> get({
    required url,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParams,
  });
}
