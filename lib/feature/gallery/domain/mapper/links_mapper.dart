import 'package:cloud_photo_gallery/feature/gallery/data/model/links_model.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/links.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/mapper/domain_mapper.dart';

class LinksMapper extends DomainMapper<Links, LinksModel> {
  Links map(LinksModel model) => Links(
        self: model.self,
        html: model.html,
        download: model.download,
        downloadLocation: model.downloadLocation,
      );
}
