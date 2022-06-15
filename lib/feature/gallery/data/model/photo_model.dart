import 'package:cloud_photo_gallery/feature/gallery/data/model/links_model.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/model/model.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/model/urls_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/photo.dart';

part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

@freezed
abstract class PhotoModel extends Model<Photo> with _$PhotoModel {
  const factory PhotoModel({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime promotedAt,
    required int width,
    required int height,
    required String color,
    required String blurHash,
    required UrlsModel urlsModel,
    required LinksModel linksModel,
  }) = _PhotoModel;

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  @override
  Photo toEntity() => Photo(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        promotedAt: promotedAt,
        width: width,
        height: height,
        color: color,
        blurHash: blurHash,
        urls: urlsModel.toEntity(),
        links: linksModel.toEntity(),
      );
}
