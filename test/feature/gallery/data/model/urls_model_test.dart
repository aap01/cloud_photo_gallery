import 'package:cloud_photo_gallery/feature/gallery/data/model/urls_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/urls_map.dart';

void main() {
  final urlsModel = mappedUrlsModel;
  test(
    'UrlsModel.fromJson()',
    () async {
      final result = UrlsModel.fromJson(urlsMap);
      expect(result, urlsModel);
    },
  );
  test(
    'UrlsModel.toJson()',
    () async {
      final result = urlsModel.toJson();
      expect(result, urlsMap);
    },
  );
}
