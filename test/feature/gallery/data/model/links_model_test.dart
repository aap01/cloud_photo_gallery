import 'package:cloud_photo_gallery/feature/gallery/data/model/links_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/links_map.dart';

void main() async {
  test(
    'Links.fromJson()',
    () async {
      final result = LinksModel.fromJson(linksMap);
      expect(result, linksModel);
    },
  );
  test(
    'Links.toJson()',
    () async {
      final result = linksModel.toJson();
      expect(result, linksMap);
    },
  );
}
