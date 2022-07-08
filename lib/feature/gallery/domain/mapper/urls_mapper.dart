import 'package:cloud_photo_gallery/feature/gallery/data/model/urls_model.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/mapper/domain_mapper.dart';

import '../entity/urls.dart';

class UrlsMapper extends DomainMapper<Urls, UrlsModel> {
  @override
  Urls map(UrlsModel model) => Urls(
        raw: model.raw,
        full: model.full,
        regular: model.regular,
        small: model.small,
        thumb: model.thumb,
        smallS3: model.smallS3,
      );
}
