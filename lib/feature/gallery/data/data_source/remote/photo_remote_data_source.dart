import 'package:cloud_photo_gallery/core/api/base_api.dart';

import '../../model/photo_model.dart';

abstract class PhotoRemoteDataSource extends BaseApi {
  String get photoListEndpoint;

  //Throws Server Exception
  Future<List<PhotoModel>> fetchPhotos({
    required int perPage,
    required int page,
  });
}
