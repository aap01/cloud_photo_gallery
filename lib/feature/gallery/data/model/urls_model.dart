import 'package:cloud_photo_gallery/feature/gallery/data/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/urls.dart';

part 'urls_model.freezed.dart';
part 'urls_model.g.dart';

@freezed
abstract class UrlsModel extends Model<Urls> with _$UrlsModel {
  const factory UrlsModel({
    required String raw,
    required String full,
    required String regular,
    required String small,
    required String thumb,
    required String smallS3,
  }) = _UrlsModel;

  factory UrlsModel.fromJson(Map<String, dynamic> json) =>
      _$UrlsModelFromJson(json);

  @override
  Urls toEntity() => Urls(
        raw: raw,
        full: full,
        regular: regular,
        small: small,
        thumb: thumb,
        smallS3: smallS3,
      );
}
