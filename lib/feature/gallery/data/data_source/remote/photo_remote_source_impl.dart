import 'package:cloud_photo_gallery/core/api/api.dart';
import 'package:cloud_photo_gallery/core/api/api_response.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/data_source/remote/photo_remote_data_source.dart';

class PhotoRemoteDataSourceImpl implements PhotoRemoteDataSource {
  late Api _api;
  static const _url = 'https://api.unsplash.com';
  static const _photosEndPoint = '/photos';

  PhotoRemoteDataSourceImpl({
    required Api api,
  }) {
    _api = api;
  }

  @override
  Future<ApiResponse> fetchPhotos({
    required int page,
    required int perPage,
  }) async =>
      _api.get(url: _url + _photosEndPoint);
}
