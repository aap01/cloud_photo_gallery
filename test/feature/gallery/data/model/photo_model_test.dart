import 'package:cloud_photo_gallery/feature/gallery/data/model/links_model.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/model/photo_model.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/model/urls_model.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/photo.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/photo_map.dart';

void main() async {
  final photoMap = await getPhotoMap();
  final photoModel = PhotoModel(
    id: photoMap['id'],
    width: photoMap['width'],
    height: photoMap['height'],
    linksModel: LinksModel.fromJson(photoMap['links']),
    urlsModel: UrlsModel.fromJson(
      photoMap['urls'],
    ),
  );
  test(
    'PhotoModel is a subtype of Photo',
    () async {
      expect(photoModel, isA<Photo>());
    },
  );
  test(
    'PhotoModel.fromJson()',
    () async {
      final result = PhotoModel.fromJson(photoMap);
      expect(result, photoModel);
    },
  );
  test(
    'UrlsModel.toJson()',
    () async {
      final result = photoModel.toJson();
      expect(result, photoMap);
    },
  );
}
