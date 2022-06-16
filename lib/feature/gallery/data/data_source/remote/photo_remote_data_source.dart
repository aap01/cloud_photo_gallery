import 'package:cloud_photo_gallery/core/api/api_response.dart';

abstract class PhotoRemoteDataSource {
  //Throws Server Exception
  Future<ApiResponse> fetchPhotos({
    required int page,
    required int perPage,
  });
}
