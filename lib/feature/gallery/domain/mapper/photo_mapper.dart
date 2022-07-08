import 'package:cloud_photo_gallery/feature/gallery/data/model/photo_model.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/photo.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/mapper/domain_mapper.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/mapper/links_mapper.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/mapper/urls_mapper.dart';

class PhotoMapper extends DomainMapper<Photo, PhotoModel> {
  @override
  Photo map(PhotoModel model) {
    return Photo(
      id: model.id,
      width: model.width,
      height: model.height,
      urls: UrlsMapper().map(model.urlsModel),
      links: LinksMapper().map(model.linksModel),
    );
  }
}
