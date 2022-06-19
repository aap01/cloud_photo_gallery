import 'package:cloud_photo_gallery/feature/gallery/data/model/links_model.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/model/urls_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/photo.dart';

part 'photo_model.g.dart';

@JsonSerializable()
class PhotoModel extends Photo {
  @JsonKey(name: 'links')
  final LinksModel linksModel;
  @JsonKey(name: 'urls')
  final UrlsModel urlsModel;

  const PhotoModel({
    required super.id,
    required super.width,
    required super.height,
    required this.linksModel,
    required this.urlsModel,
  }) : super(
          links: linksModel,
          urls: urlsModel,
        );

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);
}
