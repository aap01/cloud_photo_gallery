import 'package:cloud_photo_gallery/feature/gallery/data/model/links_model.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/model/model.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/model/urls_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/photo.dart';

part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

@freezed
class PhotoModel with _$PhotoModel implements Model<Photo> {
  const PhotoModel._();
  const factory PhotoModel({
    String? id,
    int? width,
    int? height,
    String? color,
    @JsonKey(name: 'urls') UrlsModel? urlsModel,
    @JsonKey(name: 'links') LinksModel? linksModel,
  }) = _PhotoModel;

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  @override
  Photo toEntity() => Photo(
        id: id ?? '',
        width: width ?? 0,
        height: height ?? 0,
        urls: urlsModel?.toEntity(),
        links: linksModel?.toEntity(),
      );
}
