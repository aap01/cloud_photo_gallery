import 'package:cloud_photo_gallery/feature/gallery/data/model/links_model.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/model/urls_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/photo.dart';

part 'photo_model.g.dart';

@JsonSerializable()
class PhotoModel extends Photo {
  @JsonKey(name: 'links')
  LinksModel? linksModel;
  @JsonKey(name: 'urls')
  UrlsModel? urlsModel;

  PhotoModel({
    required super.id,
    required super.width,
    required super.height,
    this.linksModel,
    this.urlsModel,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);
}
